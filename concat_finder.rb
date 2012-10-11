require 'set'

class ConcatFinder
    attr_reader :sub_words_list
    attr_reader :word_candidates_list

    def initialize(io)
      @sub_words_list = []
      @word_candidates_list = []

      io.each_line do |line |
        line.strip!
        @sub_words_list << line  if  line.size < 6
        @word_candidates_list << line  if line.size == 6
      end
      @sub_words_set = @sub_words_list.to_set

      if @word_candidates_list.empty? then
        raise ArgumentError.new("No valid word candidate in list provided")
      end
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

      @sub_words_list.each do | sub_word |
        if (word.include?(sub_word)) and (@sub_words_set.member?(word.sub(sub_word,""))) then
          return Array.new([sub_word,(word.sub(sub_word,""))])
        end
      end
        return nil
    end

    finder = ConcatFinder.new(STDIN)
    puts finder.find.inspect
end