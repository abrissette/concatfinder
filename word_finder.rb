class WordFinder

  def initialize
    @dictionary = Array.new
  end

  def load(io)
      io.each_line do |line|
        line.strip!
        @dictionary << line
      end
  end

  def find(regex)
    @dictionary.find_all {|c| regex =~ c }
  end


end