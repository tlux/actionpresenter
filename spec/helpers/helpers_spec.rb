require 'spec_helper'

describe ActionPresenter::Helpers do
  let(:helper) { FakedViewContext.new }

  describe '#present' do
    it 'is available in view context' do
      expect(helper).to respond_to(:present)
    end

    it 'cannot be invoked without arguments' do
      expect { helper.present }.to raise_error ArgumentError, 'Neither object nor presenter class specified'
    end

    it 'initializes a presenter by a given object' do
      presenter = helper.present(Person.new)
      expect(presenter).to be_a PersonPresenter
    end

    it 'fails initialization if no matching presenter class could be found' do
      expect { helper.present(Location.new) }.to raise_error(/uninitialized constant/)
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

    it 'initializes a presenter by a given scoped object and presenter class name (ignoring the scope)' do
      presenter = helper.present([:unknown, :scope, Person.new], with: Admin::PersonPresenter)
      expect(presenter).to be_an Admin::PersonPresenter
    end

    it 'fails initializing a presenter with an invalidly scoped object' do
      expect { helper.present([:unknown, :scope, Person.new]) }.to raise_error(/uninitialized constant/)
    end

    it 'takes a block and yields the just initialized presenter instance as argument' do
      expect { |block| helper.present(Person.new, &block) }.to yield_with_args(PersonPresenter)
    end
  end
end