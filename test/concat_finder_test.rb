require 'stringio'
require "test/unit"
require "../concat_finder"

                  # potential enhancements
#remove single pass 'method' and re-use the find_all and File.foreach to load (see earlier versions)
#extract load in a seperate method
#improve readability of find_concats by removing necessity of two return (keep lcopy of list)

class ConcatFinderTest < Test::Unit::TestCase

  def setup
    @finder = ConcatFinder.new
  end

  def teardown
    @finder = nil
  end

  def test_possible_sub_words_are_smaller_than_six_letter
    word_list = StringIO.new("al\nbums\nalbums\npot\npantoufle")
    @finder.load(word_list)

    assert_equal(['al', 'bums','pot'].to_set, @finder.sub_words_set)
  end

  def test_restrict_candidate_to_six_letters_words
    word_list = StringIO.new("alli\nalbums\npantin\npantoufle")
    @finder.load(word_list)

    assert_equal(['albums', 'pantin'], @finder.word_candidates_list)
  end

  def test_throw_an_error_when_zero_candidate
    word_list = StringIO.new("alli\nal\npant\npantoufle")

    assert_raise(ArgumentError) do
      @finder = @finder.load(word_list)
    end

  end

  def test_throw_an_error_when_no_subwords
    word_list = StringIO.new("pantin\nalbums")

    assert_raise(ArgumentError) do
      @finder = @finder.load(word_list)
    end

  end

  def test_find_a_simple_concat
    word_list = StringIO.new("pan\ntin\npantin\npouet")
    @finder.load(word_list)

    assert_equal({'pantin' => [ 'pan', 'tin']}, @finder.find)

  end

  def test_does_not_consider_subwords_in_the_middle
    word_list = StringIO.new("neatly\nat\nneat")
    @finder.load(word_list)

    assert_equal({}, @finder.find)
  end

  def test_two_concats
    word_list = StringIO.new("al\nbums\nalbums\npouet\npan\ntin\npantin")
    @finder.load(word_list)

    assert_equal({'albums' => [ 'al', 'bums'],'pantin' => [ 'pan', 'tin']}, @finder.find)

  end

  def test_ignore_partial_sub_words
    word_list = StringIO.new("pan\npantin\nal\nbums\nalbums")
    @finder.load(word_list)

    assert_equal({'albums' => [ 'al', 'bums']}, @finder.find)
  end

  def test_accept_double_sub_words
    word_list = StringIO.new("tom\ntom\ntomtom")
    @finder.load(word_list)

    assert_equal({'tomtom' => [ 'tom', 'tom']}, @finder.find)
  end

  def test_ignore_case
    word_list = StringIO.new("Weston\nwest\non")
    @finder.load(word_list)

    assert_equal({'Weston' => [ 'west', 'on']}, @finder.find)
  end

  def test_insure_concats_are_complete_word
    word_list = StringIO.new("routed\nred\nout")
    @finder.load(word_list)

    assert_equal({}, @finder.find)

  end

  def test_load_word_list_from_file
    File.open("wordlist_test.txt","r") do | file |
      @finder .load(file)
      assert_equal({'albums' => [ 'al', 'bums']}, @finder.find)
    end
  end

end

