require_relative '../lib/rspec_expectation_count'
require_relative '../lib/rspec_expectation_count/expectation_debug'
require 'rubygems'
require 'waiting_rspec_matchers'

RSpec.configure { |c| c.include WaitingRspecMatchers }

def assert_true
  expect(1).to eq(1)
end

describe 'count' do
  it 'rejects duplicate specs' do
    @count = 0

    # this should count as 1 expectation instead of 6
    expect { @count += 1 }.to become_eq(5)

    # these should count as one expectation each
    assert_true
    assert_true
    assert_true
    assert_true

    # expectation count should be 5 (1 become_eq, 4 assert_true)
  end
end
