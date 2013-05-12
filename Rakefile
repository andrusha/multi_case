require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :test => ["rspec"]

require "multi_case"

PACKAGE = "#{MultiCase::PACKAGE}"
VERSION = "#{MultiCase::VERSION}"

task :package do
  system "gem build #{PACKAGE}.gemspec"
end

task :install => :package do
  Dir.chdir("pkg") do
    system "gem install #{PACKAGE}-#{VERSION}"
  end
end

task :release => :package do
  Dir.chdir("pkg") do
    system "gem push #{PACKAGE}-#{VERSION}"
  end
end

task :default => :test
