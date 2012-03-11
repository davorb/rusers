module ParseW
  def self.parse (input)
    if input =~ /still logged in/
      input.split[0]
    else
      ""
    end
  end
end
