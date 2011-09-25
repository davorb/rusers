#!/usr/bin/ruby1.9.1

require "./rusers.rb"
require "test/unit"

class TestRusers < Test::Unit::TestCase
  def test_poll_computers_offline_range
    last = Rusers.poll_computers "mars", 42..43
    last.each { |k,v| assert_equal( nil, v, "Read non existing user from non existing computer: #{v}") }
  end

  def test_poll_offline_computer
    tmp = Rusers.poll "idontexist"
    assert_equal tmp, nil
  end

  def test_poll_computers_bad_range
    assert_raise( RuntimeError ) { Rusers.poll_computers "mars", nil }
  end

  def test_parse_yaml_returns_array
    assert_instance_of Array, Rusers.parse_yaml
  end

  def test_parse_yaml_actually_getting_values
    assert_not_nil Rusers.parse_yaml
    assert_not_equal 0, Rusers.parse_yaml.size, "Not getting any values from YAML-file"
  end

  def test_is_room
    assert_equal( false, Rusers.is_room?("idontexist"), "Room exists but is shown as non existing" )
    assert_equal( true, Rusers.is_room?("mars"), "Room exists but is shown as non existing" )
    assert_equal( true, Rusers.is_room?("venus"), "Room exists but is shown as non existing" )
    assert_equal( true, Rusers.is_room?("jupiter"), "Room exists but is shown as non existing" )
  end

  def test_is_host
    assert Rusers.is_host?("mars-1")
    assert Rusers.is_host?("mars-10")
    assert !Rusers.is_host?("idontexist"), "This host shouldn't exist"
  end
end
