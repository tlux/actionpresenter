require 'rubygems'
require 'active_support/all'

module ActionPresenter
  def self.root
    path = File.expand_path('../..', __FILE__)
    raise path
    path
  end
end

Dir["#{ActionPresenter.root}/lib/action_presenter/*.rb"].each do |filename|
  require filename
end