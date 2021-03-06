Advanced Bash-Scripting Guide:
Prev	Chapter 36. Miscellany	Next
36.8. Security Issues
36.8.1. Infected Shell Scripts

A brief warning about script security is indicated. A shell script may contain a worm, trojan, or even a virus. For that reason, never run as root a script (or permit it to be inserted into the system startup scripts in /etc/rc.d) unless you have obtained said script from a trusted source or you have carefully analyzed it to make certain it does nothing harmful.

Various researchers at Bell Labs and other sites, including M. Douglas McIlroy, Tom Duff, and Fred Cohen have investigated the implications of shell script viruses. They conclude that it is all too easy for even a novice, a "script kiddie," to write one. [1]

Here is yet another reason to learn scripting. Being able to look at and understand scripts may protect your system from being compromised by a rogue script.

36.8.2. Hiding Shell Script Source
For security purposes, it may be necessary to render a script unreadable. If only there were a utility to create a stripped binary executable from a script. Francisco Rosales' shc -- generic shell script compiler does exactly that.

Unfortunately, according to an article in the October, 2005 Linux Journal, the binary can, in at least some cases, be decrypted to recover the original script source. Still, this could be a useful method of keeping scripts secure from all but the most skilled hackers.

36.8.3. Writing Secure Shell Scripts

Dan Stromberg suggests the following guidelines for writing (relatively) secure shell scripts.

Don't put secret data in environment variables.

Don't pass secret data in an external command's arguments (pass them in via a pipe or redirection instead).

Set your $PATH carefully. Don't just trust whatever path you inherit from the caller if your script is running as root. In fact, whenever you use an environment variable inherited from the caller, think about what could happen if the caller put something misleading in the variable, e.g., if the caller set $HOME to /etc.

Notes
[1]	
See Marius van Oers' article, Unix Shell Scripting Malware, and also the Denning reference in the bibliography.

Prev	Home	Next
Assorted Tips	Up	Portability Issues