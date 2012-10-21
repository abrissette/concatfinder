require 'set'

class ConcatFinder
    attr_reader :sub_words_set
    attr_reader :word_candidates_list

    def initialize(io)
      @sub_words_set = Set.new
      @word_candidates_list = Array.new

      io.each_line do |line |
        line.strip!
        @sub_words_set << line  if  line.size < 6
        @word_candidates_list << line  if line.size == 6
      end

      raise ArgumentError.new("No valid word candidate")  if @word_candidates_list.empty?
      raise ArgumentError.new("No valid subwords")  if @sub_words_set.empty?
    end

    def find
      result_hash = Hash.new
      @word_candidates_list.each do | word |
        if sub_words = find_concats(word) then
          result_hash[word] = sub_words
        end
      end
      result_hash
    end

  private
    def find_concats(word)

      @sub_words_set.each do | sub_word |
        if (word.include?(sub_word)) and (@sub_words_set.member?(word.sub(sub_word,""))) then
          if word.index(sub_word) == 0 then
            return Array.new([sub_word,(word.sub(sub_word,""))])
          else
            return Array.new([(word.sub(sub_word,"")),sub_word])
          end
        end
      end
        return nil
    end

end