class ConcatFinder

  attr_reader :words_list

  def initialize(words = [])
    @words_list = words
  end

  def sub_words
    sub_list = Hash.new
    @words_list.each do | sub_word |
      if word = find_matches(sub_word) then
        sub_list[word] = [] if !sub_list[word]
        sub_list[word].push(sub_word)
      end
    end
    sub_list
  end

  def find_matches(sub_word)
    temp_list = @words_list

    temp_list.find do |candidate|
      if candidate.include?(sub_word) and candidate != sub_word then
        return candidate
      end
    end

  end

end