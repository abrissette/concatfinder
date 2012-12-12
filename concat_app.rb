require 'concat_finder'
require 'benchmark'

    filename = ARGV[0]
    report = String.new

    program_stats = Benchmark.measure do 
        if (ARGV.size == 0) or (!File.exists?(ARGV[0])) then
            abort("please provide a valid file name")
        end

        File.open(filename,"r") do | file |
            concat_finder = ConcatFinder.new
            result = nil

            report += "******* STATS **********\n"
            report += "loading words from file " + filename +  "...\n"
            method_stats = Benchmark.measure do 
                concat_finder.load(file)
            end
            report += "parsing completed in #{method_stats.real*1000} millisecondes\n"
            report += "#{concat_finder.word_candidates_list.size} word candidates\n"
            report += "#{concat_finder.sub_words_set.size} possible subwords\n"
    
            report += "searching concats...\n"
            method_stats = Benchmark.measure do 
                result = concat_finder.find
            end
            report +=  "search completed in #{method_stats.real*1000} millisecondes\n"
            report +=  "#{result.size} words are concatenated of 2 smaller ones\n"

            result.each { | word, concats | puts "#{word}->#{concats.inspect}\n" }
        end
    end 

    report +=  "Total time for program is #{program_stats.real*1000} millisecondes\n"

    if ARGV[1] == "-s" then
        File.open(filename + ".stats", 'w') do |f|
            f.puts report
        end
    end
