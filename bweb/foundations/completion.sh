Advanced Bash-Scripting Guide:
Prev		Next
Appendix J. An Introduction to Programmable Completion
The programmable completion feature in Bash permits typing a partial command, then pressing the [Tab] key to auto-complete the command sequence. [1] If multiple completions are possible, then [Tab] lists them all. Let's see how it works.

bash$ xtra[Tab]
xtraceroute       xtrapin           xtrapproto
 xtraceroute.real  xtrapinfo         xtrapreset
 xtrapchar         xtrapout          xtrapstats


bash$ xtrac[Tab]
xtraceroute       xtraceroute.real


bash$ xtraceroute.r[Tab]
xtraceroute.real
      
Tab completion also works for variables and path names.

bash$ echo $BASH[Tab]
$BASH                 $BASH_COMPLETION      $BASH_SUBSHELL
 $BASH_ARGC            $BASH_COMPLETION_DIR  $BASH_VERSINFO
 $BASH_ARGV            $BASH_LINENO          $BASH_VERSION
 $BASH_COMMAND         $BASH_SOURCE


bash$ echo /usr/local/[Tab]
bin/     etc/     include/ libexec/ sbin/    src/     
 doc/     games/   lib/     man/     share/
      

The Bash complete and compgen builtins make it possible for tab completion to recognize partial parameters and options to commands. In a very simple case, we can use complete from the command-line to specify a short list of acceptable parameters.

bash$ touch sample_command
bash$ touch file1.txt file2.txt file2.doc file30.txt file4.zzz
bash$ chmod +x sample_command
bash$ complete -f -X '!*.txt' sample_command


bash$ ./sample[Tab][Tab]
sample_command
file1.txt   file2.txt   file30.txt
  
The -f option to complete specifies filenames, and -X the filter pattern.


For anything more complex, we could write a script that specifies a list of acceptable command-line parameters. The compgen builtin expands a list of arguments to generate completion matches.

Let us take a modified version of the UseGetOpt.sh script as an example command. This script accepts a number of command-line parameters, preceded by either a single or double dash. And here is the corresponding completion script, by convention given a filename corresponding to its associated command.

Example J-1. Completion script for UseGetOpt.sh

# file: UseGetOpt-2
# UseGetOpt-2.sh parameter-completion

_UseGetOpt-2 ()   #  By convention, the function name
{                 #+ starts with an underscore.
  local cur
  # Pointer to current completion word.
  # By convention, it's named "cur" but this isn't strictly necessary.

  COMPREPLY=()   # Array variable storing the possible completions.
  cur=${COMP_WORDS[COMP_CWORD]}

  case "$cur" in
    -*)
    COMPREPLY=( $( compgen -W '-a -d -f -l -t -h --aoption --debug \
                               --file --log --test --help --' -- $cur ) );;
#   Generate the completion matches and load them into $COMPREPLY array.
#   xx) May add more cases here.
#   yy)
#   zz)
  esac

  return 0
}

complete -F _UseGetOpt-2 -o filenames ./UseGetOpt-2.sh
#        ^^ ^^^^^^^^^^^^  Invokes the function _UseGetOpt-2.
Now, let's try it.

bash$ source UseGetOpt-2

bash$ ./UseGetOpt-2.sh -[Tab]
--         --aoption  --debug    --file     --help     --log     --test
 -a         -d         -f         -h         -l         -t


bash$ ./UseGetOpt-2.sh --[Tab]
--         --aoption  --debug    --file     --help     --log     --test
  
We begin by sourcing the "completion script." This sets the command-line parameters. [2]

In the first instance, hitting [Tab] after a single dash, the output is all the possible parameters preceded by one or more dashes. Hitting [Tab] after two dashes gives the possible parameters preceded by two or more dashes.

Now, just what is the point of having to jump through flaming hoops to enable command-line tab completion? It saves keystrokes. [3]

--

Resources:

Bash programmable completion project

Mitch Frazier's Linux Journal article, More on Using the Bash Complete Command

Steve's excellent two-part article, "An Introduction to Bash Completion": Part 1 and Part 2

Notes
[1]	
This works only from the command line, of course, and not within a script.

[2]	
Normally the default parameter completion files reside in either the /etc/profile.d directory or in /etc/bash_completion. These autoload on system startup. So, after writing a useful completion script, you might wish to move it (as root, of course) to one of these directories.

[3]	
It has been extensively documented that programmers are willing to put in long hours of effort in order to save ten minutes of "unnecessary" labor. This is known as optimization.

Prev	Home	Next
Important System Directories	 	Localization