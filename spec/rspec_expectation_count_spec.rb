describe 'rspec expectation count' do
  it 'prints an expectation count' do
    output = `rspec spec2/count_spec.rb`
    expect(output).to match '2 expectations'
  end

  it 'prints expectation debug info' do
    output = `rspec spec3/count_spec.rb`

    expected = [
      'count_spec.rb", :line=>"expect(1).to eq(1)", :line_number=>9}',
      'count_spec.rb", :line=>"expect(2).not_to eq(3)", :line_number=>11}'
    ].reverse
    expected.map! { |e| Regexp.escape e }
    actual_lines = output.strip.split("\n")

    expected.each_with_index do |exp, index|
      expect(actual_lines[-1 - index]).to match exp
    end
  end

  it 'counts expects outside of spec files' do
    output = `rspec spec3/assert_spec.rb`

    expected = 'assert.rb", :line=>"expect(1).to eq(1)", :line_number=>2}'
    expected = Regexp.escape expected

    expect(output).to match expected
  end
end
