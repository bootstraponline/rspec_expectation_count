require 'rubygems'
require 'waiting_rspec_matchers'
require_relative '../lib/rspec_expectation_count'
require_relative 'assert'

RSpec.configure { |c| c.include WaitingRspecMatchers }
