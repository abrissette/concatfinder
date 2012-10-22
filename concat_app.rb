require 'concat_finder'

  program_start = Time.now
  if (ARGV.size == 0) or (!File.exists?(ARGV[0])) then
    abort("please provide a valid file name")
  end

  filename = ARGV[0]
  report = String.new

  File.open(filename,"r") do | file |

    report += "******* STATS **********\n"
    report += "loading words from file " + filename +  "...\n"
    time_stamp_start = Time.now
    concat_finder = ConcatFinder.new(file)
    time_stamp_stop = Time.now
    report += "parsing completed in #{(time_stamp_stop - time_stamp_start)*1000} millisecondes\n"
    report += "#{concat_finder.word_candidates_list.size} word candidates\n"
    report += "#{concat_finder.sub_words_set.size} possible subwords\n"

    report += "searching concats...\n"
    time_stamp_start = Time.now
    result = concat_finder.find
    time_stamp_stop = Time.now
    report +=  "search completed in #{(time_stamp_stop - time_stamp_start)*1000} millisecondes\n"
    report +=  "#{result.size} words are concatenated of 2 smaller ones\n"

    program_stop = Time.now
    report +=  "Total time for program is #{(program_stop - program_start)*1000} millisecondes\n"

    result.each { | word, concats | puts "#{word}->#{concats.inspect}\n" }

  end

  if ARGV[1] == "-s" then
    File.open(filename + ".stats", 'w') do |f|
      f.puts report
    end
  end
