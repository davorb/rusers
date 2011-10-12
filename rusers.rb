#!/usr/bin/env ruby -s

require "./util.rb"
include Rusers

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
