require 'rubygems'
require 'rspec'
require 'rspec/matchers'
require 'rspec/expectations/handler'
require 'rspec/core/formatters/base_text_formatter'
require 'rspec/expectations/expectation_target'
# https://github.com/rspec/rspec-core/issues/740

unless ::RSpec::Expectations.respond_to?(:expectation_count)
  module RSpec
    module Expectations
      class ExpectationTarget
        alias_method :old_initialize, :initialize

        def initialize(*args)
          old_initialize(*args)
          ::RSpec::Expectations.update_expectation_count
        end
      end

      class << self
        def expectation_count
          @expectation_count ||= 0
        end

        def update_expectation_count
          @expectation_count = expectation_count + 1
        end

        def expectation_debug
        end
      end # class << self

      # with waiting rspec matchers, it's not sufficient to just count
      # the amount of times an expectation is handled. instead we need to
      # dedupe and count each expectation exactly once (exluding retries)
      #
      # this logic relies on trace points so it's handled in the optional
      # expectation_debug.rb file
      # class PositiveExpectationHandler
      # class NegativeExpectationHandler
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
