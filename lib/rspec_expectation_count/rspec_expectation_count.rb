require 'rubygems'
require 'rspec'
require 'rspec/matchers'
require 'rspec/expectations/handler'
require 'rspec/core/formatters/base_text_formatter'

# https://github.com/rspec/rspec-core/issues/740

unless ::RSpec::Expectations.respond_to?(:expectation_count)
  module RSpec
    module Expectations
      class << self
        def expectation_count
          @expectation_count ||= 0
        end

        attr_writer :expectation_count
      end

      class PositiveExpectationHandler
        class << self
          alias_method :old_handle_matcher, :handle_matcher

          def handle_matcher(*args)
            ::RSpec::Expectations.expectation_count += 1
            old_handle_matcher(*args)
          end
        end
      end

      class NegativeExpectationHandler
        class << self
          alias_method :old_handle_matcher, :handle_matcher

          def handle_matcher(*args)
            ::RSpec::Expectations.expectation_count += 1
            old_handle_matcher(*args)
          end
        end
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
          end
        end
      end
    end
  end
end # unless ::RSpec::Expectations.respond_to?(:expectation_count)
