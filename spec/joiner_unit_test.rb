require 'minitest/autorun'
require './lib/joiner'
require './lib/employee'

class JoinerTest < Minitest::Test
  def test_it_handles_empty_arrays
    chain1 = []
    manager = Employee.new 5, 'bob', nil
    chain2 = [Employee.new(6, 'fred', nil)]

    assert_equal('bob (5) <- fred (6)', Joiner.new.join(chain1, manager, chain2))
  end

  def test_it_handles_empty_arrays_reversed
    chain1 = [Employee.new(6, 'fred', nil)]
    manager = Employee.new 5, 'bob', nil
    chain2 = []

    assert_equal('fred (6) -> bob (5)', Joiner.new.join(chain1, manager, chain2))
  end
end
