class Connection
  attr_reader :host_name, :user_name, :command, :tunnel, :ssh_command

  def initialize (host_name, 
                  command="last -R|head -n 1", 
                  user_name="dt08db2", 
                  tunnel="login.student.lth.se")
    @host_name = host_name
    @user_name = user_name
    @command = command
    @tunnel = tunnel

    set_ssh_command
  end

  def to_s
    tmp = IO.popen @ssh_command
    a = tmp.read
    tmp.close
    a
  end

  def command= (c)
    @command = c
    set_ssh_command
  end

  def user_name= (u)
    @user_name = u
    set_ssh_command
  end

  private
  def set_ssh_command
    @ssh_command = "ssh #{@user_name}@#{@tunnel} ssh"+
      " -o StrictHostKeyChecking=no -q #{@host_name} #{@command}"
  end
end
