require "./Computer.rb"
require "test/unit"

class TestComputer < Test::Unit::TestCase
  def setup
    @c = Computer.new "mars", 1
  end

  def test_to_s
    assert_equal "mars-1", @c.to_s
  end

  def test_room
    assert_equal "mars", @c.room
  end
end
