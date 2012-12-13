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

       if @dictionary.keys.select {|subword| subword.size < 6 }.size < 2 then
        raise ArgumentError.new("No potential subword")
       end
    end

    def find
      result_hash = Hash.new
      @dictionary.each do | word |

        if word.size == 6 then

          if sub_words = find_concats(word) then
            result_hash[word] = sub_words
          end
        end
      end
      result_hash
    end

  private

    def find_concats(word)

      @dictionary.each do | sub_word |

        if sub_word.size < 6 then

          word = word.downcase
          sub_word = sub_word.downcase

          if (word.include?(sub_word)) then
            index = word.index(sub_word)

            if index == 0 then
              first_part = sub_word
              remaining = word[first_part.size,word.size - first_part.size]
              second_part = remaining if @dictionary.member?(remaining)
            else
              second_part = sub_word
              begining = word[0,word.size - second_part.size]
              first_part = begining if @dictionary.member?(begining) and (begining+second_part) == word
            end

            if first_part and second_part then
              return Array.new([first_part,second_part])
            end
          end
        end

      end

      return nil
    end

end