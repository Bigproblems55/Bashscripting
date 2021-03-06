Advanced Bash-Scripting Guide:
Prev	Chapter 8. Operations and Related Topics	Next
8.4. Operator Precedence

In a script, operations execute in order of precedence: the higher precedence operations execute before the lower precedence ones. [1]

Table 8-1. Operator Precedence

Operator	Meaning	Comments
 	HIGHEST PRECEDENCE
var++ var--	post-increment, post-decrement	C-style operators
++var --var	pre-increment, pre-decrement	 
 	 	 
! ~	negation	logical / bitwise, inverts sense of following operator
 	 	 
**	exponentiation	arithmetic operation
* / %	multiplication, division, modulo	arithmetic operation
+ -	addition, subtraction	arithmetic operation
 	 	 
<< >>	left, right shift	bitwise
 	 	 
-z -n	unary comparison	string is/is-not null
-e -f -t -x, etc.	unary comparison	file-test
< -lt > -gt <= -le >= -ge	compound comparison	string and integer
-nt -ot -ef	compound comparison	file-test
== -eq != -ne	equality / inequality	test operators, string and integer
 	 	 
&	AND	bitwise
^	XOR	exclusive OR, bitwise
|	OR	bitwise
 	 	 
&& -a	AND	logical, compound comparison
|| -o	OR	logical, compound comparison
 	 	 
?:	trinary operator	C-style
=	assignment	(do not confuse with equality test)
*= /= %= += -= <<= >>= &=	combination assignment	times-equal, divide-equal, mod-equal, etc.
 	 	 
,	comma	links a sequence of operations
 	LOWEST PRECEDENCE
In practice, all you really need to remember is the following:

The "My Dear Aunt Sally" mantra (multiply, divide, add, subtract) for the familiar arithmetic operations.

The compound logical operators, &&, ||, -a, and -o have low precedence.

The order of evaluation of equal-precedence operators is usually left-to-right.

Now, let's utilize our knowledge of operator precedence to analyze a couple of lines from the /etc/init.d/functions file, as found in the Fedora Core Linux distro.

while [ -n "$remaining" -a "$retry" -gt 0 ]; do

# This looks rather daunting at first glance.


# Separate the conditions:
while [ -n "$remaining" -a "$retry" -gt 0 ]; do
#       --condition 1-- ^^ --condition 2-

#  If variable "$remaining" is not zero length
#+      AND (-a)
#+ variable "$retry" is greater-than zero
#+ then
#+ the [ expresion-within-condition-brackets ] returns success (0)
#+ and the while-loop executes an iteration.
#  ==============================================================
#  Evaluate "condition 1" and "condition 2" ***before***
#+ ANDing them. Why? Because the AND (-a) has a lower precedence
#+ than the -n and -gt operators,
#+ and therefore gets evaluated *last*.

#################################################################

if [ -f /etc/sysconfig/i18n -a -z "${NOLOCALE:-}" ] ; then


# Again, separate the conditions:
if [ -f /etc/sysconfig/i18n -a -z "${NOLOCALE:-}" ] ; then
#    --condition 1--------- ^^ --condition 2-----

#  If file "/etc/sysconfig/i18n" exists
#+      AND (-a)
#+ variable $NOLOCALE is zero length
#+ then
#+ the [ test-expresion-within-condition-brackets ] returns success (0)
#+ and the commands following execute.
#
#  As before, the AND (-a) gets evaluated *last*
#+ because it has the lowest precedence of the operators within
#+ the test brackets.
#  ==============================================================
#  Note:
#  ${NOLOCALE:-} is a parameter expansion that seems redundant.
#  But, if $NOLOCALE has not been declared, it gets set to *null*,
#+ in effect declaring it.
#  This makes a difference in some contexts.

Tip	
To avoid confusion or error in a complex sequence of test operators, break up the sequence into bracketed sections.
if [ "$v1" -gt "$v2"  -o  "$v1" -lt "$v2"  -a  -e "$filename" ]
# Unclear what's going on here...

if [[ "$v1" -gt "$v2" ]] || [[ "$v1" -lt "$v2" ]] && [[ -e "$filename" ]]
# Much better -- the condition tests are grouped in logical sections.
Notes
[1]	
Precedence, in this context, has approximately the same meaning as priority

Prev	Home	Next
The Double-Parentheses Construct	Up	Beyond the Basics