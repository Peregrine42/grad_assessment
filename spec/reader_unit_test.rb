require 'minitest/autorun'
require './reader'

class TestReader < Minitest::Test

  def test_it_gets_a_string_from_a_file
    file = Minitest::Mock.new
    file.expect :read, "foo\n"
    File.stub :open, 'some file', file do
      assert_equal "foo\n", Reader.new.read('some file')
    end
    file.verify
  end

end
