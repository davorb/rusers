require 'redis'
require 'uri'
require 'yaml'
require "./ParseW.rb"
require "./Connection.rb"
require "./ConfigReader.rb"

Redis_Address = File.read 'config.yaml'
uri = URI.parse(Redis_Address)
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

Debug = false

##
# Sets the following keys
# ROOM: [computer-1, computer-2]
# COMPUTER-1: [user1, user2]
def check_computer computer
  conn = Connection.new computer
  result = ParseW.parse conn.to_s
  
  REDIS.setex(computer, 900, result) unless Debug

  # if the room isn't empty, add to set and set expiration date
  # else if it is empty, remove room from set
  # mars: [mars-1]
  if result != ""
    REDIS.sadd(computer.room, computer) unless Debug
    REDIS.expire(computer.room, 900) unless Debug
    puts "added result: #{result} to computer #{computer} in room #{computer.room}. #{result.class}"
  else
    REDIS.srem(computer.room, computer) unless Debug
  end
#  puts "#{computer}: #{result} <> result.size: #{result.size}" if Debug #unless result.size == 0
end

config = ConfigReader.new "computers.yaml"
while true do
  puts "begin"
  threads = []
  config.computers.each do |computer|
    threads << Thread.new do
      check_computer computer
    end
    if Thread.list.size > 20
      #if Debug
      #  puts "======="
      #  Thread.list.each { |t| puts t }
      #  puts "======="
      #end
      threads.each do |t| 
        t.join
      end
      puts "released threads" if Debug
    end
  end
  puts "sleep..."
#  sleep 5
end
