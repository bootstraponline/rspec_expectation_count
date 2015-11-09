def assert_true
  expect(1).to eq(1)
end

def assert_test
  @count = 0
  expect { @count += 1 }.to become_eq 3
end
