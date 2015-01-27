require 'minitest/autorun'
require './lib/walker'
require './lib/employee'

class TestWalker < Minitest::Test
  def test_path_between
    manager  = Employee.new(2, 'bob', nil)
    employee = Employee.new(1, 'bryan', manager)

    actual = Walker.new.path_between(employee, manager)
    assert_equal([employee, manager], actual)
  end

  def test_long_path_between
    manager   = Employee.new(3, 'chris', nil)
    middleman = Employee.new(2, 'jackie', manager)
    employee  = Employee.new(1, 'fred', middleman)
    result = Walker.new.path_between(employee, manager)
    assert_equal([employee, middleman, manager], result)
  end

  def test_really_long_path_between
    ceo       = Employee.new(6, 'bryan', nil)
    manager   = Employee.new(3, 'sue', ceo)
    middleman = Employee.new(2, 'ken', manager)
    employee  = Employee.new(1, 'bob', middleman)
    result = Walker.new.path_between(employee, ceo)
    assert_equal([employee, middleman, manager, ceo], result)
  end

  def test_no_path_between
    manager   = Employee.new(3, 'emma', nil)
    middleman = Employee.new(2, 'fred', nil)
    employee  = Employee.new(1, 'bryan', middleman)
    result = Walker.new.path_between(employee, manager)
    assert_equal(nil, result)
  end
end
