Concat Finder
=============

Concat Finder is a small program to find word made of two concatenated smaller words. 
The way it work is that you call it at the command line with a file name then it search 
for words that are a concatenation of two smaller words in the same dictionary.  
The resulting list of word with their repective subwords are outputed to the console.
This program is the result of a coding exercise I tried (Kata Eight: Conflicting Objectives)
Full detail of the Kata can be found [here](http://codekata.pragprog.com/2007/01/kata_eight_conf.html)  

How to run
----------
to start the program, clone the repo and add a file that contain the words list to the root directory (ex:wordlist.txt)

then run the following command:
    `ruby concat_app.rb wordlist.txt`

If you want some stats on the a run of your script, add the switch `-s` at the end of the command line

doing so, a file with the same name of your wordlist + the extension ".stats" will be created.
