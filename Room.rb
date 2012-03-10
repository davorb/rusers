class Room < Object::String
  attr_accessor :number_of_computers

  def initialize (name)
    @name = name
    super name
  end

  def to_s
    @name
  end
end
