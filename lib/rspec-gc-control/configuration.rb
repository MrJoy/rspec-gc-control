require 'rspec/core/configuration'

module RSpec
  module Core
    # Extensions to RSpec::Core::Configuration to allow configuration of
    # desired GC behavior.
    class Configuration
      # @private
      define_reader :gc_every_n_examples

      # @private
      alias_method :initialize_without_gc, :initialize

      # Overridden constructor to initialize `gc_every_n_examples` to 0.
      # This disables the explicit GC control.
      def initialize
        initialize_without_gc
        @gc_every_n_examples = 0
      end

      # @private
      def gc_if_needed
        gc_time = 0
        if(@gc_every_n_examples > 0)
          @test_counter = -1 if(!defined?(@test_counter))
          @test_counter += 1
          if(@test_counter >= (@gc_every_n_examples - 1))
            t_before = Time.now
            GC.enable
            GC.start
            GC.disable
            gc_time = Time.now - t_before

            @test_counter = 0
          end
        end
        return gc_time
      end

      # If set to a value above 0, turns automatic GC off and runs it only
      # every N tests, which can result in higher peak memory usage but lower
      # total execution time.
      def gc_every_n_examples=(n)
        if(defined?(JRuby))
          warn "Ignoring gc_every_n_examples because JRuby doesn't support GC control."
          return
        end
        if(!GC.respond_to?(:count))
          warn "Ignoring gc_every_n_examples because this Ruby implementation doesn't implement GC.count."
          return
        end
        @gc_every_n_examples = n
        if(@gc_every_n_examples > 0)
          GC.disable
        else
          GC.enable
        end
      end

    end
  end
end
