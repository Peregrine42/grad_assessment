require 'minitest/autorun'
require './builder'
require 'byebug'

class TestBuilder < Minitest::Test

  def test_find_start_of_lines
    input = ['nope', 'employee id', 'employee id | name', 'employee id | name            | manager id']
    assert_equal 3, Builder.new.find_start_of_table(input)
  end

  def test_extract_line
    input = '| 3           | a aa a | 1          |'
    assert_equal({ id: 3, name: 'a aa a', manager_id: 1 }, Builder.new.extract_line(input))
  end

  def test_extract_ceo_line
    input = '| 2           | a aa a |            |'
    assert_equal({ id: 2, name: 'a aa a', manager_id: nil }, Builder.new.extract_line(input))
  end

  def test_returns_the_object_heirachy_expressed_in_the_string
    input = <<EOF
| Employee ID | Name            | Manager ID |
| 2           | Gonzo the Great | 1          |
| 1           | Dangermouse     |            |
| 3           | Invisible Woman | 1          |
EOF
    expected_output = [ 
                        {id: 2, name: 'gonzo the great', manager_id: 1   },
                        {id: 1, name: 'dangermouse',     manager_id: nil },
                        {id: 3, name: 'invisible woman', manager_id: 1   },
                      ]

    assert_equal expected_output, Builder.new.build(input)
  end

end
