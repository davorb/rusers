#!/usr/bin/env ruby1.9.1

require 'yaml'

module Rusers
  def self.poll_computers(room="mars", range=1..10)
    last = Hash.new
    raise RuntimeError, "Bad argument" unless range.respond_to? 'each'

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

  # TODO: refactor
  def self.print_all_users_in_room (room)
    puts "Listing all users in #{room}..."
    config = parse_yaml
    config.each do |room_array|
      if room_array.key? room
        result = poll_computers room_array.keys[0], room_array.values[0]

        result.each do |k,v|
          puts "#{k.to_s}: #{v}" unless v.nil?
        end
      end
    end
  end

  def self.is_room? host
    computers = Rusers.parse_yaml
    computers.each do |hash|
      return true if hash.key? host
    end
    false
  end

  def self.is_host? host
    #TODO
    false
  end
end

if ARGV.size == 0
  hostname = `hostname`
  if Rusers.is_host? hostname
    p hostname
    # TODO
  else
    Rusers.print_all_users_everywhere
  end
else
  ARGV.each do |arg|
    if Rusers.is_room? arg
      Rusers.print_all_users_in_room arg
    elsif arg.eql? "-e"
      Rusers.print_all_users_everywhere
    else
      puts "Unknown argument: #{arg}."
    end
  end
end
