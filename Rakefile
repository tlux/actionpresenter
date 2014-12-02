# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = 'action_presenter'
  gem.homepage = 'http://github.com/tlux/actionpresenter'
  gem.license = 'MIT'
  gem.summary = %Q{A lightweight presenter implementation for Ruby on Rails.}
  gem.description = gem.summary
  gem.email = 'tobias.casper@gmail.com'
  gem.authors = ['Tobias Casper']
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

task default: :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "ActionPresenter #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
