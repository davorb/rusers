require "./ParseW.rb"
require "test/unit"

class TestParseW < Test::Unit::TestCase
  My_user_name = "dt08db2"

  def test_empty_string
    result = ParseW.parse "", My_user_name
    assert_equal [], result
  end

  def test_no_user_name
    result = ParseW.parse Input_just_me

    assert_equal ["dt08db2"], result
  end

  def test_just_me
    result = ParseW.parse Input_just_me, My_user_name

    assert_equal [], result
  end

  def test_one_user
    result = ParseW.parse Input_one_user, My_user_name

    assert_equal ["pi05an1"], result
  end

  def test_three_users
    result = ParseW.parse Input_three_users, My_user_name

    assert_equal ["dt05tl3", "dt07ca7", "dt08do6"], result
  end
end

# These are the input strings used for the test cases
Input_just_me = <<STRING
 14:21:29 up 6 days,  6:16,  1 user,  load average: 0.08, 0.03, 0.05
USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU WHAT
dt08db2  pts/0    login.student.lt 14:21    0.00s  0.25s  0.00s w
STRING


Input_one_user = <<STRING
 14:21:29 up 6 days,  6:16,  1 user,  load average: 0.08, 0.03, 0.05
USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU WHAT
dt08db2  pts/0    login.student.lt 14:21    0.00s  0.25s  0.00s w
pi05an1  pts/0    login.student.lt 14:21    0.00s  0.25s  0.00s w
STRING

Input_three_users = <<STRING
 14:28:08 up 66 days, 21:39,  4 users,  load average: 0.00, 0.01, 0.05
USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU WHAT
dt05tl3  pts/3    80.78.212.27:S.0 01Jan12 21:07  11:09  11:09  irssi
dt08db2  pts/4    109-104-30-107.c 14:19    0.00s  0.16s  0.00s w
dt07ca7  pts/6    uglybob.df.lth.s 28Feb12  5days  0.17s  0.17s -zsh
dt08do6  pts/7    h51bafa4a.seluti 10:47    3:40m  0.10s  0.01s ssh linus.lab.e
STRING

