require 'rake'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs    << 'test'
  t.pattern = 'test/*_test.rb'
  t.verbose = true
end

task default: :test
task spec: :test
