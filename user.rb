
class User
  def initialize (name)
    raise RuntimeError, "Trying to create nil user" if name.nil?
    @name = name
  end

  def to_s
    @name
  end

  def idle

  end

  def full_name
    
  end
end
