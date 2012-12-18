require 'set'

class ConcatFinder
    attr_reader :dictionary

    def initialize
      @dictionary = Hash.new
    end

    def load(io)
       io.each_line do |line|
         line.strip!
         @dictionary[line] = true if line.size <= 6
       end

       if @dictionary.keys.select {|word| word.size == 6 }.size == 0 then
        raise ArgumentError.new("No valid word candidate")
       end

       if @dictionary.keys.select {|subword| subword.size < 6 }.size < 1 then
        raise ArgumentError.new("No potential subword")
       end
    end

    def find
      result_hash = Hash.new

      @smaller_words = @dictionary.keys.find_all { | word | word.size < 6 }
      candidates = @dictionary.keys.find_all { | word | word.size == 6 }

      candidates.each do | word |
        if sub_words = find_concats_for_word(word) then
          result_hash[word] = sub_words
        end
      end
      result_hash
    end

  private

    def find_concats_for_word(word)

      @smaller_words.each do | sub_word |

        word = word.downcase
        sub_word = sub_word.downcase

        if word.start_with?(sub_word) then
            remaining = word[sub_word.size,word.size - sub_word.size]
            if @dictionary.member?(remaining) then
              return Array.new([sub_word,remaining])
            end
        end

        if word.end_with?(sub_word) then
            begining = word[0,word.size - sub_word.size]
            if @dictionary.member?(begining)  then
              return Array.new([begining,sub_word])
            end
        end

      end
      return nil
    end

end