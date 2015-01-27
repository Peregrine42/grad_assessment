require 'minitest/autorun'
require './lib/builder'

class TestBuilder < Minitest::Test
  Employee = Struct.new :id, :manager

  def test_find_start_of_lines
    input = ['nope', 'employee id',
             'employee id | name',
             'employee id | name            | manager id']
    assert_equal 4, Builder.new.find_start_of_table(input)
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

  def test_linker
    emp1    = Employee.new(2, 3)
    emp2    = Employee.new(1, 4)
    manager = Employee.new(3, nil)

    employees = [
      emp1,
      emp2,
      manager
    ]

    Builder.new.link emp1, employees
    assert_equal(manager, emp1.manager)
  end

  def test_linker_on_ceo
    emp1 = Employee.new(2, 3)
    emp2 = Employee.new(1, 4)
    ceo  = Employee.new(3, nil)

    employees = [
      emp1,
      emp2,
      ceo
    ]

    Builder.new.link emp1, employees
    assert_equal(nil, ceo.manager)
  end
end
