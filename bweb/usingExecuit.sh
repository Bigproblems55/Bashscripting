reason for exec in wrapper scripts
Asked 5 years, 6 months ago
Active 1 year, 11 months ago
Viewed 8k times

36


5
I have seen wrapper script examples which in a nutshell are following:

#!/bin/bash

myprog=sleep
echo "This is the wrapper script, it will exec "$myprog""

exec "$myprog" "$@"
As seen above, they use exec to replace the newly created shell almost immediately with the $myprog. One could achieve the same without exec:

#!/bin/bash

myprog=sleep
echo "This is the wrapper script, it will exec "$myprog""

"$myprog" "$@"
In this last example, a new bash instance is started and then $myprog is started as a child process of the bash instance.

What are the benefits of the first approach?

bash
shell-script
shell
scripting
exec
Share
Improve this question
Follow
edited Dec 2 '19 at 8:07

Marc.2377
77011 gold badge1111 silver badges3434 bronze badges
asked Apr 25 '16 at 22:29

Martin
5,9063535 gold badges109109 silver badges185185 bronze badges
See for example stackoverflow.com/questions/18351198/… – 
Thomas Dickey
 Apr 25 '16 at 22:35
Also (on this site!): Use case / practical example for the shell's exec builtin. – 
Scott
 Apr 26 '16 at 5:19
Add a comment
2 Answers

39

Using exec makes the wrapper more transparent, i.e. it makes it less likely that the user or application that calls the script needs to be aware that it's a relay that in turns launches the “real” program.

In particular, if the caller wants to kill the program, they'll just kill the process they just launched. If the wrapper script runs a child process, the caller would need to know that they should find out the child of the wrapper and kill that instead. The wrapper script could set a trap to relay some signals, but that wouldn't work with SIGSTOP or SIGKILL which can't be caught.

Calling exec also saves a bit of memory (and other resources such as PIDs etc.) since it there's no need to keep an extra shell around with nothing left to do.

If there are multiple wrappers, the problems add up (difficulty in finding the right process to kill, memory overhead, etc.).

Some shells (e.g. the Korn shell) automatically detect when a command is the last one and there's no active trap and put an implicit exec, but not all do (e.g. not bash).

Share
Improve this answer
Follow
answered Apr 25 '16 at 23:13

Gilles 'SO- stop being evil'
720k171171 gold badges15021502 silver badges19951995 bronze badges
Add a comment
Report this ad

11

Finding no duplicates... refer to the FreeBSD handbook, which gives a good enough reason:

The exec statement replaces the shell process with the specified program. If exec is omitted, the shell process remains in memory while the program is executing, and needlessly consumes system resources.

which is essentially the reason explained to me quite a while back (by one of the porters), and is fairly well-known.