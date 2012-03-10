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
    REDIS.expire computer.room, 900
    puts "added result: #{result} to computer #{computer} in room #{computer.room}. #{result.class}"
  else
    REDIS.srem computer.room, computer
  end
  puts "#{computer}: #{result} <> result.size: #{result.size}" #unless result.size == 0
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
      puts "======="
      Thread.list.each { |t| puts t }
      puts "======="
      threads.each do |t| 
        t.join
      end
      puts "released threads"
    end
  end
  puts "sleep..."
#  sleep 5
end
