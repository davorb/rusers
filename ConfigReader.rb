require "yaml"

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
    # TODO: write
  end
end
