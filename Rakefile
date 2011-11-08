# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "fastspring-saasy"
  gem.homepage = "http://github.com/patchfx/fastspring"
  gem.license = "MIT"
  gem.summary = %Q{Ruby lib for using the FastSpring (Saasy) API}
  gem.description = %Q{Ruby lib for using the FastSpring (Saas) subscription management API}
  gem.email = "richard@justaddpixels.com"
  gem.authors = ["Richard Patching"]
  gem.add_development_dependency 'httparty', '~> 0.8.1'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "fastspring #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
