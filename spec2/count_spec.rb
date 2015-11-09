require_relative 'spec_helper'

describe 'count' do
  it 'tracks the amount of expects' do
    expect { 1 }.to become_eq(1)
    expect { 2 }.not_to become_eq(3)
  end
end
