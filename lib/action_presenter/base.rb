class ActionPresenter::Base
  def initialize(template, *args)
    @_template = template
    @options = args.extract_options!
    @object = args.first
  end

  attr_reader :object, :options
  protected :options
 
  def self.presents(name)
    define_method name do
      object
    end
  end
  
  def self.delegate_presented(name, options = {})
    delegate_opts = options.slice(:to, :prefix, :allow_nil)
                    .reverse_merge(to: :object)
    delegate name, delegate_opts
    
    define_method "#{name}_with_presenter" do
      object = public_send("#{name}_without_presenter")
      return if object.nil?
      helper_options = options.except(*delegate_opts.keys)
      if object.respond_to?(:each)
        present_collection object, helper_options
      else
        present object, helper_options
      end
    end
    
    alias_method_chain name, :presenter
  end

  def inspect
    object_str = " object: #{object.inspect}" unless object.nil?
    "#<#{self.class.name}#{object_str}>"
  end

  def method_missing(name, *args, &block)
    if object && object.respond_to?(name, false)
      object.send(name, *args, &block)
    else
      super
    end
  end

  def respond_to_missing?(name, include_private = false)
    (object && object.respond_to?(name, include_private)) || super
  end

  alias_method :original, :object

  def to_model
    object
  end

  protected

  def present(*args)
    options = default_present_options(args.extract_options!)
    h.present(*args, options)
  end

  def present_collection(collection, options = {})
    h.present_collection(collection, default_present_options(options))
  end

  def template
    @_template
  end
  alias_method :h, :template

  private

  def default_present_options(options)
    options.reverse_merge(scope: self.class.name.try(:deconstantize))
  end
end
