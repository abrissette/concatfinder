require "test/unit"
require "../concat_finder"

class ConcatFinderTest < Test::Unit::TestCase
  SMALL_LIST = ['Al', 'bums', 'Albums']

  def test_create_finder

    finder = ConcatFinder.new(SMALL_LIST)

    assert(finder.words_list.size() > 0)

  end

  def test_find_sub_word

    finder = ConcatFinder.new(SMALL_LIST)
    puts finder.sub_words
    assert_equal([ 'Al', 'bums'], finder.sub_words)

  end
end

