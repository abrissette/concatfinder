require 'set'

class ConcatFinder
    attr_reader :sub_words_list
    attr_reader :word_candidates_list

    def initialize(words = [])

      @sub_words_list = words.find_all {|word|  word.size < 6 }
      @sub_words_set = @sub_words_list.to_set
      @word_candidates_list = words.find_all {|word|  word.size == 6 }

      if @word_candidates_list.empty? then
        raise ArgumentError.new("No valid word candidate in list provided")
      end
    end

    def find
      sub_list = Hash.new
      @word_candidates_list.each do | word |
        if sub_words = find_concats(word) then
          sub_list[word] = sub_words
        end
      end
      sub_list
    end

  private
    def find_concats(word)

      @sub_words_list.each do | sub_word |
        if (word.include?(sub_word)) and (@sub_words_set.member?(word.sub(sub_word,""))) then
          return Array.new([sub_word,(word.sub(sub_word,""))])
        end
      end
        return nil
    end

end