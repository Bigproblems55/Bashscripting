Advanced Bash-Scripting Guide:
Prev		Next
Appendix L. History Commands
The Bash shell provides command-line tools for editing and manipulating a user's command history. This is primarily a convenience, a means of saving keystrokes.

Bash history commands:

history

fc

bash$ history
   1  mount /mnt/cdrom
    2  cd /mnt/cdrom
    3  ls
     ...
	      
Internal variables associated with Bash history commands:

$HISTCMD

$HISTCONTROL

$HISTIGNORE

$HISTFILE

$HISTFILESIZE

$HISTSIZE

$HISTTIMEFORMAT (Bash, ver. 3.0 or later)

!!

!$

!#

!N

!-N

!STRING

!?STRING?

^STRING^string^

Unfortunately, the Bash history tools find no use in scripting.

#!/bin/bash
# history.sh
# A (vain) attempt to use the 'history' command in a script.

history                      # No output.

var=$(history); echo "$var"  # $var is empty.

#  History commands are, by default, disabled within a script.
#  However, as dhw points out,
#+ set -o history
#+ enables the history mechanism.

set -o history
var=$(history); echo "$var"   # 1  var=$(history)
bash$ ./history.sh
(no output)	      
	      
The Advancing in the Bash Shell site gives a good introduction to the use of history commands in Bash.

Prev	Home	Next
Localization	 	Sample .bashrc and .bash_profile Files