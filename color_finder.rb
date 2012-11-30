class ColorFinder

  def initialize
    @dictionary = Array.new
  end

  def load(io)
      io.each_line do |line|
        line.strip!
        @dictionary << line
      end
  end

  def find
    @dictionary.find_all {|c| /rouge|vert|bleu/ =~ c }
  end


end