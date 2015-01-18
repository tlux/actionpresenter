require 'spec_helper'

describe ActionPresenter::Helpers do
  subject(:helper) { FakedViewContext.new }

  describe '#present' do
    it 'is available in view context' do
      expect(helper).to respond_to(:present)
    end

    it 'cannot be invoked without arguments' do
      expect { helper.present }.to raise_error(
        ArgumentError, 'Neither object nor presenter class specified')
    end

    it 'initializes a presenter by a given object' do
      presenter = helper.present(Person.new)
      expect(presenter).to be_a PersonPresenter
    end

    it 'fails initialization if no matching presenter class could be found' do
      expect { helper.present(Location.new) }.to(
        raise_error(/uninitialized constant/)
      )
    end

    it 'initializes a presenter by a given object and presenter class' do
      presenter = helper.present(Person.new, with: Admin::PersonPresenter)
      expect(presenter).to be_an Admin::PersonPresenter
    end

    it 'initializes a presenter by a given object and presenter class name' do
      presenter = helper.present(Person.new, with: 'Admin::PersonPresenter')
      expect(presenter).to be_an Admin::PersonPresenter
    end

    it 'initializes a presenter by a given scoped object' do
      presenter = helper.present([:admin, Person.new])
      expect(presenter).to be_an Admin::PersonPresenter
    end

    it 'initializes a presenter by a given scoped object and presenter class ' \
       'name (ignoring the scope)' do
      presenter = helper.present([:unknown, :scope, Person.new],
                                 with: Admin::PersonPresenter)
      expect(presenter).to be_an Admin::PersonPresenter
    end

    it 'fails initializing a presenter with an invalidly scoped object' do
      expect { helper.present([:unknown, :scope, Person.new]) }.to(
        raise_error(/uninitialized constant/)
      )
    end

    it 'takes a block and yields the just initialized presenter instance as ' \
       'argument' do
      expect { |block| helper.present(Person.new, &block) }.to(
        yield_with_args(PersonPresenter)
      )
    end

    it 'cannot use :scope together with a scoped object' do
      expect { helper.present([:admin, Person.new], scope: :something) }.to(
        raise_error('You cannot use :scope in conjunction with a scoped object')
      )
    end
  end

  describe '#present_collection' do
    it 'is available in view context' do
      expect(helper).to respond_to(:present_collection)
    end

    it 'cannot be invoked without arguments' do
      expect { helper.present_collection }.to raise_error(
        ArgumentError, /wrong number of arguments/)
    end

    it 'takes a collection as first argument' do
      expect(helper.present_collection([Person.new, Person.new]))
    end

    it 'does not take objects as first argument that do not respond to to_a' do
      expect { helper.present_collection(Person.new) }.to raise_error(
        ArgumentError, 'No valid collection specified'
      )
    end

    it 'initializes a collection of presenters by their given objects' do
      items = helper.present_collection [Person.new, Company.new]

      expect(items.first).to be_a PersonPresenter
      expect(items.last).to be_a CompanyPresenter
    end

    it 'ignores nil elements in the collection' do
      items = helper.present_collection [Person.new, nil, Company.new]

      expect(items.count).to eq 2
    end

    it 'initializes a collection of presenters by their given objects and ' \
       'presenter class' do
      items = helper.present_collection [Person.new, Person.new], 
                                        with: Admin::PersonPresenter
      expect(
        items.all? { |item| item.is_a?(Admin::PersonPresenter) }
      ).to be true
    end

    it 'initializes a collection of presenters by their given object and ' \
       'presenter class name' do
      items = helper.present_collection [Person.new, Person.new],
                                        with: 'Admin::PersonPresenter'
      expect(
        items.all? { |item| item.is_a?(Admin::PersonPresenter) }
      ).to be true
    end
  end
end