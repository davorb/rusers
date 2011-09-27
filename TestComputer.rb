require "./computer.rb"
require "test/unit"

class TestComputer < Test::Unit::TestCase
  def setup
    @dontexist = Computer.new "idontexist"
    @mars1 = Computer.new "mars-1"
  end

  def test_names_are_correct
    assert_equal "mars-1", @mars1.to_s
  end

  def test_numbers_are_correct
    assert_equal 1, @mars1.number
  end

  def test_idle_user_not_logged_in
    assert_raise( RuntimeError ) { @mars1.idle "idontexist" }
  end

  def test_poll_offline_computer
    assert_equal @dontexist.users, nil
  end

  def test_bad_hostname
    assert_raise ( RuntimeError ) { Computer.new nil }
    assert_raise ( RuntimeError ) { Computer.new 10..20 }
  end

  def test_get_users_returns_user
    assert_instance_of User, @mars1.users
  end
end
