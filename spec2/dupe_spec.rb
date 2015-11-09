require_relative 'spec_helper'

def assert_true
  expect { 1 }.to become_eq(1)
end

describe 'count' do
  it 'rejects duplicate specs' do # 5 expectations
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
