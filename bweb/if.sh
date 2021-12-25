Advanced Bash-Scripting Guide:
Prev	Chapter 7. Tests	Next
7.4. Nested if/then Condition Tests
Condition tests using the if/then construct may be nested. The net result is equivalent to using the && compound comparison operator.

a=3

if [ "$a" -gt 0 ]
then
  if [ "$a" -lt 5 ]
  then
    echo "The value of \"a\" lies somewhere between 0 and 5."
  fi
fi

# Same result as:

if [ "$a" -gt 0 ] && [ "$a" -lt 5 ]
then
  echo "The value of \"a\" lies somewhere between 0 and 5."
fi

Example 37-4 and Example 17-11 demonstrate nested if/then condition tests.

Prev	Home	Next
Other Comparison Operators	Up	Testing Your Knowledge of Tests