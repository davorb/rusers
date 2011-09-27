require "./user.rb"
require "test/unit"

class TestUser < Test::Unit::TestCase
  def setup
    @existing_user    = User.new "dt08db"
    @nonexisting_user = User.new "idontexist"
  end
  
  def test_cant_create_nil_users
    assert_raise( RuntimeError ) { User.new nil }
  end

  def test_idle_user_doesnt_exist
    assert_raise( RuntimeError ) { @nonexisting_user.idle }
  end

  def test_to_s
    assert_equal "dt08db", @existing_user.to_s
  end

  def test_full_name
    assert_equal "Davor Babic", @existing_user.full_name
  end

  def test_full_name_user_doesnt_exist
    assert_raise( RuntimeError ) { @nonexisting_user.full_name }
  end

  def test_to_s
    assert_equal "dt08db", @existing_user.to_s
    assert_equal "idontexist", @nonexisting_user.to_s
  end
end
