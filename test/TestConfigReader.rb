require "./ConfigReader.rb"
require "test/unit"

class TestConfigReader < Test::Unit::TestCase
  def setup
    @c = ConfigReader.new "test/testcomputers.yaml"
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

  def test_number_of_computers_in_room
    assert_equal 1, @c.rooms[0].number_of_computers
    assert_equal 3, @c.rooms[1].number_of_computers
    assert_equal 2, @c.rooms[2].number_of_computers
  end
end

Rooms = ["dog", "cat", "house"]
Computers = ["dog-1", "cat-1", "cat-2", "cat-3",
               "house-0", "house-1"]
