require 'rubygems'
require 'rspec'
require 'rspec/matchers'
require 'rspec/expectations/handler'
require 'rspec/core/formatters/base_text_formatter'
require 'pry'
# https://github.com/rspec/rspec-core/issues/740

unless ::RSpec::Expectations.expectation_debug.is_a?(Array)
  module RSpec
    module Expectations
      class << self
        def expectation_debug
          @expectation_debug ||= []
        end

        attr_accessor :last_spec_hash

        TracePoint.new do |trace|
          file_path = trace.path
          if file_path.end_with?('_spec.rb')
            line_number = trace.lineno
            line        = IO.readlines(file_path)[line_number - 1]
            if line.include?('expect') # expect() || expect { }
              expect_hash                          = { file: file_path, line: line.strip, line_number: line_number }
              ::RSpec::Expectations.last_spec_hash = expect_hash
            end
          end
        end.enable

        def update_expectation_debug
          expectation_debug << last_spec_hash
        end
      end
    end
  end
end
