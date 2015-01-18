class Person
  include ActiveModel::Model

  def name
    @name ||= Faker::Name.name
  end

  def address
    @address ||= Faker::Address.street_address
  end

  def company
    @company ||= Company.new
  end

  def associates
    @associates ||= 3.times.collect { Person.new }
  end
end

class Location
  include ActiveModel::Model
end

class Company
  include ActiveModel::Model

  def name
    @name ||= Faker::Company.name
  end
end

