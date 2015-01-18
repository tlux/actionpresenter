module ActionPresenter::TemplateDelegation
  extend ActiveSupport::Concern

  included do
    alias_method_chain :method_missing, :template_delegation
    alias_method_chain :respond_to_missing?, :template_delegation
  end

  def method_missing_with_template_delegation(name, *args, &block)
    if respond_to_missing_without_template_delegation?(name)
      method_missing_without_template_delegation(name, *args, &block)
    elsif @_template.respond_to?(name, false)
      @_template.send(name, *args, &block)
    else
      super
    end
  end

  def respond_to_missing_with_template_delegation?(name,
    include_private = false)
    @_template.respond_to?(name, include_private) ||
      respond_to_missing_without_template_delegation?(name, include_private)
  end
end