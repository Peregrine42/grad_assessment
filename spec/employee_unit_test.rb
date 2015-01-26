require 'minitest/autorun'
require './employee'

class TestEmployee < Minitest::Test

  def test_on_valid_line
    input = '| 3           | a aa a | 1          |'
    result = Employee.parse input
    assert_equal(3,        result.id)
    assert_equal('a aa a', result.name)
    assert_equal(1,        result.manager)
  end

  def test_on_ceo_line
    input = '| 2           | a aa a |            |'
    result = Employee.parse input
    assert_equal(2,        result.id)
    assert_equal('a aa a', result.name)
    assert_equal(nil,      result.manager)
  end

  def test_extra_space_compaction
    input = '| 2           | a           aa    a |            |'
    result = Employee.parse input
    assert_equal(2,        result.id)
    assert_equal('a aa a', result.name)
    assert_equal(nil,      result.manager)
  end

  def test_fails_on_malformed_line
    input = '| 3           |'
    error = assert_raises(EmployeeException) { Employee.parse input }
    assert_equal('invalid table line', error.message)
  end

end
