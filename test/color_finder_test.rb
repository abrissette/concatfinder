require "stringio"
require "test/unit"
require "../color_finder"

class ColorFinderTest < Test::Unit::TestCase

  def test_create_a_simple_color_finder
    word_list = StringIO.new("patate\nbleu\npomme")

    finder = ColorFinder.new(word_list)

    assert_not_equal(nil,finder)
  end

  def test_find_basic_color
    word_list = StringIO.new("patate\nbleu\npomme")

    finder = ColorFinder.new(word_list)

    assert_equal(["bleu"],finder.find)
  end
end