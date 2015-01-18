require 'rubygems'
require 'pathname'
require 'active_support/all'
require 'action_view'

module ActionPresenter
  def self.root
    Pathname.new(File.expand_path('../..', __FILE__))
  end
end

required_files = Dir[ActionPresenter.root.join('lib/action_presenter/*.rb')]
required_files.each do |filename|
  require filename
end
