require 'rubygems'
require 'appium_thor'

Appium::Thor::Config.set do
  gem_name 'rspec_expectation_count'
  github_owner 'bootstraponline'
end

# rubocop:disable Style/ClassAndModuleChildren
class ::Default < Thor
  desc 'spec', 'Run RSpec tests'
  def spec
    exec 'bundle exec rspec spec'
  end

  desc 'cop', 'Execute rubocop'
  def cop
    exec 'bundle exec rubocop --display-cop-names'
  end
end
