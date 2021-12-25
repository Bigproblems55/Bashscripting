Advanced Bash-Scripting Guide:
Prev	Chapter 16. External Filters, Programs and Commands	Next
16.7. Terminal Control Commands
Command affecting the console or terminal

tput
Initialize terminal and/or fetch information about it from terminfo data. Various options permit certain terminal operations: tput clear is the equivalent of clear; tput reset is the equivalent of reset.

bash$ tput longname
xterm terminal emulator (X Window System)
	      
Issuing a tput cup X Y moves the cursor to the (X,Y) coordinates in the current terminal. A clear to erase the terminal screen would normally precede this.

Some interesting options to tput are:

bold, for high-intensity text

smul, to underline text in the terminal

smso, to render text in reverse

sgr0, to reset the terminal parameters (to normal), without clearing the screen

Example scripts using tput:

Example 36-15

Example 36-13

Example A-44

Example A-42

Example 27-2

Note that stty offers a more powerful command set for controlling a terminal.

infocmp
This command prints out extensive information about the current terminal. It references the terminfo database.

bash$ infocmp
#       Reconstructed via infocmp from file:
 /usr/share/terminfo/r/rxvt
 rxvt|rxvt terminal emulator (X Window System), 
         am, bce, eo, km, mir, msgr, xenl, xon, 
         colors#8, cols#80, it#8, lines#24, pairs#64, 
         acsc=``aaffggjjkkllmmnnooppqqrrssttuuvvwwxxyyzz{{||}}~~, 
         bel=^G, blink=\E[5m, bold=\E[1m,
         civis=\E[?25l, 
         clear=\E[H\E[2J, cnorm=\E[?25h, cr=^M, 
         ...
	      
reset
Reset terminal parameters and clear text screen. As with clear, the cursor and prompt reappear in the upper lefthand corner of the terminal.

clear
The clear command simply clears the text screen at the console or in an xterm. The prompt and cursor reappear at the upper lefthand corner of the screen or xterm window. This command may be used either at the command line or in a script. See Example 11-26.

resize
Echoes commands necessary to set $TERM and $TERMCAP to duplicate the size (dimensions) of the current terminal.

bash$ resize
set noglob;
 setenv COLUMNS '80';
 setenv LINES '24';
 unset noglob;
	        
script
This utility records (saves to a file) all the user keystrokes at the command-line in a console or an xterm window. This, in effect, creates a record of a session.

Prev	Home	Next
Communications Commands	Up	Math Commands