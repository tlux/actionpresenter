require 'rails/generators'

class ActionPresenter::PresenterGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../../../../app", __FILE__) 

  def create_presenter_file
    template 'presenter.rb', File.join('app/presenters')
  end
end