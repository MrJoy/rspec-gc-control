require 'rspec/core/formatters/base_formatter'

module RSpec
  module Core
    module Formatters

      class BaseTextFormatter < BaseFormatter

        def dump_summary(duration, example_count, failure_count, pending_count)
          super(duration, example_count, failure_count, pending_count)
          # Don't print out profiled info if there are failures, it just clutters the output
          dump_profile if profile_examples? && failure_count == 0
          output.print "\nFinished in #{format_duration(duration)}"

          gc_times = examples.map { |ex| ex.execution_result[:gc_time] }.select { |t| !t.nil? && (t > 0) }
          if(gc_times.count > 0)
            gc_count = gc_times.count
            gc_time = gc_times.reduce(:+)
            output.print " (including #{gc_count} forced GC cycle(s), totalling #{format_duration(gc_time)})"
          end
          output.print "\n"
          output.puts colorise_summary(summary_line(example_count, failure_count, pending_count))
          dump_commands_to_rerun_failed_examples
        end

      end
    end
  end
end
