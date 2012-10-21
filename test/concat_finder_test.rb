require 'stringio'
require "test/unit"
require "../concat_finder"

                  # potential enhancements
#   - load from file - move first to
#   - start from command line - DONE
#   - inforce candidate profile on index creation - DONE
#   - loop to get the words list from command line - DONE
#   - factor matcher with method/bloc like matches_for_six_letters_concatenated
#   - Identifiy & extract generic matcher interface of abstract (Extensibility))
#   - error handling (cant open file, no candidate, etc...)
#        no candidate - DONE

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

end

