require 'action_view/base'

module ActionPresenter::Helpers
  def present(*args)
    options = args.extract_options!
    object = args.first
    presenter_class = options.delete(:with) do
      raise ArgumentError, 'Neither an object nor a presenter class has been specified' if object.nil?
      "#{object.class.name}Presenter"
    end
    presenter_class = presenter_class.to_s.constantize unless presenter_class.is_a?(Class)
    presenter = presenter_class.new(*[self, object].compact, options)
    yield(presenter) if block_given?
    presenter
  end
end

ActionView::Base.send :include, ActionPresenter::Helpers