require "test/unit"
require "./util.rb"

class TestRusers < Test::Unit::TestCase
  include Rusers

  def test_parse_yaml_actually_getting_values
    assert_not_nil Rusers.parse_yaml
    assert_not_equal 0, Rusers.parse_yaml.size, "Not getting any values from YAML-file"
  end

  def test_is_room
    assert_equal( false, Rusers.is_room?("idontexist") )
    assert_equal( true, Rusers.is_room?("mars") )
    assert_equal( true, Rusers.is_room?("venus") )
    assert_equal( true, Rusers.is_room?("jupiter") )
  end
  
  def test_is_user
    assert Rusers.is_user?("dt08db2")
    assert Rusers.is_user?("ada08dba2")
    assert !Rusers.is_user?("davor")
    assert !Rusers.is_user?("root")
  end
end
