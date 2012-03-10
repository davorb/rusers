require "./Connection.rb"
require "test/unit.rb"

class TestConnection < Test::Unit::TestCase
  def setup
    @c = Connection.new "mars-1"
  end

  def test_read_default_values
    assert_equal "mars-1", @c.host_name
    assert_equal "dt08db2", @c.user_name
    assert_equal "login.student.lth.se", @c.tunnel
    assert_equal "w", @c.command
  end

  def test_connect_to_server
    lines = Array.new
    conn = Connection.new "login.student.lth.se"
    result = conn.to_s
    result.each_line { |l| lines << l }
    assert_equal Second_line, lines[1]
  end

  def test_set_methods
    @c.command = "LOL"
    @c.user_name = "idontexist"

    assert_equal "idontexist", @c.user_name
    assert_equal "LOL", @c.command

    expected_command =
      'ssh idontexist@login.student.lth.se ssh'\
      ' -o StrictHostKeyChecking=no -q mars-1 LOL'
    assert_equal expected_command, @c.ssh_command
  end

  def test_connect_to_nowhere
    conn = Connection.new "idontexist"
    assert_equal "", conn.to_s
  end
end

Second_line = 'USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU WHAT
'
