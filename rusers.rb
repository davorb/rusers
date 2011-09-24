#!/usr/bin/ruby1.9.1

require 'yaml'

def self.poll_computers(room="mars", range=5..8)
  last = Hash.new
  range.each do |computer_number|
    Thread.new do
      last["#{room}-#{computer_number}".to_sym] = poll "#{room}-#{computer_number}"
    end
  end

  Thread.list.each do |t| 
    t.join unless t == Thread.current or t == Thread.main
  end
  last
end

def self.poll(computer)
  command = "who"
  remote_command = "ssh dt08db2@login.student.lth.se ssh -o StrictHostKeyChecking=no -q #{computer} #{command}"
  tmp  = IO.popen remote_command
  tmp.readlines.to_s[/\w{2,3}\d{2}\w{2,3}\d/] 
end

def self.parse_yaml
  parsed = begin
             YAML.load(File.open("computers.yaml"))
           rescue ArgumentError => e
             puts "Could not parse YAML: #{e.message}"
           end
  parsed
end

def self.print_all_users_everywhere
  puts "Listing all users..."
  config = parse_yaml
  config.each do |room|  
    room.each do |computer, range|
      last = poll_computers computer, range
      last.each do |k,v|
        puts "#{k.to_s}: #{v}" unless v.nil?
      end
    end
  end
end

print_all_users_everywhere
