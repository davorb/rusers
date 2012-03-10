require "yaml"
require "./Computer.rb"
require "./Room.rb"

class ConfigReader
  def initialize (file_name)
    @file_name = file_name
    @conf = YAML.load(File.open(@file_name))
  end

  def rooms
    rooms = Array.new
    @conf.each do |c|
      room = Room.new c.keys[0]
      room.number_of_computers = c.values[0].end-c.values[0].begin+1
      rooms << room
    end
    rooms
  end

  def computers
    answer = Array.new
    @conf.each do |c|
      answer.concat parse_rooms(c.keys[0], c.values[0])
    end
    answer
  end

  private
  def parse_rooms (name, range)
    computers = Array.new
    range.each do |i|
      computers << Computer.new(name, i)
    end
    computers
  end
end
