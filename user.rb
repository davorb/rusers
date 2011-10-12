
class User
  attr_accessor :hostname
  def initialize (name, hostname=nil)
    raise RuntimeError, "Trying to create nil user" if name.nil?
    @name = name
    @hostname = hostname
  end

  def to_s
    if hostname.nil?
      @name
    else
      "#{@hostname}: #{@name}"
    end
  end
end
