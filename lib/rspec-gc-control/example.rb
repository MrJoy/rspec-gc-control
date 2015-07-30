require 'rspec/core/example'

module RSpec
  module Core
    # Extensions to RSpec::Core::Example to perform explicit GC and capture
    # GC execution time.
    class Example
    private

      if defined?(::RSpec::Core) && ::RSpec::Core::Version::STRING >= '3.0.0'
        alias_method :run_after_example_without_gc, :run_after_example

        def run_after_example
          run_after_example_without_gc
        ensure
          RSpec.configuration.gc_if_needed
        end
      else
        undef :record_finished
        def record_finished(status, results={})
          finished_at = Time.now
          record results.merge(:status => status, :finished_at => finished_at, :run_time => (finished_at - (execution_result[:started_at] + (execution_result[:gc_time] || 0))))
        end

        alias_method :run_after_each_without_gc, :run_after_each

        def run_after_each
          run_after_each_without_gc
        ensure
          execution_result[:gc_time] = RSpec.configuration.gc_if_needed
        end
      end

    end
  end
end
