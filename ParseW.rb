require 'date'

module ParseW
  def self.parse (input)
    if (input =~ /still logged in/ && compare_day(input.split[4]))
      input.split[0]
    else
      ""
    end
  end

  private
  def self.compare_day (day)
    Date.today.strftime('%d') == day
  end
end
