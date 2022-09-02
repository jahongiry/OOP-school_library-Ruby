require './person'
require_relative './classroom'

class Student < Person
  attr_reader :classroom, :parent_permission, :name, :age

  def initialize(age, name, classroom, parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
  end

  def play_hooky
    "¯\(ツ)/¯"
  end
  
  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end
end
