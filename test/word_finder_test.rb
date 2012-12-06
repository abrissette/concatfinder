require 'stringio'
require 'test/unit'
require "word_finder"

class WordFinderTest < Test::Unit::TestCase

  def setup
    @word_list = StringIO.new("patate\nbleu\npomme")
    @rgb_color_regex = /rouge|vert|bleu/
    @rgb_color_finder = WordFinder.new
  end

  def teardown
    @word_list = nil
    @rgb_color_finder = nil
  end

  def test_create_a_simple_color_finder

    @rgb_color_finder.load(@word_list)

    @rgb_color_finder.find(@rgb_color_regex)

    assert_not_equal(nil,@rgb_color_finder)
  end

  def test_find_nothing_when_no_rgb_color

    @word_list = StringIO.new("truck\nchar\nchien")

    @rgb_color_finder.load(@word_list)

    @rgb_color_finder.find(@rgb_color_regex)

    assert_not_equal(nil,@rgb_color_finder)
  end

  def test_find_basic_color

    @rgb_color_finder.load(@word_list)

    assert_equal(["bleu"],@rgb_color_finder.find(@rgb_color_regex))

  end

  def test_find_two_basic_color

    @word_list = StringIO.new("rouge\nbleu\npomme")

    @rgb_color_finder.load(@word_list)

    assert_equal(['rouge','bleu'],@rgb_color_finder.find(@rgb_color_regex))
  end

  def test_throw_error_when_finding_in_empty_dictionary
    word_list = StringIO.new("")
    @rgb_color_finder.load(word_list)

    assert_raise(ArgumentError) do
      @rgb_color_finder.find(@rgb_color_regex)
    end

  end

  def test_load_word_list_from_file
    File.open("test/color_list_test.txt","r") do | file |
      @rgb_color_finder.load(file)
      assert_equal([ 'bleu', 'rouge'], @rgb_color_finder.find(@rgb_color_regex))
    end
  end

end