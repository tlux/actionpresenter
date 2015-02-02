require 'rubygems'
require 'pathname'
require 'active_support/all'
require 'action_view'

module ActionPresenter
  def self.root
    Pathname.new(File.expand_path('../..', __FILE__))
  end
end

require 'action_presenter/base'
require 'action_presenter/helpers'
require 'action_presenter/template_delegation'

require ActionPresenter.root.join('lib', 'generators', 'action_presenter',
                                  'presenter_generator.rb').to_s
