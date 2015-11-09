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
    ]
    expected.map! { |e| Regexp.escape e }

    expected.each do |exp|
      expect(output).to match exp
    end
  end
end
