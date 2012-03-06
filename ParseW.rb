module ParseW
  def self.parse (input, user_name="", ignore_idle=false)
    lines = Array.new
    users = Array.new

    input.each_line { |l| lines << l }
    lines = lines.drop 2

    lines.each { |l| users << l.split[0] }
    users.delete user_name
    users
  end
end
