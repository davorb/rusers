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

  def last
    output = Array.new
    command="last"
    username = if $u
                 $u
               elsif Rusers.is_user?(`logname`)
                 `logname`.split.join("\n")
               else
                 "dt08db2"
               end
    unless Rusers.is_user?(`logname`)
      remote_command = "ssh #{username}@login.student.lth.se ssh -o StrictHostKeyChecking=no -q #{@hostname} #{command}"
    else
      remote_command = "ssh -o StrictHostKeyChecking=no -q #{@hostname} #{command}"
    end
    tmp  = IO.popen remote_command
    lines = tmp.read
    lines << "from #{@hostname}"
    return [] if lines.size == 0
    lines
  end

  def users
    command="who"
    users = Array.new

    username = if $u
                 $u
               elsif Rusers.is_user?(`logname`)
                 `logname`.split.join("\n")
               else
                 "dt08db2"
               end
    unless Rusers.is_user?(`logname`)
      remote_command = "ssh #{username}@login.student.lth.se ssh -o StrictHostKeyChecking=no -q #{@hostname} #{command}"
    else
      remote_command = "ssh -o StrictHostKeyChecking=no -q #{@hostname} #{command}"
    end
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
