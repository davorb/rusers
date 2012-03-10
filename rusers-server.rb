require 'redis'
require 'uri'
require 'yaml'
require "./ParseW.rb"
require "./Connection.rb"
require "./ConfigReader.rb"

Redis_Address = File.read 'config.yaml'
uri = URI.parse(Redis_Address)
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

##
# Sets the following keys
# ROOM: [computer-1, computer-2]
# COMPUTER-1: [user1, user2]
def check_computer computer
  conn = Connection.new computer
  result = ParseW.parse conn.to_s, true, "dt08db2"
  
  REDIS.setex computer, 900, result

  # if the room isn't empty, add to set and set expiration date
  # else if it is empty, remove room from set
  # mars: [mars-1]
  if result.size > 0
    REDIS.sadd computer.room, computer
    REDIS.expireat computer, 900
    puts "added"
  else
    REDIS.srem computer.room, computer
  end
  puts "#{computer}: #{result} <> result.size: #{result.size}" unless result.size == 0
end

config = ConfigReader.new "computers.yaml"
config.computers.each do |computer|
  check_computer computer
end


#smembers
