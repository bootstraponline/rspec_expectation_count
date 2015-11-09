require 'pry'

describe 'rspec expectation count' do
  it 'prints an expectation count' do
    output = `rspec spec2/count_spec.rb`
    expect(output).to match '2 expectations'
  end

  it 'prints expectation debug info' do
    output = `rspec spec2/count2_spec.rb`

    expected = [
      'count2_spec.rb", :line=>"expect { 1 }.to become_eq(1)", :line_number=>9}',
      'count2_spec.rb", :line=>"expect { 2 }.not_to become_eq(3)", :line_number=>11}'
    ].reverse
    expected.map! { |e| Regexp.escape e }
    actual_lines = output.strip.split("\n")

    expected.each_with_index do |exp, index|
      expect(actual_lines[-1 - index]).to match exp
    end
  end

  it 'counts expects outside of spec files' do
    output = `rspec spec2/assert_spec.rb`

    expected = 'assert.rb", :line=>"expect { 1 }.to become_eq(1)", :line_number=>2}'
    expected = Regexp.escape expected

    expect(output).to match expected
  end

  it 'dupe_spec.rb expects correctly' do
    output = `rspec spec2/dupe_spec.rb`
    actual_expectation   = output.strip.split("\n").last
    expected_expectation = '5 expectations'

    expect(actual_expectation).to eq(expected_expectation)
  end

  it 'dupe2_spec.rb expects correctly' do
    output               = `rspec spec2/dupe2_spec.rb`
    actual_expectation   = output.strip.split("\n").last
    expected_expectation = '1 expectation'
    expect(actual_expectation).to eq(expected_expectation)
  end
end
