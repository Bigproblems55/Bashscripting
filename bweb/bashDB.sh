create mysql database with one line in bash
Asked 10 years, 5 months ago
Active 1 year, 7 months ago
Viewed 42k times

27


10
Is it possible to create an empty database with one line of command in bash?

My newbie attempts have failed:

mysql -uroot $(create database mydatabase;)

I end up having to

mysql -uroot
create database mydatabase;
exit;
command-line
bash
mysql
database
Share
Improve this question
Follow
asked May 25 '11 at 20:29

chrisjlee
3,80044 gold badges2020 silver badges2727 bronze badges
Add a comment
2 Answers

38

@Nitrodist's answer will work, but it's over-engineering the problem. MySQL's command-line client supports the very handy -e switch, like so:

mysql -uroot -e "create database 'foo'"
You can of course substitute any valid SQL into there.

Share
Improve this answer
Follow
answered May 25 '11 at 20:45

Kromey
4,82722 gold badges2424 silver badges2727 bronze badges
5
The quotes are not required mysql -uroot -e "create database foo" – 
IanVaughan
 Mar 7 '12 at 14:55
2
Yep, using additional single quotes gave me an ERROR 1064 (42000) at line 1: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ''foo'' at line 1. Without them it works fine. Thanks @IanVaughan – 
leymannx
 Nov 17 '17 at 10:45
Add a comment

14

According to MySQL's documentation, the mysql can take commands from stdin

shell> mysql -uroot < script.sql > output.tab
You can use Process Substitution to accomplish this:

shell> mysql -uroot <(echo "create database mydatabase;") 
or you can just pipe it to the stdin of mysql normally:

shell> echo "create database mydatabase;" | mysql -uroot
Can't test this personally, but I think this should work.

Edit: Another option is to use the -e option, specified here, like so:

shell> mysql -uroot -e "create database mydatabase;"