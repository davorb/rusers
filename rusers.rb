#!/usr/bin/env ruby1.9.2

require 'yaml'
require "./room.rb"

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

  def self.is_host? host

  end

  # TODO: just look at print_users_everywhere
  # and print_users_in room. In desperate need
  # of refactoring
  def self.print_all_users_everywhere
    conf = Rusers.parse_yaml
    conf.each do |h|
      h.each_key { |k| print_all_users_in_room k unless k.nil? }
    end
  end

  def self.print_all_users_in_room room
    room_conf = nil
    conf = Rusers.parse_yaml
    conf.each do |h|
      room_conf = h if room.eql?h.keys[0]
    end

    room = Room.new room_conf.keys[0], room_conf.values[0]

    room.users.each do |user|
      # TODO: add location
      puts "#{user}" unless user.nil?
    end
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
      puts "Listing all users in #{arg}..."
      Rusers.print_all_users_in_room arg
    elsif arg.eql? "-e"
      Rusers.print_all_users_everywhere
    else
      puts "Unknown argument: #{arg}."
    end
  end
end
