require "./user.rb"
require "./computer.rb"

class Room
  def initialize (name, range)
    raise RuntimeError, "Bad argument" unless range.respond_to? 'each'
    @name = name
    @range = range

    @computers = Array.new
    range.each do |i|
      @computers[i] = Computer.new "#{name}-#{i}"
    end
  end

  def to_s
    @name
  end

  # Returns an array of computers
  def users
    results = Array.new
    @computers.each do |computer|
      Thread.new do
        results << computer.users unless computer.nil?
      end
    end
    Thread.list.each do |t| 
      t.join unless t == Thread.current or t == Thread.main
    end
    results
  end
end
