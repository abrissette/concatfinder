require 'set'
require 'word_finder'

class ConcatFinder < WordFinder
    attr_reader :sub_words_set

    def initialize()
      super
      @sub_words_set = Set.new

    end

    def load(io, word_size = 6)
      pre_parsed_dictionary = Array.new

      super(io)

      @dictionary.each do |line|
        @sub_words_set << line if  line.size < word_size
        pre_parsed_dictionary << line if line.size == word_size
      end
      @dictionary = pre_parsed_dictionary

      raise ArgumentError.new("No valid subwords")  if @sub_words_set.empty?
    end

    def find
      raise ArgumentError.new("dictionary is empty")  if @dictionary.empty?

      result_hash = Hash.new
      @dictionary.each do | word |
        if sub_words = find_concats(word) then
          result_hash[word] = sub_words
        end
      end
      result_hash
    end

private

    def find_concats(word)

      @sub_words_set.each do | sub_word |
        word = word.downcase
        sub_word = sub_word.downcase

        if (word.include?(sub_word)) then
          index = word.index(sub_word)

          if index == 0 then
            first_part = sub_word
            remaining = word[first_part.size,word.size - first_part.size]
            second_part = remaining if @sub_words_set.member?(remaining)
          else
            second_part = sub_word
            begining = word[0,word.size - second_part.size]
            first_part = begining if @sub_words_set.member?(begining) and (begining+second_part) == word
          end

          if first_part and second_part then
            return Array.new([first_part,second_part])
          end
        end
      end

      return nil
    end

end