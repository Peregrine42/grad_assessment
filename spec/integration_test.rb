require 'minitest/autorun'
require './lib/chainlink'

class IntegrationTestScript < Minitest::Test
  def test_it_finds_a_short_chain_of_command_between_two_employees
    chainlink = Chainlink.new
    path = './spec/fixtures/superheroes.txt'

    expected_result = ['Batman (16) -> Black Widow (6) <- Catwoman (17)']
    actual_result = chainlink.walk(path, 'Batman', 'Catwoman')

    assert_equal(expected_result, actual_result)
  end

  def test_it_finds_the_chain_of_command_between_two_employees
    chainlink = Chainlink.new
    path = './spec/fixtures/superheroes.txt'

    expected_result = ['Batman (16) -> Black Widow (6) ->' \
                       ' Gonzo the Great (2) -> Dangermouse (1) ' \
                       '<- Invisible Woman (3) <- Super Ted (15)']
    actual_result = chainlink.walk(path, 'Batman', 'Super Ted')

    assert_equal(expected_result, actual_result)
  end

  def test_it_finds_the_chain_of_command_between_two_employees_far_away
    chainlink = Chainlink.new
    path = './spec/fixtures/superheroes_2.txt'

    expected_result = ['Batman (16) -> Black Widow (6) -> ' \
                       'Gonzo the Great (2) -> Iron Man (9)' \
                       ' -> Superman (10) <- Dangermouse (1) ' \
                       '<- Invisible Woman (3) <- Super Ted (15)']
    actual_result = chainlink.walk(path, 'Batman', 'Super Ted')

    assert_equal(expected_result, actual_result)
  end

  def test_it_finds_the_chains_of_command_between_employees_with_the_same_name
    chainlink = Chainlink.new
    path = './spec/fixtures/duplicates.txt'

    expected_result = ['Batman (2) -> Iron Man (9) -> Superman (10) ' \
                       '<- Dangermouse (1) <- Invisible Woman (3) ' \
                       '<- Super Ted (15)',

                       'Batman (16) -> Black Widow (6) -> Batman (2) ' \
                       '-> Iron Man (9) -> Superman (10) <- Dangermouse (1) ' \
                       '<- Invisible Woman (3) <- Super Ted (15)']

    actual_result = chainlink.walk(path, 'batman', 'Super Ted')

    assert_equal(expected_result, actual_result)
  end

  def test_no_table_raises_error
    chainlink = Chainlink.new
    assert_raises BuilderException do
      path = './spec/fixtures/no_table.txt'
      chainlink.walk(path, 'Batman', 'Super Ted')
    end
  end

  def test_unknown_name_raises_error
    chainlink = Chainlink.new
    assert_raises FinderException do
      path = './spec/fixtures/superheroes.txt'
      chainlink.walk(path, 'Batman', 'Foo')
    end
  end

  def test_no_header_is_no_problem
    chainlink = Chainlink.new

    expected = ['Batman (16) -> Black Widow (6) -> Gonzo the Great (2) ' \
                '-> Iron Man (9) -> Superman (10) <- Dangermouse (1) ' \
                '<- Invisible Woman (3) <- Super Ted (15)']

    actual_result = chainlink.walk('./spec/fixtures/no_header.txt',
                                   'Batman',
                                   'Super Ted')

    assert_equal(expected, actual_result)
  end

  def test_it_ignores_extra_spacing
    chainlink       = Chainlink.new

    expected_result = ['Gonzo the Great (2) -> Dangermouse (1)' \
                       ' <- Invisible Woman (3) <- Super Ted (15)']

    actual_result   = chainlink.walk('./spec/fixtures/weird_spacing.txt',
                                     'Gonzo the Great',
                                     'Super Ted')

    assert_equal(expected_result, actual_result)
  end
end
