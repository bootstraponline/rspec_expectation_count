def assert_true # 1 expectation
  expect { 1 }.to become_eq(1)
end

def assert_test # 1 expectation
  @count = 0
  expect { @count += 1 }.to become_eq 7
end
