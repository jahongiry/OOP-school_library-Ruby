require 'securerandom'
require './nameable'
require './decorator'
require_relative 'rental'

class Person < Nameable
  attr_reader :id, :parent_permission
  attr_accessor :name, :age, :rentals

  def initialize(age:, **kwargs)
    super()
    @id ||= rand(1..500)
    @name = 'Unknown' if kwargs[:name].length.zero?
    @age = age
    @parent_permission = kwargs[:parent_permission]
    @rentals = []
  end

  def can_use_services?
    of_age? && @parent_permission
  end

  def correct_name
    @name
  end

  def add_rental(date, book)
    Rental.new(date, book, self)
  end

  private

  def of_age?
    @age >= 18
  end
end
