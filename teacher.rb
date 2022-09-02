require './person'

class Teacher < Person
  def initialize(specialization:, age:, **kwargs)
    super(age:, **kwargs)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
