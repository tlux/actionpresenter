require 'rubygems'
require 'bundler/setup'
require 'pry-byebug'
require 'active_model'
require 'action_presenter'
require 'faker'

require 'support/faked_view_context'
require 'support/models'
require 'support/presenters'

RSpec.configure do |config|
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end