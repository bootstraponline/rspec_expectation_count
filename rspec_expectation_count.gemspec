require_relative 'lib/rspec_expectation_count/version'

# rubocop:disable Style/SpaceAroundOperators

Gem::Specification.new do |s|
  s.required_ruby_version = '>= 2.2.3'

  s.name          = 'rspec_expectation_count'
  s.version       = RSpecExpectationCount::VERSION
  s.date          = RSpecExpectationCount::DATE
  s.license       = 'http://www.apache.org/licenses/LICENSE-2.0.txt'
  s.description   = s.summary = 'Count the number of expectations used in an RSpec test suite'
  s.description   += '.' # avoid identical warning
  s.authors       = s.email = ['code@bootstraponline.com']
  s.homepage      = 'https://github.com/bootstraponline/rspec_expectation_count'
  s.require_paths = ['lib']

  s.add_runtime_dependency 'rspec', '>= 3.3.0'
  s.add_development_dependency 'appium_thor', '>= 1.0.1'
  s.add_development_dependency 'thor', '>= 0.19.1'
  s.add_development_dependency 'pry', '>= 0.10.3'
  s.add_development_dependency 'rubocop', '~> 0.35.0'

  s.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
end
