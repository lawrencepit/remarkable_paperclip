require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/testtask'
require 'spec/rake/spectask'

desc 'Default: run specs.'
task :default => :spec

desc 'Run all the specs for remarkable_paperclip.'
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.rcov = false
end
