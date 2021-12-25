Advanced Bash-Scripting Guide:
Prev		Next
Chapter 23. Process Substitution
Piping the stdout of a command into the stdin of another is a powerful technique. But, what if you need to pipe the stdout of multiple commands? This is where process substitution comes in.

Process substitution feeds the output of a process (or processes) into the stdin of another process.

Template

Command list enclosed within parentheses
>(command_list)

<(command_list)

Process substitution uses /dev/fd/<n> files to send the results of the process(es) within parentheses to another process. [1]

Caution	
There is no space between the the "<" or ">" and the parentheses. Space there would give an error message.

bash$ echo >(true)
/dev/fd/63

bash$ echo <(true)
/dev/fd/63

bash$ echo >(true) <(true)
/dev/fd/63 /dev/fd/62



bash$ wc <(cat /usr/share/dict/linux.words)
 483523  483523 4992010 /dev/fd/63

bash$ grep script /usr/share/dict/linux.words | wc
    262     262    3601

bash$ wc <(grep script /usr/share/dict/linux.words)
    262     262    3601 /dev/fd/63
	      
Note	
Bash creates a pipe with two file descriptors, --fIn and fOut--. The stdin of true connects to fOut (dup2(fOut, 0)), then Bash passes a /dev/fd/fIn argument to echo. On systems lacking /dev/fd/<n> files, Bash may use temporary files. (Thanks, S.C.)

Process substitution can compare the output of two different commands, or even the output of different options to the same command.

bash$ comm <(ls -l) <(ls -al)
total 12
-rw-rw-r--    1 bozo bozo       78 Mar 10 12:58 File0
-rw-rw-r--    1 bozo bozo       42 Mar 10 12:58 File2
-rw-rw-r--    1 bozo bozo      103 Mar 10 12:58 t2.sh
        total 20
        drwxrwxrwx    2 bozo bozo     4096 Mar 10 18:10 .
        drwx------   72 bozo bozo     4096 Mar 10 17:58 ..
        -rw-rw-r--    1 bozo bozo       78 Mar 10 12:58 File0
        -rw-rw-r--    1 bozo bozo       42 Mar 10 12:58 File2
        -rw-rw-r--    1 bozo bozo      103 Mar 10 12:58 t2.sh

Process substitution can compare the contents of two directories -- to see which filenames are in one, but not the other.

diff <(ls $first_directory) <(ls $second_directory)
Some other usages and uses of process substitution:


read -a list < <( od -Ad -w24 -t u2 /dev/urandom )
#  Read a list of random numbers from /dev/urandom,
#+ process with "od"
#+ and feed into stdin of "read" . . .

#  From "insertion-sort.bash" example script.
#  Courtesy of JuanJo Ciarlante.


PORT=6881   # bittorrent

# Scan the port to make sure nothing nefarious is going on.
netcat -l $PORT | tee>(md5sum ->mydata-orig.md5) |
gzip | tee>(md5sum - | sed 's/-$/mydata.lz2/'>mydata-gz.md5)>mydata.gz

# Check the decompression:
  gzip -d<mydata.gz | md5sum -c mydata-orig.md5)
# The MD5sum of the original checks stdin and detects compression issues.

#  Bill Davidsen contributed this example
#+ (with light edits by the ABS Guide author).

cat <(ls -l)
# Same as     ls -l | cat

sort -k 9 <(ls -l /bin) <(ls -l /usr/bin) <(ls -l /usr/X11R6/bin)
# Lists all the files in the 3 main 'bin' directories, and sorts by filename.
# Note that three (count 'em) distinct commands are fed to 'sort'.

 
diff <(command1) <(command2)    # Gives difference in command output.

tar cf >(bzip2 -c > file.tar.bz2) $directory_name
# Calls "tar cf /dev/fd/?? $directory_name", and "bzip2 -c > file.tar.bz2".
#
# Because of the /dev/fd/<n> system feature,
# the pipe between both commands does not need to be named.
#
# This can be emulated.
#
bzip2 -c < pipe > file.tar.bz2&
tar cf pipe $directory_name
rm pipe
#        or
exec 3>&1
tar cf /dev/fd/4 $directory_name 4>&1 >&3 3>&- | bzip2 -c > file.tar.bz2 3>&-
exec 3>&-


# Thanks, Stéphane Chazelas

Here is a method of circumventing the problem of an echo piped to a while-read loop running in a subshell.

Example 23-1. Code block redirection without forking

#!/bin/bash
# wr-ps.bash: while-read loop with process substitution.

# This example contributed by Tomas Pospisek.
# (Heavily edited by the ABS Guide author.)

echo

echo "random input" | while read i
do
  global=3D": Not available outside the loop."
  # ... because it runs in a subshell.
done

echo "\$global (from outside the subprocess) = $global"
# $global (from outside the subprocess) =

echo; echo "--"; echo

while read i
do
  echo $i
  global=3D": Available outside the loop."
  # ... because it does NOT run in a subshell.
done < <( echo "random input" )
#    ^ ^

echo "\$global (using process substitution) = $global"
# Random input
# $global (using process substitution) = 3D: Available outside the loop.


echo; echo "##########"; echo



# And likewise . . .

declare -a inloop
index=0
cat $0 | while read line
do
  inloop[$index]="$line"
  ((index++))
  # It runs in a subshell, so ...
done
echo "OUTPUT = "
echo ${inloop[*]}           # ... nothing echoes.


echo; echo "--"; echo


declare -a outloop
index=0
while read line
do
  outloop[$index]="$line"
  ((index++))
  # It does NOT run in a subshell, so ...
done < <( cat $0 )
echo "OUTPUT = "
echo ${outloop[*]}          # ... the entire script echoes.

exit $?
This is a similar example.

Example 23-2. Redirecting the output of process substitution into a loop.

#!/bin/bash
# psub.bash

# As inspired by Diego Molina (thanks!).

declare -a array0
while read
do
  array0[${#array0[@]}]="$REPLY"
done < <( sed -e 's/bash/CRASH-BANG!/' $0 | grep bin | awk '{print $1}' )
#  Sets the default 'read' variable, $REPLY, by process substitution,
#+ then copies it into an array.

echo "${array0[@]}"

exit $?

# ====================================== #

bash psub.bash

#!/bin/CRASH-BANG! done #!/bin/CRASH-BANG!
A reader sent in the following interesting example of process substitution.

# Script fragment taken from SuSE distribution:

# --------------------------------------------------------------#
while read  des what mask iface; do
# Some commands ...
done < <(route -n)  
#    ^ ^  First < is redirection, second is process substitution.

# To test it, let's make it do something.
while read  des what mask iface; do
  echo $des $what $mask $iface
done < <(route -n)  

# Output:
# Kernel IP routing table
# Destination Gateway Genmask Flags Metric Ref Use Iface
# 127.0.0.0 0.0.0.0 255.0.0.0 U 0 0 0 lo
# --------------------------------------------------------------#

#  As Stéphane Chazelas points out,
#+ an easier-to-understand equivalent is:
route -n |
  while read des what mask iface; do   # Variables set from output of pipe.
    echo $des $what $mask $iface
  done  #  This yields the same output as above.
        #  However, as Ulrich Gayer points out . . .
        #+ this simplified equivalent uses a subshell for the while loop,
        #+ and therefore the variables disappear when the pipe terminates.
	
# --------------------------------------------------------------#
	
#  However, Filip Moritz comments that there is a subtle difference
#+ between the above two examples, as the following shows.

(
route -n | while read x; do ((y++)); done
echo $y # $y is still unset

while read x; do ((y++)); done < <(route -n)
echo $y # $y has the number of lines of output of route -n
)

More generally spoken
(
: | x=x
# seems to start a subshell like
: | ( x=x )
# while
x=x < <(:)
# does not
)

# This is useful, when parsing csv and the like.
# That is, in effect, what the original SuSE code fragment does.

Notes
[1]	
This has the same effect as a named pipe (temp file), and, in fact, named pipes were at one time used in process substitution.

Prev	Home	Next
Restricted Shells	Up	Functions