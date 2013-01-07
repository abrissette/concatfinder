Concat Finder
=============

Concat Finder is a small program to find words made of two concatenated smaller words. 
The way it works is that you call it at the command line with a file name then it searches 
for words that are a concatenation of two smaller words in the same dictionary.  
The resulting list of word with their respective subwords are outputed to the console.
This program is the result of a coding exercise I tried (Kata Eight: Conflicting Objectives)
Full detail of the Kata can be found [here](http://codekata.pragprog.com/2007/01/kata_eight_conf.html)  


In the Kata it is requested to make three different solutions for the same problem with a different 
focus in mind.  The git master branch correspond to "Performance" focus and the two other correspod 
to branches "readability" and "extensibility".

How to run
----------
to start the program, clone the repo and add a file that contain the words list to the root directory (ex:wordlist.txt)

then run the following command:
    `ruby concat_app.rb wordlist.txt`

If you want some stats on a run of your script, add the switch `-s` at the end of the command line

doing so, a file with the same name of your wordlist + the extension ".stats" will be created.
