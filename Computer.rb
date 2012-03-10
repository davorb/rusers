class Computer < Object::String
  attr_accessor :room

  def initialize (room, number)
    @room = room
    @number = number
    super "#{room}-#{number}"
  end

  def to_s
    "#{@room}-#{@number}"
  end
end
