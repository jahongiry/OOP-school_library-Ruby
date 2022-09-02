require './person'
require_relative './classroom'

class Student < Person
  attr_reader :classroom

  def initialize(age:, **kwargs)
    super(age:, **kwargs)
  end

  def play_hooky
    '¯\(ツ)/¯'
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end
end
