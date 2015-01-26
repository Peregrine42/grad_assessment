require 'minitest/autorun'
require './chainlink'

class TestScript < Minitest::Test

  def test_it_finds_the_chain_of_command_between_two_employees
    chainlink       = Chainlink.new

    expected_result = ["Batman (16) -> Black Widow (6) -> Gonzo the Great (2) -> Dangermouse (1) <- Invisible Woman (3) <- Super Ted (15)"]
    actual_result   = chainlink.walk("./fixtures/superheroes.txt", "Batman", "Super Ted")

    assert_equal(expected_result, actual_result)
  end

  def test_it_finds_the_chain_of_command_between_two_employees_far_away
    chainlink       = Chainlink.new

    expected_result = ["Batman (16) -> Black Widow (6) -> Gonzo the Great (2) -> Iron Man (9) -> Superman (10) <- Dangermouse (1) <- Invisible Woman (3) <- Super Ted (15)"]
    actual_result   = chainlink.walk("./fixtures/superheroes_2.txt", "Batman", "Super Ted")

    assert_equal(expected_result, actual_result)
  end

  def test_no_table
    chainlink       = Chainlink.new
    assert_raises BuilderException do
      result = chainlink.walk("./fixtures/no_table.txt", "Batman", "Super Ted")
    end
  end

  def test_no_header
    chainlink       = Chainlink.new

    expected_result = ["Batman (16) -> Black Widow (6) -> Gonzo the Great (2) -> Iron Man (9) -> Superman (10) <- Dangermouse (1) <- Invisible Woman (3) <- Super Ted (15)"]

    actual_result = chainlink.walk("./fixtures/no_header.txt", "Batman", "Super Ted")

    assert_equal(expected_result, actual_result)
  end
end
