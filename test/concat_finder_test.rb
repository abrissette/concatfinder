require "test/unit"
require "../concat_finder"

                  # potential enhancements
#   - load from file
#   - start from command line
#   - inforce candidate profile on index creation - DONE
#   - loop to get the words list from command line
#   - factor matcher with method/bloc like matches_for_six_letters_concatenated
#   - error handling (cant open file, no candidate, etc...)
#        no candidate - DONE

class ConcatFinderTest < Test::Unit::TestCase

  def test_possible_sub_words_are_smaller_than_six_letter
    word_list = ['al', 'bums', 'albums', 'pot', 'pantoufle']
    concat_finder = ConcatFinder.new(word_list)

    assert_equal(['al', 'bums','pot'], concat_finder.sub_words)
  end

  def test_restrict_candidate_to_six_letters_words
    word_list = ['alli','albums', 'pantin', 'pantoufle']
    concat_finder = ConcatFinder.new(word_list)

    assert_equal(['albums', 'pantin'], concat_finder.word_candidates)
  end

  def test_throw_an_error_when_zero_candidate
    word_list = ['alli','al', 'pant', 'pantoufle']

    assert_raise(ArgumentError) do
      concat_finder = ConcatFinder.new(word_list)
    end

  end

  def test_find_a_simple_concat
    word_list = ['pan', 'tin', 'pantin', 'pouet']
    concat_finder = ConcatFinder.new(word_list)

    assert_equal({'pantin' => [ 'pan', 'tin']}, concat_finder.find)

  end

    def test_two_concats
    word_list = ['al', 'bums', 'albums', 'pouet','pan', 'tin', 'pantin']
    concat_finder = ConcatFinder.new(word_list)

    assert_equal({'albums' => [ 'al', 'bums'],'pantin' => [ 'pan', 'tin']}, concat_finder.find)

  end

  def test_ignore_partial_sub_words
    word_list = ['pan', 'pantin', 'al', 'bums', 'albums' ]
    concat_finder = ConcatFinder.new(word_list)

    assert_equal({'albums' => [ 'al', 'bums']}, concat_finder.find)

  end

end

