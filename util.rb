require 'yaml'
require "./room.rb"

#TODO change name to util
module Rusers
  def self.parse_yaml
    parsed = begin
               YAML.load(File.open("computers.yaml"))
             rescue ArgumentError => e
               puts "Could not parse YAML: #{e.message}"
             end
  end

  def self.is_room? host
    computers = Rusers.parse_yaml
    computers.each do |hash|
      return true if hash.key? host
    end
    false
  end

  def self.is_user? name
    pattern = /\w{2,3}\d{2}\w{2,3}\d/
    pattern =~ name
  end

  def self.is_host? name

  end

  # TODO: just look at print_users_everywhere
  # and print_users_in room. In desperate need
  # of refactoring
  def self.print_all_users_everywhere
    puts "Listing all users..."
    conf = Rusers.parse_yaml
    conf.each do |h|      
      h.each_key do |k| 
        print_all_users_in_room k unless k.nil?
      end
    end
  end

  def self.print_all_users_in_room room
    room_conf = nil
    conf = Rusers.parse_yaml
    conf.each do |h|
      room_conf = h if room.eql?h.keys[0]
    end

    room = Room.new room_conf.keys[0], room_conf.values[0]

    puts room.users
  end

  def print_last
    conf = Rusers.parse_yaml
    conf.each do |h|      
      h.each_key do |room| 
        room_conf = nil
        conf = Rusers.parse_yaml
        conf.each do |h|
          room_conf = h if room.eql?h.keys[0]
        end
        
        room = Room.new room_conf.keys[0], room_conf.values[0]
        room.all_last.each { |i| puts i }
      end
    end
  end
end
