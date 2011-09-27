#!/usr/bin/ruby1.9.1

require "test/unit"
require "./TestComputer.rb"
require "./TestRoom.rb"
require "./TestUser.rb"

=begin
class TestRusers < Test::Unit::TestCase
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

  def test_is_host
    assert Rusers.is_host?("mars-1")
    assert Rusers.is_host?("mars-10")
    assert !Rusers.is_host?("idontexist"), "This host shouldn't exist"
  end

end
=end
