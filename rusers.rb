require "./ParseW.rb"
require "./Connection.rb"
require "./ConfigReader.rb"

config = ConfigReader.new "computers.yaml"
config.computers.each do |computer|
  conn = Connection.new computer
  result = ParseW.parse conn.to_s, true, "dt08db2"
  puts "#{computer}: #{result}" unless result.size == 0
end
