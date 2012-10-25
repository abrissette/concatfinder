require 'stringio'
require "test/unit"
require "../concat_finder"

                  # potential enhancements
#   - add a standard git Readme file for instruction (usability) 
#   - factor matcher with method/bloc like matches_for_six_letters_concatenated
#   - Identifiy & extract generic matcher interface or abstract (Extensibility))
#   - error handling (cant open file, no candidate, etc...)

class ConcatFinderTest < Test::Unit::TestCase

  def test_possible_sub_words_are_smaller_than_six_letter
    word_list = StringIO.new("al\nbums\nalbums\npot\npantoufle")
    concat_finder = ConcatFinder.new(word_list)

    assert_equal(['al', 'bums','pot'].to_set, concat_finder.sub_words_set)
  end

  def test_restrict_candidate_to_six_letters_words
    word_list = StringIO.new("alli\nalbums\npantin\npantoufle")
    concat_finder = ConcatFinder.new(word_list)

    assert_equal(['albums', 'pantin'], concat_finder.word_candidates_list)
  end

  def test_throw_an_error_when_zero_candidate
    word_list = StringIO.new("alli\nal\npant\npantoufle")

    assert_raise(ArgumentError) do
      concat_finder = ConcatFinder.new(word_list)
    end

  end

  def test_throw_an_error_when_no_subwords
    word_list = StringIO.new("pantin\nalbums")

    assert_raise(ArgumentError) do
      concat_finder = ConcatFinder.new(word_list)
    end

  end

  def test_find_a_simple_concat
    word_list = StringIO.new("pan\ntin\npantin\npouet")
    concat_finder = ConcatFinder.new(word_list)

    assert_equal({'pantin' => [ 'pan', 'tin']}, concat_finder.find)

  end

  def test_does_not_consider_subwords_in_the_middle
    word_list = StringIO.new("neatly\nat\nneat")
    concat_finder = ConcatFinder.new(word_list)

    assert_equal({}, concat_finder.find)
  end

  def test_two_concats
    word_list = StringIO.new("al\nbums\nalbums\npouet\npan\ntin\npantin")
    concat_finder = ConcatFinder.new(word_list)

    assert_equal({'albums' => [ 'al', 'bums'],'pantin' => [ 'pan', 'tin']}, concat_finder.find)

  end

  def test_ignore_partial_sub_words
    word_list = StringIO.new("pan\npantin\nal\nbums\nalbums")
    concat_finder = ConcatFinder.new(word_list)

    assert_equal({'albums' => [ 'al', 'bums']}, concat_finder.find)
  end

  def test_accept_double_sub_words
    word_list = StringIO.new("tom\ntom\ntomtom")
    concat_finder = ConcatFinder.new(word_list)

    assert_equal({'tomtom' => [ 'tom', 'tom']}, concat_finder.find)
  end

  def test_insure_concats_are_complete_word
    word_list = StringIO.new("routed\nred\nout")
    concat_finder = ConcatFinder.new(word_list)

    assert_equal({}, concat_finder.find)

  end

  def test_load_word_list_from_file
    File.open(File.dirname(__FILE__) + "/wordlist_test.txt","r") do | file |
      concat_finder = ConcatFinder.new(file)
      assert_equal({'albums' => [ 'al', 'bums']}, concat_finder.find)
    end
  end

end

