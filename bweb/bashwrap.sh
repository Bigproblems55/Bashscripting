🐧 nixCraft → Linux → Shell Script Wrapper Examples: Enhance the Ping and Host Commands


Shell Script Wrapper Examples: Enhance the Ping and Host Commands
Author: Vivek Gite Last updated: May 16, 2017 14 comments


SShell script wrappers can make the *nix command more transparent to the user. The most common shell scripts are simple wrappers around the third party or system binaries. A wrapper is nothing but a shell script or a shell function or an alias that includes a system command or utility.


Linux and a Unix-like operating system can run both 32bit and 64bit specific versions of applications. You can write a wrapper script that can select and execute correct version on a 32bit or 64bit hardware platform. In clustered environment and High-Performance computing environment you may find 100s of wrapper scripts written in Perl, Shell, and Python to get cluster usage, setting up shared storage, submitting and managing jobs, backups, troubleshooting, invokes commands with specified arguments, redirecting stdout/stderr and much more.



In this post, I will explain how to create a shell wrapper to enhance the primary troubleshooting tool such as ping and host.

Why use shell script wrappers
Time saving.
Customize collection of *nix commands.
Passing default arguments to binaries or 3rd party apps.
Call to start the desired job.
Wrappers are perfect when tools or command that require customized environmental variable settings, system controls or job-submission parameter.
Useful in HPC, clustered environment, *nix sysadmin, and scientific research.
Example: Creating a shell script wrapper
The following shell script will start java app called kvminit by setting up system environment and redirect logs to a log file:

#!/bin/sh
# Wrapper for our kvm app called kvminit
export JAVA_HOME=${JAVA_HOME:-/usr/java}
export CLASSPATH="/home/vivek/apps/java/class
exec ${JAVA_HOME}/bin/java kvminit "$@" &>/var/log/kvm/logfile
Another wrapper script that can start / stop / nfs server or client in a single pass:

#!/bin/bash
# A shell script to start / stop / restart nfsv4 services
_me=${0##*/}              #Who am I? Server or client?
_server="/etc/init.d/rpcbind /etc/init.d/rpcidmapd /etc/init.d/nfslock /etc/init.d/nfs" # list of server init scripts
_client="/etc/init.d/rpcbind /etc/init.d/rpcidmapd /etc/init.d/nfslock" # list of client init scripts
_action="$1"            # start / stop / restart
 
# run all scripts with one action such as stop or start or restart
runme(){
	local i="$1"
	local a="$2"
	for t in $i
	do
		$t $a
	done
}
 
usage(){
	echo "$_me start|stop|restart|reload|status";
	exit 0
}
 
[ $# -eq 0 ] && usage
 
# main logic - take action
case $_me in
	nfs.server) runme "$_server" "$_action" ;;
	nfs.client) runme "$_client" "$_action" ;;
	*) usage
esac
Tools for troubleshooting: ping and host commands
As a sysadmin, I use basic troubleshooting tools such as ping and host frequently.

The ping commands help determine connectivity between devices on my network or remote network.
The host command help determine DNS problems. I can get information about Domain Name System records for specific IP addresses and/or host names so that I can troubleshoot DNS problems.
My problem with ping and host command
Both commands will not work when you pass protocol names or username:password from bash history:
curl -I http://www.cyberciti.biz/
ping !!:2

Sample outputs:

ping http://www.cyberciti.biz/
ping: unknown host http://www.cyberciti.biz/
OR
curl -I http://www.cyberciti.biz/
host !!:2

Sample outputs:

host http://www.cyberciti.biz/
Host http://www.cyberciti.biz/ not found: 3(NXDOMAIN)
So I decided to write a bash shell function ping() and host() that can use any one of the following format of domain and pass it to ping and host commands:

http://www.cyberciti.biz/
http://www.cyberciti.biz/file/one.html
scp://www.cyberciti.biz/foo
ftp://backup.cyberciti.biz/path
https://user:password@cp.cyberciti.biz/
_getdomainnameonly()
# Name: _getdomainnameonly
# Arg: Url/domain/ip
# Returns: Only domain name
# Purpose: Get domain name and remove protocol part, username:password and other parts from url
_getdomainnameonly(){
        # get url
	local h="$1"
        # upper to lowercase
	local f="${h,,}"
	# remove protocol part of hostname
        f="${f#http://}"
        f="${f#https://}"
	f="${f#ftp://}"
	f="${f#scp://}"
	f="${f#scp://}"
	f="${f#sftp://}"
	# Remove username and/or username:password part of hostname
	f="${f#*:*@}"
	f="${f#*@}"
	# remove all /foo/xyz.html*
	f=${f%%/*}
	# show domain name only
	echo "$f"
}
The $ character is used for parameter expansion, and command substitution. See how to use bash parameter substitution for more information.

ping() wrapper
# Name: ping() wrapper
# Arg: url/domain/ip
# Purpose: Send ping request to domain by removing urls, protocol, username:pass using system /bin/ping
ping(){
	local t="$1"
	local _ping="/bin/ping"
	local c=$(_getdomainnameonly "$t")
	[ "$t" != "$c" ] && echo "Sending ICMP ECHO_REQUEST to \"$c\"..."
	$_ping $c
}
Both ping() and host() [see below] are bash functions to performs a specific task.


Patreon supporters only guides 🤓
No ads and tracking
In-depth guides for developers and sysadmins at Opensourceflare✨
Join my Patreon to support independent content creators and start reading latest guides:
How to set up Redis sentinel cluster on Ubuntu or Debian Linux
How To Set Up SSH Keys With YubiKey as two-factor authentication (U2F/FIDO2)
How to set up Mariadb Galera cluster on Ubuntu or Debian Linux
A podman tutorial for beginners – part I (run Linux containers without Docker and in daemonless mode)
How to protect Linux against rogue USB devices using USBGuard
If your domain is not sending email, set these DNS settings to avoid spoofing and phishing
Join Patreon ➔
host() wrapper
# Name: host() wrapper
# Arg: Domain/Url/IP
# Purpose: Dns lookups system /usr/bin/host
host(){
	local t="$1"
	local _host="/usr/bin/host"
	local c=$(_getdomainnameonly "$t")
	[ "$t" != "$c" ] && echo "Performing DNS lookups for \"$c\"..."
	$_host $c
}
Putting it all together
Create a shell script called $HOME/scripts/wrapper_functions.lib and put all above three functions as follows:

#!/bin/bash
## Note: Only works with bash 3.x or 4.x+ ##
_getdomainnameonly(){
	local h="$1"
	local f="${h,,}"
	# remove protocol part of hostname
        f="${f#http://}"
        f="${f#https://}"
	f="${f#ftp://}"
	f="${f#scp://}"
	f="${f#scp://}"
	f="${f#sftp://}"
	# remove username and/or username:password part of hostname
	f="${f#*:*@}"
	f="${f#*@}"
	# remove all /foo/xyz.html*
	f=${f%%/*}
	# show domain name only
	echo "$f"
}
 
ping(){
	local t="$1"
	local _ping="/bin/ping"
	local c=$(_getdomainnameonly "$t")
	[ "$t" != "$c" ] && echo "Sending ICMP ECHO_REQUEST to \"$c\"..."
	$_ping $c
}
 
host(){
	local t="$1"
	local _host="/usr/bin/host"
	local c=$(_getdomainnameonly "$t")
	[ "$t" != "$c" ] && echo "Performing DNS lookups for \"$c\"..."
	$_host $c
}
Edit your $HOME/.bashrc and append the following line:

source $HOME/scripts/wrapper_functions.lib
Save and close the file. You can load wrappers instantly by typing the following command:
$ source $HOME/scripts/wrapper_functions.lib

Test it as follows:

# First, just see header
curl -I http://cyberciti.biz/
 
## Now call it from history i.e. call 2nd arg passed to the curl ##
host !!:2
 
## Again call it from history i.e. call 1sat arg passed to the host ##
ping !!:1
 
## Other usage ##
host http://username:password@cyberciti.biz/
ping ftp://cyberciti.biz/foo
Sample outputs:

Bash wrappers example
Fig.01: Bash wrapper in action

How do I use real ping and host command
Simply use the following syntax:
/bin/ping -c4 cyberciti.biz

OR
/usr/bin/host cyberciti.biz ns1.example.com

How do I pass command line arguments via bash shell script wrapper?
Following modified bash code passes the command line arg to real system /bin/ping and /usr/bin/host:

#!/bin/bash
# Note: Works with bash 4.x and above only #
_getdomainnameonly(){
	local h="$1"
	local f="${h,,}"
	# remove protocol part of hostname
        f="${f#http://}"
        f="${f#https://}"
	f="${f#ftp://}"
	f="${f#scp://}"
	f="${f#scp://}"
	f="${f#sftp://}"
	# remove username and/or username:password part of hostname
	f="${f#*:*@}"
	f="${f#*@}"
	# remove all /foo/xyz.html*
	f=${f%%/*}
	# show domain name only
	echo "$f"
}
 
 
ping(){
	local array=( $@ )  		# get all args in an array
	local len=${#array[@]}          # find the length of an array
	local host=${array[$len-1]}     # get the last arg
	local args=${array[@]:0:$len-1} # get all args before the last arg in $@ in an array
	local _ping="/bin/ping"
	local c=$(_getdomainnameonly "$host")
	[ "$t" != "$c" ] && echo "Sending ICMP ECHO_REQUEST to \"$c\"..."
	# pass args and host
	$_ping $args $c
}
 
host(){
	local array=( $@ )
	local len=${#array[@]}
	local host=${array[$len-1]}
	local args=${array[@]:0:$len-1}
	local _host="/usr/bin/host"
	local c=$(_getdomainnameonly "$host")
	[ "$t" != "$c" ] && echo "Performing DNS lookups for \"$c\"..."
  	$_host $args $c
}
Run it as follows:

curl -I http://cyberciti.biz/
ping -v -c 2 !!:2
host -t aaaa !!:4
host -t mx !!:3
host -t a ftp://nixcraft.com/
host -a ftp://nixcraft.com/
ping 8.8.8.8
host 8.8.8.8
Sample outputs:

Bash wrapper with command line args
Fig.02: Bash wrapper with command line args in action

See how to find the last argument passed to a shell script and extract all command line arguments before last parameter in $@ for more information.
Conclusion
In this example, I wrote a small script and functions, that do a minimal operation, and then calling then in another script or directly to achieve my result. This is the basis of Unix and Linux. You need to reuse code and existing binaries to create desired functionality. Have a favorite wrapper script? Let’s hear about it in the comments.


🐧 Get the latest tutorials on Linux, Open Source & DevOps via
RSS feed ➔    Weekly email newsletter ➔


🔎 To search, type & hit enter...

Related Posts

Simple Linux and UNIX Shell Script Based System…
Simple Linux and UNIX Shell Script Based System…

Running Commands on a Remote Linux / UNIX Host
Running Commands on a Remote Linux / UNIX Host

Linux Iptables allow or block ICMP ping request
Linux Iptables allow or block ICMP ping request

Bash shell script tip: Run commands from a variable
Bash shell script tip: Run commands from a variable

Bash Shell Completing File, User and Host Names…
Bash Shell Completing File, User and Host Names…

No Route to Host error and solution
No Route to Host error and solution

Setup VMWARE Host as router for Solaris, Linux,…
Setup VMWARE Host as router for Solaris, Linux,…

Shell scripting: Reading a root password with…
Shell scripting: Reading a root password with…
Category	List of Unix and Linux commands
Documentation	help • mandb • man • pinfo
Disk space analyzers	df • duf • ncdu • pydf
File Management	cat • cp • less • mkdir • more • tree
Firewall	Alpine Awall • CentOS 8 • OpenSUSE • RHEL 8 • Ubuntu 16.04 • Ubuntu 18.04 • Ubuntu 20.04
Linux Desktop Apps	Skype • Spotify • VLC 3
Modern utilities	bat • exa
Network Utilities	NetHogs • dig • host • ip • nmap
OpenVPN	CentOS 7 • CentOS 8 • Debian 10 • Debian 8/9 • Ubuntu 18.04 • Ubuntu 20.04
Package Manager	apk • apt
Processes Management	bg • chroot • cron • disown • fg • glances • gtop • iotop • jobs • killall • kill • pidof • pstree • pwdx • time • vtop
Searching	ag • grep • whereis • which
Shell builtins	compgen • echo • printf
Text processing	cut • rev
User Information	groups • id • lastcomm • last • lid/libuser-lid • logname • members • users • whoami • who • w
WireGuard VPN	Alpine • CentOS 8 • Debian 10 • Firewall • Ubuntu 20.04
Comments on this entry are closed.

Sergio Luiz Araujo Silva Jun 19, 2012 @ 15:56
Exceptional work, learned a lot from this script and certainly increased my love of the shell a little more. Not to go unnoticed would like to send this page: http://orangesplotch.com/bash-going-up/

link
qswb Jun 20, 2012 @ 9:21
Wow this is awesome!

but……. i get this error for any command i run [host,ping]

bash: ${h,,}: bad substitution
what am i doing wrong?
thanks!

link
Sergio Araujo Dec 30, 2016 @ 12:06
To use this syntax make sure you are using bash 4 or superior, if you are using zsh
try ${h:l} “Letter L” wich means lowercase

link
🐧 nixCraft Jun 20, 2012 @ 10:53
@qswb,

You are using old version of bash. This will only work in latest version of bash. Find:

local f="${h,,}"
Replace with:

local f="$(echo "$h" | tr '[A-Z]' '[a-z]')"
This should fix the problem for older version.

link
Iuri Gomes Diniz Jun 20, 2012 @ 13:54
Instead of using /bin/ping in order to get real ‘ping’, you can use the command shell bultiin:

command ping
Also, you can use command in order to get same behavior of:

local _ping="/bin/ping"
$_ping $args $c
The advantage is that command ping search for ping on $PATH, you don’t need to now where real ‘ping’ is.

link
qswb Jun 20, 2012 @ 22:33
GNU bash, version 3.2.39-release x86_64

WORKS!

link
Shantanu Jun 21, 2012 @ 9:31
Hi,

Couple of ideas:
* I think, the “absh 4″ism should be explicitly mentioned, as this can throw people off! 🙂
* using ‘/etc/init.d/’ in the variable list is not necessary, it can be put in the command.

Regards,
Shantanu

link
LinuxRawkstar Jun 21, 2012 @ 14:56
Haven’t you ever heard of sed? Dang!

link
BasketCase Jun 21, 2012 @ 16:12
A couple of shortcuts…

Instead of !!:2 for the second parameter of the previous command you can use !$ for the last parameter of the previous command since the last one is usually what you want.

Instead of /bin/ping or ‘command ping’ to use bypass aliases with a simple escape as in ‘ping’.

link
🐧 nixCraft Jun 21, 2012 @ 16:28
@Shantanu,
I did mentioned in script

## Note: Only works with bash 3.x or 4.x+ ##
@LinuxRawkstar,
Why use 3rd party utility? You can save time and cpu cycle with bash builtin.

@BasketCase,
True, but in this case I’m using ping() and not an alias so I can not simply by pass using ping syntax.

Appreciate all comments.

link
LinuxRawkstar Jun 21, 2012 @ 17:29
sed is in no way a “3rd party” utility. It’s a core staple of Linux and Unix for decades. Unlike these version-dependent bash-isms, it uses actual readable regular expressions and is compatible pretty much everywhere.

link
Nathan Jun 21, 2012 @ 20:18
Genius!

link
Harikrishnan P Dec 10, 2014 @ 8:48
Nice trick. But Flags like ping -c3 did’t work.

link
Sergio Araujo Dec 30, 2016 @ 11:55
I did my own version using zsh [1], and to me is better because zsh deals with arrays better, for example, you do not nead to know array size to get last argument, just: $array[-1] and to get the rest $array[1,-2]

1 – https://github.com/voyeg3r/dotfiles/blob/c1f88e495f01839851d81d23a27127ecce28a4cb/rcfiles/zsh/functions/wrapper_functions.lib#L43-L54

link
Comments are closed. Still have questions? Post it on our forum
Next post: Unix / Linux: See Colourised Filesystem Disk Space Usage with pydf

Previous post: Linux / Unix Desktop Fun: Text Mode ASCII-art Box and Comment Drawing

 


🔎 To search, type & hit enter...

130 Cool Open Source Software I Discovered in 2013
230 Handy Bash Shell Aliases For Linux / Unix / Mac OS X
3Top 32 Nmap Command Examples For Linux Sys/Network Admins
425 PHP Security Best Practices For Linux Sys Admins
530 Linux System Monitoring Tools Every SysAdmin Should Know
640 Linux Server Hardening Security Tips
7Linux: 25 Iptables Netfilter Firewall Examples For New SysAdmins
8Top 20 OpenSSH Server Best Security Practices
9Top 25 Nginx Web Server Best Security Practices
10My 10 UNIX Command Line Mistakes
SIGN UP FOR MY NEWSLETTER

Sign up for my newsletter
➔Howtos & Tutorials
➔Linux shell scripting tutorial
➔RSS/Feed
➔About nixCraft


 
©2002-2021 nixCraft • Privacy • ToS • Contact/Email • Corporate patron Linode