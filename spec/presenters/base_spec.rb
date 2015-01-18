require 'spec_helper'

describe ActionPresenter::Base do
  let(:view_context) { FakedViewContext.new }

  it 'cannot be initialized without argument' do
    expect { ActionPresenter::Base.new }.to raise_error(
      ArgumentError, /wrong number of arguments/
    )
  end

  describe '.presents' do
    let(:presenter_class) { Class.new(ActionPresenter::Base) }

    before :each do
      presenter_class.presents :person
    end

    it 'creates an alias for #object on a particular presenter class' do
      expect(presenter_class.instance_methods).to include :person
    end

    it 'returns the original object' do
      person = Person.new
      presenter = presenter_class.new(view_context, person)
      expect(presenter.person).to eq person
    end
  end 

  describe '.delegate_presented' do
    let(:person) { Person.new }
    let!(:presenter_class) { Class.new(ActionPresenter::Base) }

    before :each do
      presenter_class.presents :person
    end

    subject(:presenter) { presenter_class.new(view_context, person) }

    it 'delegates to the original object and wraps it in a presenter' do
      presenter_class.delegate_presented :company

      expect(presenter.company).to be_a CompanyPresenter
    end

    it 'delegates to the original collection and wraps each element in its' \
       'own presenter' do
      presenter_class.delegate_presented :associates

      expect(presenter.associates).to be_an Array
      expect(presenter.associates.all? { |item|
        item.is_a?(PersonPresenter)
      }).to be true
    end

    it 'delegates to the original collection and wraps each element in its ' \
       'own custom defined presenter' do
      presenter_class.delegate_presented :associates, scope: :admin

      expect(presenter.associates.all? { |item|
        item.is_a?(Admin::PersonPresenter)
      }).to be true 
    end
  end

  describe '#object', '#to_model' do
    let(:person) { Person.new }
    subject(:presenter) { ActionPresenter::Base.new(view_context, person) }

    it 'includes the original object' do
      expect(presenter.object).to eq person
    end

    it 'includes the original object (through the #to_model alias)' do
      expect(presenter.to_model).to eq person
    end
  end

  describe '#template', '#h' do
    subject(:presenter) { ActionPresenter::Base.new(view_context) }

    it 'is protected' do
      expect(presenter.protected_methods).to include :template
    end

    it 'is protected (#h alias)' do
      expect(presenter.protected_methods).to include :h
    end

    it 'returns the view context object' do
      expect(presenter.send(:template)).to eq view_context
    end

    it 'returns the view context object (through the #h alias)' do
      expect(presenter.send(:h)).to eq view_context
    end
  end

  describe '#present' do
    let(:person) { Person.new }
    subject(:presenter) { PersonPresenter.new(view_context, person) }
    let :other_presenter do
      presenter.send(:present, presenter.object.company)
    end

    it 'is protected' do
      expect(presenter.protected_methods).to include :present
    end

    it 'returns a presenter object' do
      expect(other_presenter).to be_a CompanyPresenter
    end

    it 'returns a presenter object with the presented object wrapped inside' do
      expect(other_presenter.object).to eq presenter.object.company
    end
  end

  describe '#present_collection' do
    let(:presenter) { PersonPresenter.new(view_context, Person.new) }

    it 'is protected' do
      expect(presenter.protected_methods).to include :present_collection
    end

    it 'returns a collection of presenter objects' do
      other_presenter_collection = presenter.send :present_collection, 
        presenter.object.associates

      expect(other_presenter_collection.all? { |item|
        item.is_a?(PersonPresenter)
      }).to be true
    end
  end

  context 'dynamic delegation' do
    let(:person) { Person.new }
    let! :presenter_class do
      Class.new(ActionPresenter::Base) do
        presents :person
      end
    end
    subject(:presenter) { presenter_class.new(view_context, person) }

    it 'delegates to original object unless method has been overridden in ' \
       'presenter' do
      expect(presenter.name).to eq person.name
    end

    it 'allows using super to delegate to methods of the original object' do
      presenter_class.class_eval do
        def name
          "Name: #{super}"
        end
      end

      expect(presenter.name).to eq "Name: #{person.name}"
    end
  end

  context 'template delegation' do
    before :each do
      allow(view_context).to receive(:content_tag) do |tag, content, opts = {}|
        "<#{tag}>#{content}</#{tag}>"
      end
    end

    let! :presenter_class do
      Class.new(ActionPresenter::Base) do
        include ActionPresenter::TemplateDelegation
      end
    end

    let(:presenter) { presenter_class.new(view_context, Person.new) }

    it 'delegates unknown presenter methods to view context' do
      presenter_class.class_eval do
        def name
          content_tag :strong, super
        end
      end

      expect { presenter.name }.not_to raise_error
    end
  end
end