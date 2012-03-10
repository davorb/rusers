require "./Room.rb"
require "test/unit"

class TestRoom < Test::Unit::TestCase
  def setup
    @d = Room.new "mars"
    @d.number_of_computers = 3
  end

  def test_to_s
    assert_equal "mars", @d.to_s
  end

  def test_number_of_computers
    assert_equal 3, @d.number_of_computers
  end
end
