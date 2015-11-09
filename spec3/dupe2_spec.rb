require_relative '../lib/rspec_expectation_count'
require_relative '../lib/rspec_expectation_count/expectation_debug'
require 'rubygems'
require 'waiting_rspec_matchers'
require_relative 'assert'

RSpec.configure { |c| c.include WaitingRspecMatchers }

describe 'count' do
  it 'rejects duplicate specs' do
    assert_test
  end
end
