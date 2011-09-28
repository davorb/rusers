require "./user.rb"

class Computer
  attr_accessor :room, :number

  def initialize (hostname)
    raise RuntimeError, "Hostname can't be nil" if hostname.nil?
    raise RuntimeError, "Bad argument" if hostname.class != String
    @hostname = hostname
    @room     = nil
    @number   = hostname[/\d{1,2}/].to_i
  end

  def to_s
    @hostname
  end

  def users
    users = Array.new
    command = "who"
    remote_command = "ssh dt08db2@login.student.lth.se ssh -o StrictHostKeyChecking=no -q #{@hostname} #{command}"
    tmp  = IO.popen remote_command
    lines = tmp.read
    return [] if lines.size == 0

    lines.each_line do |line| 
      username = line[/\w{2,3}\d{2}\w{2,3}\d/]
      users << User.new(username,@hostname) unless username.nil?
    end
    users
  end
  
  def self.is_host? (hostname)

  end
end
