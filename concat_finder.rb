class ConcatFinder
  attr_reader :words_list

  def initialize(words = [])
    @words_list = words
  end

  def sub_words
    sub_list = []
    @words_list.each do | word |
      if is_part_of_another_one?(word) then
        sub_list << word
      end
    end
    return sub_list
  end

  def is_part_of_another_one?(sub_word)
    temp_list = @words_list

    temp_list.find { | word | word.include?(sub_word) and word != sub_word }

  end

end