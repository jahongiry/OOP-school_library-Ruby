class Nameable
  def correct_name
    raise NotImplementedError, "#{self.class} has no #{__method__}"
  end
end
