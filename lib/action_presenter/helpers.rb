require 'action_view/base'

module ActionPresenter::Helpers
  VALID_OPTIONS = :with, :scope

  def present(*args)
    options = args.extract_options!
    scope_and_object = Array(args.first)
    object = scope_and_object.last
    presenter_class = extract_presenter_class(scope_and_object, options)
    presenter = presenter_class.new(self, object, options.except(*VALID_OPTIONS))
    yield(presenter) if block_given?
    presenter
  end

  def present_collection(collection, options = {}, &block)
    Array(collection).map do |object|
      present(object, options, &block)
    end
  end

  private

  def extract_presenter_class(scope_and_object, options)
    scope_and_object = Array(scope_and_object).compact
    object = scope_and_object.last

    presenter_class = options.fetch(:with) do
      if object.nil?
        fail ArgumentError, 'Neither object nor presenter class specified'
      end

      if options[:scope]
        scope_and_object = [*options[:scope], object]
        fail ArgumentError, 'You cannot use :scope in conjunction with ' \
                            'a scoped object' if scope_and_object.many?
      end

      scoped_class_name = scope_and_object.map do |item|
        case item
        when Symbol then item.to_s.camelize
        when Class then item.name
        else item.class.name
        end
      end.join('::')
      "#{scoped_class_name}Presenter"
    end

    return presenter_class.to_s.constantize unless presenter_class.is_a?(Class)
    presenter_class
  end
end

ActionView::Base.send :include, ActionPresenter::Helpers
