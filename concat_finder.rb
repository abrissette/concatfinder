require 'set'

class ConcatFinder
    attr_reader :sub_words
    attr_reader :word_candidates

    def initialize(words = [])

      @sub_words = words.find_all {|word|  word.size < 6 }

      @word_candidates = words.find_all {|word|  word.size == 6 }

      if @word_candidates.empty? then
        raise ArgumentError.new("No valid word candidate in list provided")
      end
    end

    def find
      sub_list = Hash.new
      @word_candidates.each do | word |
        if sub_words = find_concats(word) then
          sub_list[word] = sub_words
        end
      end
      sub_list
    end

  private
    def find_concats(word)
      sub_words_set = @sub_words.to_set

      @sub_words.each do | sub_word |
        if (word.include?(sub_word)) and (sub_words_set.member?(word.sub(sub_word,""))) then
          return Array.new([sub_word,(word.sub(sub_word,""))])
        end
      end
        return nil
    end

end