unless ::RSpec::Expectations.expectation_debug.is_a?(Array)
  module RSpec
    module Expectations
      class << self
        def expectation_debug
          @expectation_debug ||= []
        end

        attr_accessor :current_expect

        PWD = Dir.pwd

        TracePoint.new do |trace|
          file_path = trace.path
          if file_path.include?(PWD)
            line_number = trace.lineno
            line        = IO.readlines(file_path)[line_number - 1]
            if line.match(/expect\s*[\{\(]/) # expect () || expect { }
              expect_hash                          = { file: file_path, line: line.strip, line_number: line_number }
              ::RSpec::Expectations.current_expect = expect_hash
            end
          end
        end.enable

        def update_expectation_debug
          expectation_debug << current_expect
        end
      end
    end
  end
end
