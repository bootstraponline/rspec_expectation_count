require_relative '../lib/rspec_expectation_count'

describe 'count' do
  it 'tracks the amount of expects' do
    expect(1).to eq(1)
    expect(2).not_to eq(3)
  end
end
