require 'minitest/autorun'
require './reader'

class TestReader < Minitest::Test

  def test_it_gets_a_string_from_a_file
    assert_equal 'foo\n', Reader.new.read('fixtures/sample.txt')
  end

end
