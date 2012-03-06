module ParseW
  ##
  # Splits each line into an array and then drops the first
  # two lines. If ignore_idle is set to true, it drops all
  # lines containing the word "days"
  #
  # After that it splits each line, and adds the first
  # part (the user name) to "users"
  def self.parse (input, user_name="", ignore_idle=false)
    lines = Array.new
    users = Array.new
    input.each_line { |l| lines << l }
    lines = lines.drop 2

    if ignore_idle
      lines.delete_if { |l| l =~ /days/ }
    end

    lines.each { |l| users << l.split[0] }
    users.delete user_name
    users
  end
end
