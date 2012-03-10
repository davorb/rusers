require "yaml"
require "./Computer.rb"

class ConfigReader
  def initialize (file_name)
    @file_name = file_name
    @conf = YAML.load(File.open(@file_name))
  end

  def rooms
    rooms = Array.new
    @conf.each do |c|
      rooms << c.keys[0]
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
