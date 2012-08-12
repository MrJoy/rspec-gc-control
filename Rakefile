require "bundler"
Bundler.setup
Bundler::GemHelper.install_tasks

require "rake"
require "yaml"

require "rspec/core/rake_task"
# require "rspec/core/version"

require "cucumber/rake/task"
Cucumber::Rake::Task.new(:cucumber)

desc "Run all examples"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.ruby_opts = %w[-w]
end

# desc "delete generated files"
# task :clobber do
#   sh %q{find . -name "*.rbc" | xargs rm}
#   sh 'rm -rf pkg'
#   sh 'rm -rf tmp'
#   sh 'rm -rf coverage'
#   sh 'rm -rf .yardoc'
#   sh 'rm -rf doc'
# end

# desc "generate rdoc"
# task :rdoc do
#   sh "yardoc"
# end

task :default => [:spec, :cucumber]
