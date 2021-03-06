Advanced Bash-Scripting Guide:
Prev	Chapter 36. Miscellany	Next
36.9. Portability Issues
 	
It is easier to port a shell than a shell script.

--Larry Wall

This book deals specifically with Bash scripting on a GNU/Linux system. All the same, users of sh and ksh will find much of value here.

As it happens, many of the various shells and scripting languages seem to be converging toward the POSIX 1003.2 standard. Invoking Bash with the --posix option or inserting a set -o posix at the head of a script causes Bash to conform very closely to this standard. Another alternative is to use a #!/bin/sh sha-bang header in the script, rather than #!/bin/bash. [1] Note that /bin/sh is a link to /bin/bash in Linux and certain other flavors of UNIX, and a script invoked this way disables extended Bash functionality.

Most Bash scripts will run as-is under ksh, and vice-versa, since Chet Ramey has been busily porting ksh features to the latest versions of Bash.

On a commercial UNIX machine, scripts using GNU-specific features of standard commands may not work. This has become less of a problem in the last few years, as the GNU utilities have pretty much displaced their proprietary counterparts even on "big-iron" UNIX. Caldera's release of the source to many of the original UNIX utilities has accelerated the trend.


Bash has certain features that the traditional Bourne shell lacks. Among these are:

Certain extended invocation options

Command substitution using $( ) notation

Brace expansion

Certain array operations, and associative arrays

The double brackets extended test construct

The double-parentheses arithmetic-evaluation construct

Certain string manipulation operations

Process substitution

A Regular Expression matching operator

Bash-specific builtins

Coprocesses

See the Bash F.A.Q. for a complete listing.

36.9.1. A Test Suite
Let us illustrate some of the incompatibilities between Bash and the classic Bourne shell. Download and install the "Heirloom Bourne Shell" and run the following script, first using Bash, then the classic sh.

Example 36-23. Test Suite

#!/bin/bash
# test-suite.sh
# A partial Bash compatibility test suite.
# Run this on your version of Bash, or some other shell.

default_option=FAIL         # Tests below will fail unless . . .

echo
echo -n "Testing "
sleep 1; echo -n ". "
sleep 1; echo -n ". "
sleep 1; echo ". "
echo

# Double brackets
String="Double brackets supported?"
echo -n "Double brackets test: "
if [[ "$String" = "Double brackets supported?" ]]
then
  echo "PASS"
else
  echo "FAIL"
fi


# Double brackets and regex matching
String="Regex matching supported?"
echo -n "Regex matching: "
if [[ "$String" =~ R.....matching* ]]
then
  echo "PASS"
else
  echo "FAIL"
fi


# Arrays
test_arr=$default_option     # FAIL
Array=( If supports arrays will print PASS )
test_arr=${Array[5]}
echo "Array test: $test_arr"


# Command Substitution
csub_test ()
{
  echo "PASS"
}

test_csub=$default_option    # FAIL
test_csub=$(csub_test)
echo "Command substitution test: $test_csub"

echo

#  Completing this script is an exercise for the reader.
#  Add to the above similar tests for double parentheses,
#+ brace expansion, process substitution, etc.

exit $?
Notes
[1]	
Or, better yet, #!/bin/env sh.

Prev	Home	Next
Security Issues	Up	Shell Scripting Under Windows