require 'stringio'
require 'test/unit'
require 'concat_finder'

class ConcatFinderTest < Test::Unit::TestCase
  def setup
        @concat_finder = ConcatFinder.new
  end

  def test_possible_sub_words_are_smaller_than_six_letter
    word_list = StringIO.new("al\nbums\nalbums\npot\npantoufle")

    @concat_finder.load(word_list)

    assert_equal(['al', 'bums','pot'].to_set, @concat_finder.sub_words_set)
  end

  def test_restrict_candidate_to_six_letters_words
    word_list = StringIO.new("alli\nalbums\npantin\npantoufle")
    @concat_finder.load(word_list)

    assert_equal(['albums', 'pantin'], @concat_finder.dictionary)
  end

  def test_throw_an_error_when_no_subwords
    word_list = StringIO.new("pantin\nalbums")

    assert_raise(ArgumentError) do
      @concat_finder.load(word_list)
    end

  end

  def test_find_a_simple_concat
    word_list = StringIO.new("pan\ntin\npantin\npouet")

    @concat_finder.load(word_list)

    assert_equal({'pantin' => [ 'pan', 'tin']}, @concat_finder.find)

  end

  def test_does_not_consider_subwords_in_the_middle
    word_list = StringIO.new("neatly\nat\nneat")

    @concat_finder.load(word_list)

    assert_equal({}, @concat_finder.find)
  end

  def test_two_concats
    word_list = StringIO.new("al\nbums\nalbums\npouet\npan\ntin\npantin")

    @concat_finder.load(word_list)

    assert_equal({'albums' => [ 'al', 'bums'],'pantin' => [ 'pan', 'tin']}, @concat_finder.find)

  end

  def test_ignore_partial_sub_words
    word_list = StringIO.new("pan\npantin\nal\nbums\nalbums")

    @concat_finder.load(word_list)

    assert_equal({'albums' => [ 'al', 'bums']}, @concat_finder.find)
  end

  def test_accept_double_sub_words

    word_list = StringIO.new("tom\ntom\ntomtom")

    @concat_finder.load(word_list)

    assert_equal({'tomtom' => [ 'tom', 'tom']}, @concat_finder.find)
  end

  def test_ignore_case
    word_list = StringIO.new("Weston\nwest\non")

    @concat_finder.load(word_list)

    assert_equal({'Weston' => [ 'west', 'on']}, @concat_finder.find)
  end

  def test_insure_concats_are_complete_word
    word_list = StringIO.new("routed\nred\nout")

    @concat_finder.load(word_list)

    assert_equal({}, @concat_finder.find)

  end

end

