require 'stringio'
require 'test/unit'
require "../word_finder"

class WordFinderTest < Test::Unit::TestCase

  def setup
    @word_list = StringIO.new("patate\nbleu\npomme")
    @rgb_color_regex = /rouge|vert|bleu/
  end

  def teardown
    @word_list = nil
  end

  def test_create_a_simple_color_finder

    color_finder = WordFinder.new

    color_finder.load(@word_list)

    color_finder.find(@rgb_color_regex)

    assert_not_equal(nil,color_finder)
  end

  def test_find_basic_color
    color_finder = WordFinder.new

    color_finder.load(@word_list)

    assert_equal(["bleu"],color_finder.find(@rgb_color_regex))

  end

  def test_find_two_basic_color

    @word_list = StringIO.new("rouge\nbleu\npomme")

    color_finder = WordFinder.new

    color_finder.load(@word_list)

    assert_equal(['rouge','bleu'],color_finder.find(@rgb_color_regex))
  end
end