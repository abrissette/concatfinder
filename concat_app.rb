require 'concat_finder'

  if (ARGV.size == 0) or (!File.exists?(ARGV[0])) then
    abort("please provide a valid file name")
  end

  filename = ARGV[0]
  File.open(filename,"r") do | file |

    puts "loading words from file " + filename +  "...\n"
    debut = Time.now
    concat_finder = ConcatFinder.new(file)
    fin = Time.now
    puts "parsing completed in #{(fin - debut)*1000} millisecondes\n"
    puts "#{concat_finder.word_candidates_list.size} word candidates\n"
    puts "#{concat_finder.sub_words_set.size} possible subwords\n"

    puts "searching concats...\n"
    debut = Time.now
    result = concat_finder.find
    fin = Time.now
    puts "search completed in #{(fin - debut)*1000} millisecondes\n"
    puts "#{result.size} words are concatenated of 2 smaller ones"

  end