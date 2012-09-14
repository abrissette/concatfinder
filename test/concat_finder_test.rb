require "test/unit"
require "../concat_finder"

# potential enhancements
#   - display provide sub parts for a valid concat
#   - load from file
#   - start from command line
#   - inforce candidate profile on index creation
#   - factor matcher with method/bloc like matches_for_six_letters_concatenated

class ConcatFinderTest < Test::Unit::TestCase
  SMALL_LIST = ['al', 'bums', 'albums']

  def test_create_finder

    finder = ConcatFinder.new(SMALL_LIST)

    assert(finder.words_list.size() > 0)

  end

  def test_find_sub_word

    finder = ConcatFinder.new(SMALL_LIST)

    assert_equal({'albums' => [ 'al', 'bums']}, finder.sub_words)

  end


end

