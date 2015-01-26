require 'minitest/autorun'
require './builder'

class TestBuilder < Minitest::Test

  def test_find_start_of_lines
    input = ['nope', 'employee id', 'employee id | name', 'employee id | name            | manager id']
    assert_equal 3, Builder.new.find_start_of_table(input)
  end

  def test_returns_the_object_heirachy_expressed_in_the_string
    input = <<EOF
| Employee ID | Name            | Manager ID |
| 2           | Gonzo the Great | 1          |
| 1           | Dangermouse     |            |
| 3           | Invisible Woman | 1          |
EOF
    result = Builder.new.build(input)
    assert_equal(2, result[0].id)
    assert_equal(1, result[1].id)
    assert_equal(3, result[2].id)
  end

end
