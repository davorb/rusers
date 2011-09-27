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
    command = "who"
    remote_command = "ssh dt08db2@login.student.lth.se ssh -o StrictHostKeyChecking=no -q #{@hostname} #{command}"
    tmp  = IO.popen remote_command
    username= tmp.readlines.to_s[/\w{2,3}\d{2}\w{2,3}\d/] 
    return User.new username unless username.nil?
    nil
  end

  def idle (user)

  end

  def self.is_host? (hostname)

  end
end
