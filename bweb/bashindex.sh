Advanced Bash-Scripting Guide:
Prev		 
Index
This index / glossary / quick-reference lists many of the important topics covered in the text. Terms are arranged in approximate ASCII sorting order, modified as necessary for enhanced clarity.

Note that commands are indexed in Part 4.

* * *

^ (caret)

Beginning-of-line, in a Regular Expression

^

^^

Uppercase conversion in parameter substitution

~ Tilde

~ home directory, corresponds to $HOME

~/ Current user's home directory

~+ Current working directory

~- Previous working directory

= Equals sign

= Variable assignment operator

= String comparison operator

== String comparison operator

=~ Regular Expression match operator

Example script

< Left angle bracket

Is-less-than

String comparison

Integer comparison within double parentheses

Redirection

< stdin

<< Here document

<<< Here string

<> Opening a file for both reading and writing

> Right angle bracket

Is-greater-than

String comparison

Integer comparison, within double parentheses

Redirection

> Redirect stdout to a file

>> Redirect stdout to a file, but append

i>&j Redirect file descriptor i to file descriptor j

>&j Redirect stdout to file descriptor j

>&2 Redirect stdout of a command to stderr

2>&1 Redirect stderr to stdout

&> Redirect both stdout and stderr of a command to a file

:> file Truncate file to zero length

| Pipe, a device for passing the output of a command to another command or to the shell

|| Logical OR test operator

- (dash)

Prefix to default parameter, in parameter substitution

Prefix to option flag

Indicating redirection from stdin or stdout

-- (double-dash)

Prefix to long command options

C-style variable decrement within double parentheses

; (semicolon)

As command separator

\; Escaped semicolon, terminates a find command

;; Double-semicolon, terminator in a case option

Required when ...

do keyword is on the first line of loop

terminating curly-bracketed code block

;;& ;& Terminators in a case option (version 4+ of Bash).

: Colon

:> filename Truncate file to zero length

null command, equivalent to the true Bash builtin

Used in an anonymous here document

Used in an otherwise empty function

Used as a function name

! Negation operator, inverts exit status of a test or command

!= not-equal-to String comparison operator

? (question mark)

Match zero or one characters, in an Extended Regular Expression

Single-character wild card, in globbing

In a C-style Trinary operator

// Double forward slash, behavior of cd command toward

. (dot / period)

. Load a file (into a script), equivalent to source command

. Match single character, in a Regular Expression

. Current working directory

./ Current working directory

.. Parent directory

' ... ' (single quotes) strong quoting

" ... " (double quotes) weak quoting

Double-quoting the backslash (\) character

,

Comma operator

,

,,

Lowercase conversion in parameter substitution

() Parentheses

( ... ) Command group; starts a subshell

( ... ) Enclose group of Extended Regular Expressions

>( ... )

<( ... ) Process substitution

... ) Terminates test-condition in case construct

(( ... )) Double parentheses, in arithmetic expansion

[ Left bracket, test construct

[ ]Brackets

Array element

Enclose character set to match in a Regular Expression

Test construct

[[ ... ]] Double brackets, extended test construct

$ Anchor, in a Regular Expression

$ Prefix to a variable name

$( ... ) Command substitution, setting a variable with output of a command, using parentheses notation

` ... ` Command substitution, using backquotes notation

$[ ... ] Integer expansion (deprecated)

${ ... } Variable manipulation / evaluation

${var} Value of a variable

${#var} Length of a variable

${#@}

${#*} Number of positional parameters

${parameter?err_msg} Parameter-unset message

${parameter-default}

${parameter:-default}

${parameter=default}

${parameter:=default} Set default parameter

${parameter+alt_value}

${parameter:+alt_value}

Alternate value of parameter, if set

${!var}

Indirect referencing of a variable, new notation

${!#}

Final positional parameter. (This is an indirect reference to $#.)

${!varprefix*}

${!varprefix@}

Match names of all previously declared variables beginning with varprefix

${string:position}

${string:position:length} Substring extraction

${var#Pattern}

${var##Pattern} Substring removal

${var%Pattern}

${var%%Pattern} Substring removal

${string/substring/replacement}

${string//substring/replacement}

${string/#substring/replacement}

${string/%substring/replacement} Substring replacement

$' ... ' String expansion, using escaped characters.

\ Escape the character following

\< ... \> Angle brackets, escaped, word boundary in a Regular Expression

\{ N \} "Curly" brackets, escaped, number of character sets to match in an Extended RE

\; Semicolon, escaped, terminates a find command

\$$ Indirect reverencing of a variable, old-style notation

Escaping a newline, to write a multi-line command

&

&> Redirect both stdout and stderr of a command to a file

>&j Redirect stdout to file descriptor j

>&2 Redirect stdout of a command to stderr

i>&j Redirect file descriptor i to file descriptor j

2>&1 Redirect stderr to stdout

Closing file descriptors

n<&- Close input file descriptor n

0<&-, <&- Close stdin

n>&- Close output file descriptor n

1>&-, >&- Close stdout

&& Logical AND test operator

Command & Run job in background

# Hashmark, special symbol beginning a script comment

#! Sha-bang, special string starting a shell script

* Asterisk

Wild card, in globbing

Any number of characters in a Regular Expression

** Exponentiation, arithmetic operator

** Extended globbing file-match operator

% Percent sign

Modulo, division-remainder arithmetic operation

Substring removal (pattern matching) operator

+ Plus sign

Character match, in an extended Regular Expression

Prefix to alternate parameter, in parameter substitution

++ C-style variable increment, within double parentheses

* * *

Shell Variables

$_ Last argument to previous command

$- Flags passed to script, using set

$! Process ID of last background job

$? Exit status of a command

$@ All the positional parameters, as separate words

$* All the positional parameters, as a single word

$$ Process ID of the script

$# Number of arguments passed to a function, or to the script itself

$0 Filename of the script

$1 First argument passed to script

$9 Ninth argument passed to script

Table of shell variables

* * * * * *

-a Logical AND compound comparison test

Address database, script example

Advanced Bash Scripting Guide, where to download

Alias

Removing an alias, using unalias

Anagramming

And list

To supply default command-line argument

And logical operator &&

Angle brackets, escaped, \< . . . \> word boundary in a Regular Expression

Anonymous here document, using :

Archiving

rpm

tar

Arithmetic expansion

exit status of

variations of

Arithmetic operators

combination operators, C-style

+= -= *= /= %=

Note	
In certain contexts, += can also function as a string concatenation operator.

Arrays

Associative arrays

more efficient than conventional arrays

Bracket notation

Concatenating, example script

Copying

Declaring

declare -a array_name

Embedded arrays

Empty arrays, empty elements, example script

Indirect references

Initialization

array=( element1 element2 ... elementN)

Example script

Using command substitution

Loading a file into an array

Multidimensional, simulating

Nesting and embedding

Notation and usage

Number of elements in

${#array_name[@]}

${#array_name[*]}

Operations

Passing an array to a function

As return value from a function

Special properties, example script

String operations, example script

unset deletes array elements

Arrow keys, detecting

ASCII

Definition

Scripts for generating ASCII table

awk field-oriented text processing language

rand(), random function

String manipulation

Using export to pass a variable to an embedded awk script

* * *

Backlight, setting the brightness

Backquotes, used in command substitution

Base conversion, example script

Bash

Bad scripting practices

Basics reviewed, script example

Command-line options

Table

Features that classic Bourne shell lacks

Internal variables

Version 2

Version 3

Version 4

Version 4.1

Version 4.2

.bashrc

$BASH_SUBSHELL

Basic commands, external

Batch files, DOS

Batch processing

bc, calculator utility

In a here document

Template for calculating a script variable

Bibliography

Bison utility

Bitwise operators

Example script

Block devices

testing for

Blocks of code

Iterating / looping

Redirection

Script example: Redirecting output of a a code block

Bootable flash drives, creating

Brace expansion

Extended, {a..z}

Parameterizing

With increment and zero-padding (new feature in Bash, version 4)

Brackets, [ ]

Array element

Enclose character set to match in a Regular Expression

Test construct

Brackets, curly, {}, used in

Code block

find

Extended Regular Expressions

Positional parameters

xargs

break loop control command

Parameter (optional)

Builtins in Bash

Do not fork a subprocess

* * *

case construct

Command-line parameters, handling

Globbing, filtering strings with

cat, concatentate file(s)

Abuse of

cat scripts

Less efficient than redirecting stdin

Piping the output of, to a read

Uses of

Character devices

testing for

Checksum

Child processes

Colon, : , equivalent to the true Bash builtin

Colorizing scripts

Cycling through the background colors, example script

Table of color escape sequences

Template, colored text on colored background

Comma operator, linking commands or operations

Command-line options

command_not_found_handle () builtin error-handling function (version 4+ of Bash)

Command substitution

$( ... ), preferred notation

Backquotes

Extending the Bash toolset

Invokes a subshell

Nesting

Removes trailing newlines

Setting variable from loop output

Word splitting

Comment headers, special purpose

Commenting out blocks of code

Using an anonymous here document

Using an if-then construct

Communications and hosts

Compound comparison operators

Compression utilities

bzip2

compress

gzip

zip

continue loop control command

Control characters

Control-C, break

Control-D, terminate / log out / erase

Control-G, BEL (beep)

Control-H, rubout

Control-J, newline

Control-M, carriage return

Coprocesses

cron, scheduling daemon

C-style syntax , for handling variables

Crossword puzzle solver

Cryptography

Curly brackets {}

in find command

in an Extended Regular Expression

in xargs

* * *

Daemons, in UNIX-type OS

date

dc, calculator utility

dd, data duplicator command

Conversions

Copying raw data to/from devices

File deletion, secure

Keystrokes, capturing

Options

Random access on a data stream

Raspberry Pi, script for preparing a bootable SD card

Swapfiles, initializing

Thread on www.linuxquestions.org

Debugging scripts

Tools

Trapping at exit

Trapping signals

Decimal number, Bash interprets numbers as

declare builtin

options

case-modification options (version 4+ of Bash)

Default parameters

/dev directory

/dev/null pseudo-device file

/dev/urandom pseudo-device file, generating pseudorandom numbers with

/dev/zero, pseudo-device file

Device file

dialog, utility for generating dialog boxes in a script

$DIRSTACK directory stack

Disabled commands, in restricted shells

do keyword, begins execution of commands within a loop

done keyword, terminates a loop

DOS batch files, converting to shell scripts

DOS commands, UNIX equivalents of (table)

dot files, "hidden" setup and configuration files

Double brackets [[ ... ]] test construct

and evaluation of octal/hex constants

Double parentheses (( ... )) arithmetic expansion/evaluation construct

Double quotes " ... " weak quoting

Double-quoting the backslash (\) character

Double-spacing a text file, using sed

* * *

-e File exists test

echo

Feeding commands down a pipe

Setting a variable using command substitution

/bin/echo, external echo command

elif, Contraction of else and if

else

Encrypting files, using openssl

esac, keyword terminating case construct

Environmental variables

-eq , is-equal-to integer comparison test

Eratosthenes, Sieve of, algorithm for generating prime numbers

Escaped characters, special meanings of

Within $' ... ' string expansion

Used with Unicode characters

/etc/fstab (filesystem mount) file

/etc/passwd (user account) file

$EUID, Effective user ID

eval, Combine and evaluate expression(s), with variable expansion

Effects of, Example script

Forces reevaluation of arguments

And indirect references

Risk of using

Using eval to convert array elements into a command list

Using eval to select among variables

Evaluation of octal/hex constants within [[ ... ]]

exec command, using in redirection

Exercises

Exit and Exit status

exit command

Exit status (exit code, return status of a command)

Table, Exit codes with special meanings

Anomalous

Out of range

Pipe exit status

Specified by a function return

Successful, 0

/usr/include/sysexits.h, system file listing C/C++ standard exit codes

Export, to make available variables to child processes

Passing a variable to an embedded awk script

expr, Expression evaluator

Substring extraction

Substring index (numerical position in string)

Substring matching

Extended Regular Expressions

? (question mark) Match zero / one characters

( ... ) Group of expressions

\{ N \} "Curly" brackets, escaped, number of character sets to match

+ Character match

* * *

factor, decomposes an integer into its prime factors

Application: Generating prime numbers

false, returns unsuccessful (1) exit status

Field, a group of characters that comprises an item of data

Files / Archiving

File descriptors

Closing

n<&- Close input file descriptor n

0<&-, <&- Close stdin

n>&- Close output file descriptor n

1>&-, >&- Close stdout

File handles in C, similarity to

File encryption

find

{} Curly brackets

\; Escaped semicolon

Filter

Using - with file-processing utility as a filter

Feeding output of a filter back to same filter

Floating point numbers, Bash does not recognize

fold, a filter to wrap lines of text

Forking a child process

for loops

Functions

Arguments passed referred to by position

Capturing the return value of a function using echo

Colon as function name

Definition must precede first call to function

Exit status

Local variables

and recursion

Passing an array to a function

Passing pointers to a function

Positional parameters

Recursion

Redirecting stdin of a function

return

Multiple return values from a function, example script

Returning an array from a function

Return range limits, workarounds

Shift arguments passed to a function

Unusual function names

* * *

Games and amusements

Anagrams

Anagrams, again

Bingo Number Generator

Crossword puzzle solver

Crypto-Quotes

Dealing a deck of cards

Fifteen Puzzle

Horse race

Knight's Tour

"Life" game

Magic Squares

Music-playing script

Nim

Pachinko

Perquackey

Petals Around the Rose

Podcasting

Poem

Speech generation

Towers of Hanoi

Graphic version

Alternate graphic version

getopt, external command for parsing script command-line arguments

Emulated in a script

getopts, Bash builtin for parsing script command-line arguments

$OPTIND / $OPTARG

Global variable

Globbing, filename expansion

Handling filenames correctly

Wild cards

Will not match dot files

Golden Ratio (Phi)

-ge , greater-than or equal integer comparison test

-gt , greater-than integer comparison test

groff, text markup and formatting language

Gronsfeld cipher

$GROUPS, Groups user belongs to

gzip, compression utility

* * *

Hashing, creating lookup keys in a table

Example script

head, echo to stdout lines at the beginning of a text file

help, gives usage summary of a Bash builtin

Here documents

Anonymous here documents, using :

Commenting out blocks of code

Self-documenting scripts

bc in a here document

cat scripts

Command substitution

ex scripts

Function, supplying input to

Here strings

Calculating the Golden Ratio

Prepending text

As the stdin of a loop

Using read

Limit string

! as a limit string

Closing limit string may not be indented

Dash option to limit string, <<-LimitString

Literal text output, for generating program code

Parameter substitution

Disabling parameter substitution

Passing parameters

Temporary files

Using vi non-interactively

History commands

$HOME, user's home directory

Homework assignment solver

$HOSTNAME, system host name

* * *

$Id parameter, in rcs (Revision Control System)

if [ condition ]; then ... test construct

if-grep, if and grep in combination

Fixup for if-grep test

$IFS, Internal field separator variable

Defaults to whitespace

Integer comparison operators

in, keyword preceding [list] in a for loop

Initialization table, /etc/inittab

Inline group, i.e., code block

Interactive script, test for

I/O redirection

Indirect referencing of variables

New notation, introduced in version 2 of Bash ( example script)

iptables, packet filtering and firewall utility

Usage example

Example script

Iteration

* * *

Job IDs, table

jot, Emit a sequence of integers. Equivalent to seq.

Random sequence generation

Just another Bash hacker!

* * *

Keywords

error, if missing

kill, terminate a process by process ID

Options (-l, -9)

killall, terminate a process by name

killall script in /etc/rc.d/init.d

* * *

lastpipe shell option

-le , less-than or equal integer comparison test

let, setting and carrying out arithmetic operations on variables

C-style increment and decrement operators

Limit string, in a here document

$LINENO, variable indicating the line number where it appears in a script

Link, file (using ln command)

Invoking script with multiple names, using ln

symbolic links, ln -s

List constructs

And list

Or list

Local variables

and recursion

Localization

Logical operators (&&, ||, etc.)

Logout file, the ~/.bash_logout file

Loopback device, mounting a file on a block device

Loops

break loop control command

continue loop control command

C-style loop within double parentheses

for loop

while loop

do (keyword), begins execution of commands within a loop

done (keyword), terminates a loop

for loops

for arg in [list]; do

Command substitution to generate [list]

Filename expansion in [list]

Multiple parameters in each [list] element

Omitting [list], defaults to positional parameters

Parameterizing [list]

Redirection

in, (keyword) preceding [list] in a for loop

Nested loops

Running a loop in the background, script example

Semicolon required, when do is on first line of loop

for loop

while loop

until loop

until [ condition-is-true ]; do

while loop

while [ condition ]; do

Function call inside test brackets

Multiple conditions

Omitting test brackets

Redirection

while read construct

Which type of loop to use

Loopback devices

In /dev directory

Mounting an ISO image

-lt , less-than integer comparison test

* * *

m4, macro processing language

$MACHTYPE, Machine type

Magic number, marker at the head of a file indicating the file type

Makefile, file containing the list of dependencies used by make command

man, manual page (lookup)

Man page editor (script)

mapfile builtin, loads an array with a text file

Math commands

Meta-meaning

Morse code training script

Modulo, arithmetic remainder operator

Application: Generating prime numbers

Mortgage calculations, example script

* * *

-n String not null test

Named pipe, a temporary FIFO buffer

Example script

nc, netcat, a network toolkit for TCP and UDP ports

-ne, not-equal-to integer comparison test

Negation operator, !, reverses the sense of a test

netstat, Network statistics

Network programming

nl, a filter to number lines of text

Noclobber, -C option to Bash to prevent overwriting of files

NOT logical operator, !

null variable assignment, avoiding

* * *

-o Logical OR compound comparison test

Obfuscation

Colon as function name

Homework assignment

Just another Bash hacker!

octal, base-8 numbers

od, octal dump

$OLDPWD Previous working directory

openssl encryption utility

Operator

Definition of

Precedence

Options, passed to shell or script on command line or by set command

Or list

Or logical operator, ||

* * *

Parameter substitution

${parameter+alt_value}

${parameter:+alt_value}

Alternate value of parameter, if set

${parameter-default}

${parameter:-default}

${parameter=default}

${parameter:=default}

Default parameters

${!varprefix*}

${!varprefix@}

Parameter name match

${parameter?err_msg}

Parameter-unset message

${parameter}

Value of parameter

Case modification (version 4+ of Bash).

Script example

Table of parameter substitution

Parent / child process problem, a child process cannot export variables to a parent process

Parentheses

Command group

Enclose group of Extended Regular Expressions

Double parentheses, in arithmetic expansion

$PATH, the path (location of system binaries)

Appending directories to $PATH using the += operator.

Pathname, a filename that incorporates the complete path of a given file.

Parsing pathnames

Perl, programming language

Combined in the same file with a Bash script

Embedded in a Bash script

Perquackey-type anagramming game (Quackey script)

Petals Around the Rose

PID, Process ID, an identification number assigned to a running process.

Pipe, | , a device for passing the output of a command to another command or to the shell

Avoiding unnecessary commands in a pipe

Comments embedded within

Exit status of a pipe

Pipefail, set -o pipefail option to indicate exit status within a pipe

$PIPESTATUS, exit status of last executed pipe

Piping output of a command to a script

Redirecting stdin, rather than using cat in a pipe

Pitfalls

- (dash) is not redirection operator

// (double forward slash), behavior of cd command toward

#!/bin/sh script header disables extended Bash features

Abuse of cat

CGI programming, using scripts for

Closing limit string in a here document, indenting

DOS-type newlines (\r\n) crash a script

Double-quoting the backslash (\) character

eval, risk of using

Execute permission lacking for commands within a script

Exit status, anomalous

Exit status of arithmetic expression not equivalent to an error code

Export problem, child process to parent process

Extended Bash features not available

Failing to quote variables within test brackets

GNU command set, in cross-platform scripts

let misuse: attempting to set string variables

Multiple echo statements in a function whose output is captured

null variable assignment

Numerical and string comparison operators not equivalent

= and -eq not interchangeable

Omitting terminal semicolon, in a curly-bracketed code block

Piping

echo to a loop

echo to read (however, this problem can be circumvented)

tail -f to grep

Preserving whitespace within a variable, unintended consequences

suid commands inside a script

Undocumented Bash features, danger of

Updates to Bash breaking older scripts

Uninitialized variables

Variable names, inappropriate

Variables in a subshell, scope limited

Subshell in while-read loop

Whitespace, misuse of

Pointers

and file descriptors

and functions

and indirect references

and variables

Portability issues in shell scripting

Setting path and umask

A test suite script (Bash versus classic Bourne shell)

Using whatis

Positional parameters

$@, as separate words

$*, as a single word

in functions

POSIX, Portable Operating System Interface / UNIX

--posix option

1003.2 standard

Character classes

$PPID, process ID of parent process

Precedence, operator

Prepending lines at head of a file, script example

Prime numbers

Generating primes using the factor command

Generating primes using the modulo operator

Sieve of Eratosthenes, example script

printf, formatted print command

/proc directory

Running processes, files describing

Writing to files in /proc, warning

Process

Child process

Parent process

Process ID (PID)

Process substitution

To compare contents of directories

To supply stdin of a command

Template

while-read loop without a subshell

Programmable completion (tab expansion)

Prompt

$PS1, Main prompt, seen at command line

$PS2, Secondary prompt

Pseudo-code, as problem-solving method

$PWD, Current working directory

* * *

Quackey, a Perquackey-type anagramming game (script)

Question mark, ?

Character match in an Extended Regular Expression

Single-character wild card, in globbing

In a C-style Trinary (ternary) operator

Quoting

Character string

Variables

within test brackets

Whitespace, using quoting to preserve

* * *

Random numbers

/dev/urandom

rand(), random function in awk

$RANDOM, Bash function that returns a pseudorandom integer

Random sequence generation, using date command

Random sequence generation, using jot

Random string, generating

Raspberry Pi (single-board computer)

Script for preparing a bootable SD card

rcs

read, set value of a variable from stdin

Detecting arrow keys

Options

Piping output of cat to read

"Prepending" text

Problems piping echo to read

Redirection from a file to read

$REPLY, default read variable

Timed input

while read construct

readline library

Recursion

Demonstration of

Factorial

Fibonacci sequence

Local variables

Script calling itself recursively

Towers of Hanoi

Redirection

Code blocks

exec <filename,

to reassign file descriptors

Introductory-level explanation of I/O redirection

Open a file for both reading and writing

<>filename

read input redirected from a file

stderr to stdout

2>&1

stdin / stdout, using -

stdinof a function

stdout to a file

> ... >>

stdout to file descriptor j

>&j

file descriptori to file descriptor j

i>&j

stdout of a command to stderr

>&2

stdout and stderr of a command to a file

&>

tee, redirect to a file output of command(s) partway through a pipe

Reference Cards

Miscellaneous constructs

Parameter substitution/expansion

Special shell variables

String operations

Test operators

Binary comparison

Files

Regular Expressions

^ (caret) Beginning-of-line

$ (dollar sign) Anchor

. (dot) Match single character

* (asterisk) Any number of characters

[ ] (brackets) Enclose character set to match

\ (backslash) Escape, interpret following character literally

\< ... \> (angle brackets, escaped) Word boundary

Extended REs

+ Character match

\{ \} Escaped "curly" brackets

[: :] POSIX character classes

$REPLY, Default value associated with read command

Restricted shell, shell (or script) with certain commands disabled

return, command that terminates a function

run-parts

Running scripts in sequence, without user intervention

* * *

Scope of a variable, definition

Script options, set at command line

Scripting routines, library of useful definitions and functions

Secondary prompt, $PS2

Security issues

nmap, network mapper / port scanner

sudo

suid commands inside a script

Viruses, trojans, and worms in scripts

Writing secure scripts

sed, pattern-based programming language

Table, basic operators

Table, examples of operators

select, construct for menu building

in list omitted

Semaphore

Semicolon required, when do keyword is on first line of loop

When terminating curly-bracketed code block

seq, Emit a sequence of integers. Equivalent to jot.

set, Change value of internal script variables

set -u, Abort script with error message if attempting to use an undeclared variable.

Shell script, definition of

Shell wrapper, script embedding a command or utility

shift, reassigning positional parameters

$SHLVL, shell level, depth to which the shell (or script) is nested

shopt, change shell options

Signal, a message sent to a process

Simulations

Brownian motion

Galton board

Horserace

Life, game of

PI, approximating by firing cannonballs

Pushdown stack

Single quotes (' ... ') strong quoting

Socket, a communication node associated with an I/O port

Sorting

Bubble sort

Insertion sort

source, execute a script or, within a script, import a file

Passing positional parameters

Spam, dealing with

Example script

Example script

Example script

Example script

Special characters

Stack

Definition

Emulating a push-down stack, example script

Standard Deviation, example script

Startup files, Bash

stdin and stdout

Stopwatch, example script

Strings

=~ String match operator

Comparison

Length

${#string}

Manipulation

Manipulation, using awk

Null string, testing for

Protecting strings from expansion and/or reinterpretation, script example

Unprotecting strings, script example

strchr(), equivalent of

strlen(), equivalent of

strings command, find printable strings in a binary or data file

Substring extraction

${string:position}

${string:position:length}

Using expr

Substring index (numerical position in string)

Substring matching, using expr

Substring removal

${var#Pattern}

${var##Pattern}

${var%Pattern}

${var%%Pattern}

Substring replacement

${string/substring/replacement}

${string//substring/replacement}

${string/#substring/replacement}

${string/%substring/replacement}

Script example

Table of string/substring manipulation and extraction operators

Strong quoting ' ... '

Stylesheet for writing scripts

Subshell

Command list within parentheses

Variables, $BASH_SUBSHELL and $SHLVL

Variables in a subshell

scope limited, but ...

... can be accessed outside the subshell?

su Substitute user, log on as a different user or as root

suid (set user id) file flag

suid commands inside a script, not advisable

Symbolic links

Swapfiles

* * *

Tab completion

Table lookup, script example

tail, echo to stdout lines at the (tail) end of a text file

tar, archiving utility

tee, redirect to a file output of command(s) partway through a pipe

Terminals

setserial

setterm

stty

tput

wall

test command

Bash builtin

external command, /usr/bin/test (equivalent to /usr/bin/[)

Test constructs

Test operators

-a Logical AND compound comparison

-e File exists

-eq is-equal-to (integer comparison)

-f File is a regular file

-ge greater-than or equal (integer comparison)

-gt greater-than (integer comparison)

-le less-than or equal (integer comparison)

-lt less-than (integer comparison)

-n not-zero-length (string comparison)

-ne not-equal-to (integer comparison)

-o Logical OR compound comparison

-u suid flag set, file test

-z is-zero-length (string comparison)

= is-equal-to (string comparison)

== is-equal-to (string comparison)

< less-than (string comparison)

< less-than, (integer comparison, within double parentheses)

<= less-than-or-equal, (integer comparison, within double parentheses)

> greater-than (string comparison)

> greater-than, (integer comparison, within double parentheses)

>= greater-than-or-equal, (integer comparison, within double parentheses)

|| Logical OR

&& Logical AND

! Negation operator, inverts exit status of a test

!= not-equal-to (string comparison)

Tables of test operators

Binary comparison

File

Text and text file processing

Time / Date

Timed input

Using read -t

Using stty

Using timing loop

Using $TMOUT

Tips and hints for Bash scripts

Array, as return value from a function

Associative array more efficient than a numerically-indexed array

Capturing the return value of a function, using echo

CGI programming, using scripts for

Comment blocks

Using anonymous here documents

Using if-then constructs

Comment headers, special purpose

C-style syntax , for manipulating variables

Double-spacing a text file

Filenames prefixed with a dash, removing

Filter, feeding output back to same filter

Function return value workarounds

if-grep test fixup

Library of useful definitions and functions

null variable assignment, avoiding

Passing an array to a function

$PATH, appending to, using the += operator.

Prepending lines at head of a file

Progress bar template

Pseudo-code

rcs

Redirecting a test to /dev/null to suppress output

Running scripts in sequence without user intervention, using run-parts

Script as embedded command

Script portability

Setting path and umask

Using whatis

Setting script variable to a block of embedded sed or awk code

Speeding up script execution by disabling unicode

Subshell variable, accessing outside the subshell

Testing a variable to see if it contains only digits

Testing whether a command exists, using type

Tracking script usage

while-read loop without a subshell

Widgets, invoking from a script

$TMOUT, Timeout interval

Token, a symbol that may expand to a keyword or command

tput, terminal-control command

tr, character translation filter

DOS to Unix text file conversion

Options

Soundex, example script

Variants

Trap, specifying an action upon receipt of a signal

Trinary (ternary) operator, C-style, var>10?88:99

in double-parentheses construct

in let construct

true, returns successful (0) exit status

typeset builtin

options

* * *

$UID, User ID number

unalias, to remove an alias

uname, output system information

Unicode, encoding standard for representing letters and symbols

Disabling unicode to optimize script

Uninitialized variables

uniq, filter to remove duplicate lines from a sorted file

unset, delete a shell variable

until loop

until [ condition-is-true ]; do

* * *

Variables

Array operations on

Assignment

Script example

Script example

Script example

Bash internal variables

Block of sed or awk code, setting a variable to

C-style increment/decrement/trinary operations

Change value of internal script variables using set

declare, to modify the properties of variables

Deleting a shell variable using unset

Environmental

Expansion / Substring replacement operators

Indirect referencing

eval variable1=\$$variable2

Newer notation

${!variable}

Integer

Integer / string (variables are untyped)

Length

${#var}

Lvalue

Manipulating and expanding

Name and value of a variable, distinguishing between

Null string, testing for

Null variable assignment, avoiding

Quoting

within test brackets

to preserve whitespace

rvalue

Setting to null value

In subshell not visible to parent shell

Testing a variable if it contains only digits

Typing, restricting the properties of a variable

Undeclared, error message

Uninitialized

Unquoted variable, splitting

Unsetting

Untyped

* * *

wait, suspend script execution

To remedy script hang

Weak quoting " ... "

while loop

while [ condition ]; do

C-style syntax

Calling a function within test brackets

Multiple conditions

Omitting test brackets

while read construct

Avoiding a subshell

Whitespace, spaces, tabs, and newline characters

$IFS defaults to

Inappropriate use of

Preceding closing limit string in a here document, error

Preceding script comments

Quoting, to preserve whitespace within strings or variables

[:space:], POSIX character class

who, information about logged on users

w

whoami

logname

Widgets

Wild card characters

Asterisk *

In [list] constructs

Question mark ?

Will not match dot files

Word splitting

Definition

Resulting from command substitution

Wrapper, shell

* * *

xargs, Filter for grouping arguments

Curly brackets

Limiting arguments passed

Options

Processes arguments one at a time

Whitespace, handling

* * *

yes

Emulation

* * *

-z String is null

Zombie, a process that has terminated, but not yet been killed by its parent

Prev	Home	 
ASCII Table	 	 