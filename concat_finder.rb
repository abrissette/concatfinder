require 'set'

class ConcatFinder
    attr_reader :sub_words_set
    attr_reader :word_candidates_list

    def initialize(io)
      @sub_words_set = Set.new
      @word_candidates_list = Array.new

      parse_words_list(io)

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

    def parse_words_list(io)
      io.each_line do |line|
        line.strip!
        @sub_words_set << line if  line.size < 6
        @word_candidates_list << line if line.size == 6
      end
    end

    def find_concats(word)

      @sub_words_set.each do | sub_word |
        if (word.include?(sub_word)) then
          sub_word_index = word.index(sub_word)

          if sub_word_index == 0 then
            first_part = sub_word
            second_part = word[sub_word.size,word.size-sub_word.size] if @sub_words_set.member?(word[sub_word.size,word.size-sub_word.size])
          else
            second_part = sub_word
            first_part = word[0,word.size-sub_word.size] if @sub_words_set.member?(word[0,word.size-sub_word.size])
          end

          if first_part and second_part then
            return Array.new([first_part,second_part])
          end
        end
      end

      return nil
    end

end