require_relative '../lib/rspec_expectation_count'
require_relative '../lib/rspec_expectation_count/expectation_debug'
require_relative 'assert'

describe 'count' do
  it 'tracks expects outside spec files' do
    assert_true
  end
end
