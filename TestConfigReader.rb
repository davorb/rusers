require "./ConfigReader.rb"
require "test/unit"

class TestConfigReader < Test::Unit::TestCase
  def test_file_not_found
    assert_raise (Errno::ENOENT) { ConfigReader.new("i_dont_exist") }
  end

  def test_can_read_all_rooms
    c = ConfigReader.new "computers.yaml"
    assert_equal Rooms, c.rooms
  end
end

Rooms = ["jupiter", "venus", "mars", "alfa", "beta", "gamma",
"hacke", "panter", "val", "falk", "varg", "lo", "backus"]
