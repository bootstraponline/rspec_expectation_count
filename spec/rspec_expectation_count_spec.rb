describe 'rspec expectation count' do
  it 'prints an expectation count' do
    output = `rspec spec2/count_spec.rb`
    expect(output).to match '2 expectations'
  end
end
