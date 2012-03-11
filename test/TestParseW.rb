require "./ParseW.rb"
require "test/unit"

class TestParseW < Test::Unit::TestCase
  My_user_name = "dt08db2"

  def test_empty_string
    result = ParseW.parse ""
    assert_equal "", result
  end

  def test_no_one_logged_in
    result = ParseW.parse No_one_logged_in
    assert_equal "", result
  end

  def test_logged_in
    result = ParseW.parse Someone_logged_in
    assert_equal "et08vr6", result
  end
end

No_one_logged_in = <<TEXT
dt08db2  pts/4        Sun Mar 11 16:47 - 16:49  (00:02)    
TEXT

Someone_logged_in = <<TEXT
et08vr6  tty10        Sun Mar 11 15:29   still logged in   
TEXT
