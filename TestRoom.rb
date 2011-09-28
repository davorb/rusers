require "./room.rb"
require "./user.rb"
require "test/unit"

class TestRoom < Test::Unit::TestCase
  def setup
    @room = Room.new "mars", 1..10
  end

  def test_initialize_without_range
    assert_raise( RuntimeError ) { Room.new "mars", nil }
  end

  def test_get_users_returns_users
    users = @room.users
    assert_instance_of Array, users
    assert_instance_of Array, users[0]
    assert_instance_of User, users[0][0] unless users[0][0].nil?
  end

  def test_to_s
    assert_equal "mars-1..10", @room.to_s
  end
end
