class ColorFinder

  def initialize(io)
    @dictionary = Array.new

    parse_words_list(io)

  end

  def find
    @dictionary.find_all {|c| /rouge|vert|bleu/ =~ c }
  end

  private
  def parse_words_list(io)
      io.each_line do |line|
        line.strip!
        @dictionary << line
      end
    end
end