# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"
require "standard/rake"

Rake::TestTask.new do |t|
  t.test_files = FileList["test/test_*.rb"]
end

task default: %i[test standard]
