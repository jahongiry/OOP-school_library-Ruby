require './rental'
require 'json'

class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def add_rentals(date, person, _book)
    Rental.new(date, person, self)
  end

  def to_json(*_args)
    {
      title: @title,
      author: @author
    }.to_json
  end

  def self.from_json(string)
    data = JSON.parse(string)
    new(data['title'], data['author'])
  end
end
