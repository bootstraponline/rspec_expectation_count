unless ::RSpec::Expectations.respond_to?(:expectation_count)
  module RSpec
    module Expectations
      class << self
        def expectation_count
          @expectation_count ||= 0
        end

        def update_expectation_count
          @expectation_count = expectation_count + 1
        end

        def expectation_debug
        end

        def update_expectation_debug
        end
      end # class << self

      # with waiting rspec matchers, it's not sufficient to just count
      # the amount of times an expectation is handled. Instead we need to
      # count at the level of the `WaitingRspecMatchers` abstraction.
      #
      # from rspec's perspective the expect logic is invoked multiple times
      # which leads to duplicates if we count at the rspec level.
    end
  end

  module WaitingRspecMatchers
    class Become
      alias_method :old_match_helper, :match_helper

      def match_helper(*args, &block)
        ::RSpec::Expectations.update_expectation_count
        ::RSpec::Expectations.update_expectation_debug
        old_match_helper(*args, &block)
      end
    end
  end

# Print expectation count by default via base text formatter dump_summary
  module RSpec
    module Core
      module Formatters
        class BaseTextFormatter < BaseFormatter
          alias_method :old_dump_summary, :dump_summary

          def dump_summary(*args)
            old_dump_summary(*args)
            count  = ::RSpec::Expectations.expectation_count
            plural = count == 1 ? '' : 's'
            output.puts "#{count} expectation#{plural}"
            output.puts ::RSpec::Expectations.expectation_debug
          end
        end
      end
    end
  end
end # unless ::RSpec::Expectations.respond_to?(:expectation_count)
