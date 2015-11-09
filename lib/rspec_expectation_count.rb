require 'rubygems'
require 'rspec'
require 'rspec/matchers'
require 'rspec/expectations/handler'
require 'rspec/core/formatters/base_text_formatter'
require 'rspec/expectations/expectation_target'
# https://github.com/rspec/rspec-core/issues/740
require 'waiting_rspec_matchers'

require_relative 'rspec_expectation_count/rspec_expectation_count'
require_relative 'rspec_expectation_count/version'
