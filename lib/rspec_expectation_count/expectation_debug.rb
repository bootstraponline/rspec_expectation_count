unless ::RSpec::Expectations.expectation_debug.is_a?(Array)
  module RSpec
    module Expectations
      class << self
        def expectation_debug
          @expectation_debug ||= []
        end

        attr_accessor :current_expect, :last_expect
        attr_accessor :last_spec_line, :current_spec_line

        PWD = Dir.pwd

        TracePoint.new do |trace|
          file_path = trace.path
          if file_path.include?(PWD)
            line_number = trace.lineno

            # track last spec line for deduping expects
            if file_path.end_with?('_spec.rb')
              ::RSpec::Expectations.last_spec_line    = ::RSpec::Expectations.current_spec_line
              ::RSpec::Expectations.current_spec_line = line_number
            end

            line = IO.readlines(file_path)[line_number - 1]
            if line.match(/expect\s*[\{\(]/) # expect () || expect { }
              expect_hash                          = { file: file_path, line: line.strip, line_number: line_number }
              ::RSpec::Expectations.last_expect    = ::RSpec::Expectations.current_expect
              ::RSpec::Expectations.current_expect = expect_hash
            end
          end
        end.enable

        def update_expectation_count
          # if we've previously seen the expect and haven't advanced to the next spec line
          # then it's most likely a duplicate execution.
          return if (current_expect == last_expect) && (last_spec_line == current_spec_line)
          @expectation_count = expectation_count + 1
          update_expectation_debug
        end

        def update_expectation_debug
          expectation_debug << current_expect
        end
      end
    end
  end
end
