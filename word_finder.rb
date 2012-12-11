class WordFinder

  attr_reader :dictionary

  def initialize
    @dictionary = Array.new
  end

  def load(io)

    raise ArgumentError.new("invalid IO as input") if !(io.respond_to?(:read))

    io.each_line do |line|
      line.strip!
      @dictionary << line
    end

  end

  def find(regex)
    raise ArgumentError.new("dictionary is empty")  if @dictionary.empty?

    @dictionary.find_all {|c| regex =~ c }
  end

end