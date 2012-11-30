require "stringio"
require "test/unit"
require "../color_finder"

class ColorFinderTest < Test::Unit::TestCase

  def setup
    @word_list = StringIO.new("patate\nbleu\npomme")
  end

  def teardown
    @word_list = nil
  end

  def test_create_a_simple_color_finder

    finder = ColorFinder.new

    finder.load(@word_list)

    finder.find

    assert_not_equal(nil,finder)
  end

  def test_find_basic_color
    finder = ColorFinder.new

    finder.load(@word_list)

    assert_equal(["bleu"],finder.find)

  end

  def test_find_two_basic_color

    @word_list = StringIO.new("rouge\nbleu\npomme")

    finder = ColorFinder.new

    finder.load(@word_list)

    assert_equal(['rouge','bleu'],finder.find)
  end
end