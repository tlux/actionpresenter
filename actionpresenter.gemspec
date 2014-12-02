# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: actionpresenter 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "actionpresenter"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Tobias Casper"]
  s.date = "2014-12-02"
  s.description = "A lightweight presenter implementation for Ruby on Rails."
  s.email = "tobias.casper@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "actionpresenter.gemspec",
    "lib/action_presenter.rb",
    "lib/action_presenter/base.rb",
    "lib/action_presenter/helpers.rb",
    "lib/action_presenter/template_delegation.rb",
    "lib/actionpresenter.rb",
    "spec/helpers/helpers_spec.rb",
    "spec/presenters/.keep",
    "spec/spec_helper.rb",
    "spec/support/faked_view_context.rb",
    "spec/support/models.rb",
    "spec/support/presenters.rb"
  ]
  s.homepage = "http://github.com/tlux/actionpresenter"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.3"
  s.summary = "A lightweight presenter implementation for Ruby on Rails."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, ["~> 4.0"])
      s.add_runtime_dependency(%q<actionview>, ["~> 4.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 2.0.1"])
      s.add_development_dependency(%q<rails>, ["~> 4.0"])
      s.add_development_dependency(%q<rspec-rails>, ["~> 3.0"])
      s.add_development_dependency(%q<pry-byebug>, [">= 0"])
    else
      s.add_dependency(%q<activesupport>, ["~> 4.0"])
      s.add_dependency(%q<actionview>, ["~> 4.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
      s.add_dependency(%q<rails>, ["~> 4.0"])
      s.add_dependency(%q<rspec-rails>, ["~> 3.0"])
      s.add_dependency(%q<pry-byebug>, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>, ["~> 4.0"])
    s.add_dependency(%q<actionview>, ["~> 4.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
    s.add_dependency(%q<rails>, ["~> 4.0"])
    s.add_dependency(%q<rspec-rails>, ["~> 3.0"])
    s.add_dependency(%q<pry-byebug>, [">= 0"])
  end
end

