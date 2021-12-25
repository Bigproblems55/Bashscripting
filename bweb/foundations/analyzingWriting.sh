Advanced Bash-Scripting Guide:
Prev	Appendix O. Exercises	Next
O.1. Analyzing Scripts
Examine the following script. Run it, then explain what it does. Annotate the script and rewrite it in a more compact and elegant manner.

#!/bin/bash

MAX=10000


  for((nr=1; nr<$MAX; nr++))
  do

    let "t1 = nr % 5"
    if [ "$t1" -ne 3 ]
    then
      continue
    fi

    let "t2 = nr % 7"
    if [ "$t2" -ne 4 ]
    then
      continue
    fi

    let "t3 = nr % 9"
    if [ "$t3" -ne 5 ]
    then
      continue
    fi

  break   # What happens when you comment out this line? Why?

  done

  echo "Number = $nr"


exit 0
---

Explain what the following script does. It is really just a parameterized command-line pipe.

#!/bin/bash

DIRNAME=/usr/bin
FILETYPE="shell script"
LOGFILE=logfile

file "$DIRNAME"/* | fgrep "$FILETYPE" | tee $LOGFILE | wc -l

exit 0
---

Examine and explain the following script. For hints, you might refer to the listings for find and stat.

#!/bin/bash

# Author:  Nathan Coulter
# This code is released to the public domain.
# The author gave permission to use this code snippet in the ABS Guide.

find -maxdepth 1 -type f -printf '%f\000'  | {
   while read -d $'\000'; do
      mv "$REPLY" "$(date -d "$(stat -c '%y' "$REPLY") " '+%Y%m%d%H%M%S'
      )-$REPLY"
   done
}

# Warning: Test-drive this script in a "scratch" directory.
# It will somehow affect all the files there.
---

A reader sent in the following code snippet.

while read LINE
do
  echo $LINE
done < `tail -f /var/log/messages`
He wished to write a script tracking changes to the system log file, /var/log/messages. Unfortunately, the above code block hangs and does nothing useful. Why? Fix this so it does work. (Hint: rather than redirecting the stdin of the loop, try a pipe.)

---

Analyze the following "one-liner" (here split into two lines for clarity) contributed by Rory Winston:

export SUM=0; for f in $(find src -name "*.java");
do export SUM=$(($SUM + $(wc -l $f | awk '{ print $1 }'))); done; echo $SUM
Hint: First, break the script up into bite-sized sections. Then, carefully examine its use of double-parentheses arithmetic, the export command, the find command, the wc command, and awk.

---

Analyze Example A-10, and reorganize it in a simplified and more logical style. See how many of the variables can be eliminated, and try to optimize the script to speed up its execution time.

Alter the script so that it accepts any ordinary ASCII text file as input for its initial "generation". The script will read the first $ROW*$COL characters, and set the occurrences of vowels as "living" cells. Hint: be sure to translate the spaces in the input file to underscore characters.

Prev	Home	Next
Exercises	Up	Writing Scripts



Advanced Bash-Scripting Guide:
Prev	Appendix O. Exercises	Next
O.2. Writing Scripts

Write a script to carry out each of the following tasks.

EASY

Self-reproducing Script
Write a script that backs itself up, that is, copies itself to a file named backup.sh.

Hint: Use the cat command and the appropriate positional parameter.

Home Directory Listing
Perform a recursive directory listing on the user's home directory and save the information to a file. Compress the file, have the script prompt the user to insert a USB flash drive, then press ENTER. Finally, save the file to the flash drive after making certain the flash drive has properly mounted by parsing the output of df. Note that the flash drive must be unmounted before it is removed.

Converting for loops to while and until loops
Convert the for loops in Example 11-1 to while loops. Hint: store the data in an array and step through the array elements.

Having already done the "heavy lifting," now convert the loops in the example to until loops.

Changing the line spacing of a text file
Write a script that reads each line of a target file, then writes the line back to stdout, but with an extra blank line following. This has the effect of double-spacing the file.

Include all necessary code to check whether the script gets the necessary command-line argument (a filename), and whether the specified file exists.

When the script runs correctly, modify it to triple-space the target file.

Finally, write a script to remove all blank lines from the target file, single-spacing it.

Backwards Listing
Write a script that echoes itself to stdout, but backwards.

Automatically Decompressing Files
Given a list of filenames as input, this script queries each target file (parsing the output of the file command) for the type of compression used on it. Then the script automatically invokes the appropriate decompression command (gunzip, bunzip2, unzip, uncompress, or whatever). If a target file is not compressed, the script emits a warning message, but takes no other action on that particular file.

Unique System ID
Generate a "unique" 6-digit hexadecimal identifier for your computer. Do not use the flawed hostid command. Hint: md5sum /etc/passwd, then select the first 6 digits of output.

Backup
Archive as a "tarball" (*.tar.gz file) all the files in your home directory tree (/home/your-name) that have been modified in the last 24 hours. Hint: use find.

Optional: you may use this as the basis of a backup script.

Checking whether a process is still running
Given a process ID (PID) as an argument, this script will check, at user-specified intervals, whether the given process is still running. You may use the ps and sleep commands.

Primes
Print (to stdout) all prime numbers between 60000 and 63000. The output should be nicely formatted in columns (hint: use printf).

Lottery Numbers
One type of lottery involves picking five different numbers, in the range of 1 - 50. Write a script that generates five pseudorandom numbers in this range, with no duplicates. The script will give the option of echoing the numbers to stdout or saving them to a file, along with the date and time the particular number set was generated. (If your script consistently generates winning lottery numbers, then you can retire on the proceeds and leave shell scripting to those of us who have to work for a living.)

INTERMEDIATE

Integer or String
Write a script function that determines if an argument passed to it is an integer or a string. The function will return TRUE (0) if passed an integer, and FALSE (1) if passed a string.

Hint: What does the following expression return when $1 is not an integer?

expr $1 + 0

ASCII to Integer
The atoi function in C converts a string character to an integer. Write a shell script function that performs the same operation. Likewise, write a shell script function that does the inverse, mirroring the C itoa function which converts an integer into an ASCII character.

Managing Disk Space
List, one at a time, all files larger than 100K in the /home/username directory tree. Give the user the option to delete or compress the file, then proceed to show the next one. Write to a logfile the names of all deleted files and the deletion times.

Banner
Simulate the functionality of the deprecated banner command in a script.

Removing Inactive Accounts
Inactive accounts on a network server waste disk space and may become a security risk. Write an administrative script (to be invoked by root or the cron daemon) that checks for and deletes user accounts that have not been accessed within the last 90 days.

Enforcing Disk Quotas
Write a script for a multi-user system that checks users' disk usage. If a user surpasses a preset limit (500 MB, for example) in her /home/username directory, then the script automatically sends her a "pigout" warning e-mail.

The script will use the du and mail commands. As an option, it will allow setting and enforcing quotas using the quota and setquota commands.

Logged in User Information
For all logged in users, show their real names and the time and date of their last login.

Hint: use who, lastlog, and parse /etc/passwd.

Safe Delete
Implement, as a script, a "safe" delete command, sdel.sh. Filenames passed as command-line arguments to this script are not deleted, but instead gzipped if not already compressed (use file to check), then moved to a ~/TRASH directory. Upon invocation, the script checks the ~/TRASH directory for files older than 48 hours and permanently deletes them. (An better alternative might be to have a second script handle this, periodically invoked by the cron daemon.)

Extra credit: Write the script so it can handle files and directories recursively. This would give it the capability of "safely deleting" entire directory structures.

Making Change
What is the most efficient way to make change for $1.68, using only coins in common circulations (up to 25c)? It's 6 quarters, 1 dime, a nickel, and three cents.

Given any arbitrary command-line input in dollars and cents ($*.??), calculate the change, using the minimum number of coins. If your home country is not the United States, you may use your local currency units instead. The script will need to parse the command-line input, then change it to multiples of the smallest monetary unit (cents or whatever). Hint: look at Example 24-8.

Quadratic Equations
Solve a quadratic equation of the form Ax^2 + Bx + C = 0. Have a script take as arguments the coefficients, A, B, and C, and return the solutions to five decimal places.

Hint: pipe the coefficients to bc, using the well-known formula, x = ( -B +/- sqrt( B^2 - 4AC ) ) / 2A.

Table of Logarithms
Using the bc and printf commands, print out a nicely-formatted table of eight-place natural logarithms in the interval between 0.00 and 100.00, in steps of .01.

Hint: bc requires the -l option to load the math library.

Unicode Table
Using Example T-1 as a template, write a script that prints to a file a complete Unicode table.

Hint: Use the -e option to echo: echo -e '\uXXXX', where XXXX is the Unicode numerical character designation. This requires version 4.2 or later of Bash.

Sum of Matching Numbers
Find the sum of all five-digit numbers (in the range 10000 - 99999) containing exactly two out of the following set of digits: { 4, 5, 6 }. These may repeat within the same number, and if so, they count once for each occurrence.

Some examples of matching numbers are 42057, 74638, and 89515.

Lucky Numbers
A lucky number is one whose individual digits add up to 7, in successive additions. For example, 62431 is a lucky number (6 + 2 + 4 + 3 + 1 = 16, 1 + 6 = 7). Find all the lucky numbers between 1000 and 10000.

Craps
Borrowing the ASCII graphics from Example A-40, write a script that plays the well-known gambling game of craps. The script will accept bets from one or more players, roll the dice, and keep track of wins and losses, as well as of each player's bankroll.

Tic-tac-toe
Write a script that plays the child's game of tic-tac-toe against a human player. The script will let the human choose whether to take the first move. The script will follow an optimal strategy, and therefore never lose. To simplify matters, you may use ASCII graphics:

   o | x |
   ----------
     | x |
   ----------
     | o |
     
   Your move, human (row, column)?

Alphabetizing a String
Alphabetize (in ASCII order) an arbitrary string read from the command-line.

Parsing
Parse /etc/passwd, and output its contents in nice, easy-to-read tabular form.

Logging Logins
Parse /var/log/messages to produce a nicely formatted file of user logins and login times. The script may need to run as root. (Hint: Search for the string "LOGIN.")

Pretty-Printing a Data File
Certain database and spreadsheet packages use save-files with the fields separated by commas, commonly referred to as comma-separated values or CSVs. Other applications often need to parse these files.

Given a data file with comma-separated fields, of the form:
Jones,Bill,235 S. Williams St.,Denver,CO,80221,(303) 244-7989
Smith,Tom,404 Polk Ave.,Los Angeles,CA,90003,(213) 879-5612
...
Reformat the data and print it out to stdout in labeled, evenly-spaced columns.

Justification
Given ASCII text input either from stdin or a file, adjust the word spacing to right-justify each line to a user-specified line-width, then send the output to stdout.

Mailing List
Using the mail command, write a script that manages a simple mailing list. The script automatically e-mails the monthly company newsletter, read from a specified text file, and sends it to all the addresses on the mailing list, which the script reads from another specified file.

Generating Passwords
Generate pseudorandom 8-character passwords, using characters in the ranges [0-9], [A-Z], [a-z]. Each password must contain at least two digits.

Monitoring a User
You suspect that one particular user on the network has been abusing her privileges and possibly attempting to hack the system. Write a script to automatically monitor and log her activities when she's signed on. The log file will save entries for the previous week, and delete those entries more than seven days old.

You may use last, lastlog, and lastcomm to aid your surveillance of the suspected fiend.

Checking for Broken Links
Using lynx with the -traversal option, write a script that checks a Web site for broken links.

DIFFICULT

Testing Passwords
Write a script to check and validate passwords. The object is to flag "weak" or easily guessed password candidates.

A trial password will be input to the script as a command-line parameter. To be considered acceptable, a password must meet the following minimum qualifications:

Minimum length of 8 characters

Must contain at least one numeric character

Must contain at least one of the following non-alphabetic characters: @, #, $, %, &, *, +, -, =

Optional:

Do a dictionary check on every sequence of at least four consecutive alphabetic characters in the password under test. This will eliminate passwords containing embedded "words" found in a standard dictionary.

Enable the script to check all the passwords on your system. These do not reside in /etc/passwd.

This exercise tests mastery of Regular Expressions.

Cross Reference
Write a script that generates a cross-reference (concordance) on a target file. The output will be a listing of all word occurrences in the target file, along with the line numbers in which each word occurs. Traditionally, linked list constructs would be used in such applications. Therefore, you should investigate arrays in the course of this exercise. Example 16-12 is probably not a good place to start.

Square Root
Write a script to calculate square roots of numbers using Newton's Method.

The algorithm for this, expressed as a snippet of Bash pseudo-code is:

#  (Isaac) Newton's Method for speedy extraction
#+ of square roots.

guess = $argument
#  $argument is the number to find the square root of.
#  $guess is each successive calculated "guess" -- or trial solution --
#+ of the square root.
#  Our first "guess" at a square root is the argument itself.

oldguess = 0
# $oldguess is the previous $guess.

tolerance = .000001
# To how close a tolerance we wish to calculate.

loopcnt = 0
# Let's keep track of how many times through the loop.
# Some arguments will require more loop iterations than others.


while [ ABS( $guess $oldguess ) -gt $tolerance ]
#       ^^^^^^^^^^^^^^^^^^^^^^^ Fix up syntax, of course.

#      "ABS" is a (floating point) function to find the absolute value
#+      of the difference between the two terms.
#             So, as long as difference between current and previous
#+            trial solution (guess) exceeds the tolerance, keep looping.

do
   oldguess = $guess  # Update $oldguess to previous $guess.

#  =======================================================
   guess = ( $oldguess + ( $argument / $oldguess ) ) / 2.0
#        = 1/2 ( ($oldguess **2 + $argument) / $oldguess )
#  equivalent to:
#        = 1/2 ( $oldguess + $argument / $oldguess )
#  that is, "averaging out" the trial solution and
#+ the proportion of argument deviation
#+ (in effect, splitting the error in half).
#  This converges on an accurate solution
#+ with surprisingly few loop iterations . . .
#+ for arguments > $tolerance, of course.
#  =======================================================

   (( loopcnt++ ))     # Update loop counter.
done

It's a simple enough recipe, and seems at first glance easy enough to convert into a working Bash script. The problem, though, is that Bash has no native support for floating point numbers. So, the script writer needs to use bc or possibly awk to convert the numbers and do the calculations. It could get rather messy . . .

Logging File Accesses
Log all accesses to the files in /etc during the course of a single day. This information should include the filename, user name, and access time. If any alterations to the files take place, that will be flagged. Write this data as tabular (tab-separated) formatted records in a logfile.

Monitoring Processes
Write a script to continually monitor all running processes and to keep track of how many child processes each parent spawns. If a process spawns more than five children, then the script sends an e-mail to the system administrator (or root) with all relevant information, including the time, PID of the parent, PIDs of the children, etc. The script appends a report to a log file every ten minutes.

Strip Comments
Strip all comments from a shell script whose name is specified on the command-line. Note that the initial #! line must not be stripped out.

Strip HTML Tags
Strip all the HTML tags from a specified HTML file, then reformat it into lines between 60 and 75 characters in length. Reset paragraph and block spacing, as appropriate, and convert HTML tables to their approximate text equivalent.

XML Conversion
Convert an XML file to both HTML and text format.

Optional: A script that converts Docbook/SGML to XML.

Chasing Spammers
Write a script that analyzes a spam e-mail by doing DNS lookups on the IP addresses in the headers to identify the relay hosts as well as the originating ISP. The script will forward the unaltered spam message to the responsible ISPs. Of course, it will be necessary to filter out your own ISP's IP address, so you don't end up complaining about yourself.

As necessary, use the appropriate network analysis commands.

For some ideas, see Example 16-41 and Example A-28.

Optional: Write a script that searches through a list of e-mail messages and deletes the spam according to specified filters.

Creating man pages
Write a script that automates the process of creating man pages.

Given a text file which contains information to be formatted into a man page, the script will read the file, then invoke the appropriate groff commands to output the corresponding man page to stdout. The text file contains blocks of information under the standard man page headings, i.e., NAME, SYNOPSIS, DESCRIPTION, etc.

Example A-39 is an instructive first step.

Hex Dump
Do a hex(adecimal) dump on a binary file specified as an argument to the script. The output should be in neat tabular fields, with the first field showing the address, each of the next 8 fields a 4-byte hex number, and the final field the ASCII equivalent of the previous 8 fields.

The obvious followup to this is to extend the hex dump script into a disassembler. Using a lookup table, or some other clever gimmick, convert the hex values into 80x86 op codes.

Emulating a Shift Register
Using Example 27-15 as an inspiration, write a script that emulates a 64-bit shift register as an array. Implement functions to load the register, shift left, shift right, and rotate it. Finally, write a function that interprets the register contents as eight 8-bit ASCII characters.

Calculating Determinants
Write a script that calculates determinants [1] by recursively expanding the minors. Use a 4 x 4 determinant as a test case.

Hidden Words
Write a "word-find" puzzle generator, a script that hides 10 input words in a 10 x 10 array of random letters. The words may be hidden across, down, or diagonally.

Optional: Write a script that solves word-find puzzles. To keep this from becoming too difficult, the solution script will find only horizontal and vertical words. (Hint: Treat each row and column as a string, and search for substrings.)

Anagramming
Anagram 4-letter input. For example, the anagrams of word are: do or rod row word. You may use /usr/share/dict/linux.words as the reference list.

Word Ladders
A "word ladder" is a sequence of words, with each successive word in the sequence differing from the previous one by a single letter.

For example, to "ladder" from mark to vase:

mark --> park --> part --> past --> vast --> vase
         ^           ^       ^      ^           ^
Write a script that solves word ladder puzzles. Given a starting and an ending word, the script will list all intermediate steps in the "ladder." Note that all words in the sequence must be legitimate dictionary words.

Fog Index
The "fog index" of a passage of text estimates its reading difficulty, as a number corresponding roughly to a school grade level. For example, a passage with a fog index of 12 should be comprehensible to anyone with 12 years of schooling.

The Gunning version of the fog index uses the following algorithm.

Choose a section of the text at least 100 words in length.

Count the number of sentences (a portion of a sentence truncated by the boundary of the text section counts as one).

Find the average number of words per sentence.

AVE_WDS_SEN = TOTAL_WORDS / SENTENCES

Count the number of "difficult" words in the segment -- those containing at least 3 syllables. Divide this quantity by total words to get the proportion of difficult words.

PRO_DIFF_WORDS = LONG_WORDS / TOTAL_WORDS

The Gunning fog index is the sum of the above two quantities, multiplied by 0.4, then rounded to the nearest integer.

G_FOG_INDEX = int ( 0.4 * ( AVE_WDS_SEN + PRO_DIFF_WORDS ) )

Step 4 is by far the most difficult portion of the exercise. There exist various algorithms for estimating the syllable count of a word. A rule-of-thumb formula might consider the number of letters in a word and the vowel-consonant mix.

A strict interpretation of the Gunning fog index does not count compound words and proper nouns as "difficult" words, but this would enormously complicate the script.

Calculating PI using Buffon's Needle
The Eighteenth Century French mathematician de Buffon came up with a novel experiment. Repeatedly drop a needle of length n onto a wooden floor composed of long and narrow parallel boards. The cracks separating the equal-width floorboards are a fixed distance d apart. Keep track of the total drops and the number of times the needle intersects a crack on the floor. The ratio of these two quantities turns out to be a fractional multiple of PI.

In the spirit of Example 16-50, write a script that runs a Monte Carlo simulation of Buffon's Needle. To simplify matters, set the needle length equal to the distance between the cracks, n = d.

Hint: there are actually two critical variables: the distance from the center of the needle to the nearest crack, and the inclination angle of the needle to that crack. You may use bc to handle the calculations.

Playfair Cipher
Implement the Playfair (Wheatstone) Cipher in a script.

The Playfair Cipher encrypts text by substitution of digrams (2-letter groupings). It is traditional to use a 5 x 5 letter scrambled-alphabet key square for the encryption and decryption.

   C O D E S
   A B F G H
   I K L M N
   P Q R T U
   V W X Y Z

Each letter of the alphabet appears once, except "I" also represents
"J". The arbitrarily chosen key word, "CODES" comes first, then all
the rest of the alphabet, in order from left to right, skipping letters
already used.

To encrypt, separate the plaintext message into digrams (2-letter
groups). If a group has two identical letters, delete the second, and
form a new group. If there is a single letter left over at the end,
insert a "null" character, typically an "X."

THIS IS A TOP SECRET MESSAGE

TH IS IS AT OP SE CR ET ME SA GE



For each digram, there are three possibilities.
-----------------------------------------------

1) Both letters will be on the same row of the key square:
   For each letter, substitute the one immediately to the right, in that
   row. If necessary, wrap around left to the beginning of the row.

or

2) Both letters will be in the same column of the key square:
   For each letter, substitute the one immediately below it, in that
   row. If necessary, wrap around to the top of the column.

or

3) Both letters will form the corners of a rectangle within the key square:
   For each letter, substitute the one on the other corner the rectangle
   which lies on the same row.


The "TH" digram falls under case #3.
G H
M N
T U           (Rectangle with "T" and "H" at corners)

T --> U
H --> G


The "SE" digram falls under case #1.
C O D E S     (Row containing "S" and "E")

S --> C  (wraps around left to beginning of row)
E --> S

=========================================================================

To decrypt encrypted text, reverse the above procedure under cases #1
and #2 (move in opposite direction for substitution). Under case #3,
just take the remaining two corners of the rectangle.


Helen Fouche Gaines' classic work, ELEMENTARY CRYPTANALYSIS (1939), gives a
fairly detailed description of the Playfair Cipher and its solution methods.
This script will have three main sections

Generating the key square, based on a user-input keyword.

Encrypting a plaintext message.

Decrypting encrypted text.

The script will make extensive use of arrays and functions. You may use Example A-56 as an inspiration.

--

Please do not send the author your solutions to these exercises. There are more appropriate ways to impress him with your cleverness, such as submitting bugfixes and suggestions for improving the book.

Notes
[1]	
For all you clever types who failed intermediate algebra, a determinant is a numerical value associated with a multidimensional matrix (array of numbers).
For the simple case of a 2 x 2 determinant:

  |a  b|
  |b  a|

The solution is a*a - b*b, where "a" and "b" represent numbers.
Prev	Home	Next
Analyzing Scripts	Up	Revision History


