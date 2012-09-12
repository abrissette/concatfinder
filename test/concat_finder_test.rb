require "test/unit"
require '../concat_finder'

class ConcatFinderTest < Test::Unit::TestCase

  def set_up
    @small_words_list = ['Al', 'bums', 'Albums']
  end

  def teardown
     @small_words_list = []
  end

  def test_create_finder

    finder = ConcatFinder.new(@small_words_list)

    words = finder.words_list

    assert(words. > 0)

  end

  def test_find_a_word_part_of_another_one

    finder = ConcatFinder.new(@small_words_list)

    assert(finder.sub_words == [ 'Al', 'bums'])

    puts finder.words_list

  end
end

