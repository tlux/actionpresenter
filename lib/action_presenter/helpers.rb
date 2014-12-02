require 'action_view/base'

module ActionPresenter::Helpers
  def present(*args)
    options = args.extract_options!
    scope = Array(args.first)
    object = scope.last
    presenter_class = options.delete(:with) do
      raise ArgumentError, 'Neither object nor presenter class specified' if object.nil?
      scoped_class_name = scope.map { |item|
        item.is_a?(Symbol) ? item.to_s.camelize : item.class.name
      }.join('::')
      "#{scoped_class_name}Presenter"
    end
    presenter_class = presenter_class.to_s.constantize unless presenter_class.is_a?(Class)
    presenter = presenter_class.new(self, object, options)
    yield(presenter) if block_given?
    presenter
  end
end

ActionView::Base.send :include, ActionPresenter::Helpers
