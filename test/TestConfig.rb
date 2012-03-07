require "../Config.rb"
require "test/unit"

class TestConfigReader < Test::Unit::TestCase
  def setup
    @c = ConfigReader.new "testcomputers.yaml"
  end

  def test_file_not_found
    assert_raise (Errno::ENOENT) { ConfigReader.new("i_dont_exist") }
  end

  def test_rooms
    assert_equal Rooms, @c.rooms
  end

  def test_computers
    assert_equal Computers, @c.computers
  end
end

Rooms = ["dog", "cat", "house"]
Computers = ["dog-1", "cat-1", "cat-2", "cat-3",
               "house-0", "house-1"]
