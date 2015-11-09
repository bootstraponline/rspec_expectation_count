require_relative 'spec_helper'
require_relative '../lib/rspec_expectation_count/expectation_debug'

describe 'count' do
  it 'tracks the amount of expects' do
    # 1
    # 2
    # 3
    expect { 1 }.to become_eq(1)
    # 4
    expect { 2 }.not_to become_eq(3)
    # 5
  end
end
