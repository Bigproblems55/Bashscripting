Advanced Bash-Scripting Guide:
Prev	Appendix G. Command-Line Options	Next
G.1. Standard Command-Line Options
Over time, there has evolved a loose standard for the meanings of command-line option flags. The GNU utilities conform more closely to this "standard" than older UNIX utilities.

Traditionally, UNIX command-line options consist of a dash, followed by one or more lowercase letters. The GNU utilities added a double-dash, followed by a complete word or compound word.

The two most widely-accepted options are:

-h

--help

Help: Give usage message and exit.

-v

--version

Version: Show program version and exit.

Other common options are:

-a

--all

All: show all information or operate on all arguments.

-l

--list

List: list files or arguments without taking other action.

-o

Output filename

-q

--quiet

Quiet: suppress stdout.

-r

-R

--recursive

Recursive: Operate recursively (down directory tree).

-v

--verbose

Verbose: output additional information to stdout or stderr.

-z

--compress

Compress: apply compression (usually gzip).

However:

In tar and gawk:

-f

--file

File: filename follows.

In cp, mv, rm:

-f

--force

Force: force overwrite of target file(s).

Caution	
Many UNIX and Linux utilities deviate from this "standard," so it is dangerous to assume that a given option will behave in a standard way. Always check the man page for the command in question when in doubt.

A complete table of recommended options for the GNU utilities is available at the GNU standards page.

Prev	Home	Next
Command-Line Options	Up	Bash Command-Line Options



Advanced Bash-Scripting Guide:
Prev	Appendix G. Command-Line Options	Next
G.2. Bash Command-Line Options

Bash itself has a number of command-line options. Here are some of the more useful ones.

-c

Read commands from the following string and assign any arguments to the positional parameters.

bash$ bash -c 'set a b c d; IFS="+-;"; echo "$*"'
a+b+c+d
	      
-r

--restricted

Runs the shell, or a script, in restricted mode.

--posix

Forces Bash to conform to POSIX mode.

--version

Display Bash version information and exit.

--

End of options. Anything further on the command line is an argument, not an option.

Prev	Home	Next
Standard Command-Line Options	Up	Important Files