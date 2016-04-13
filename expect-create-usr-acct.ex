#!/usr/bin/expect -f
#
# Created: 01/05/2011 by Teresa Henderson
# mkusracct.ex
# --------------- BEGIN SCRIPT ----------------

# Print a usage statement if less than one argument

if {$argc < 1} {
  send_user "Usage: mkusracct.ex HOSTNAME\n"
  exit
}

# Set some variables for use

set host [lindex $argv 0]
set rtusr "root"
set user "thenders"
set rtpass "rootpassword"
set temp "changeme"
set newpass "mypassword"
set prompt "(%|#|\\$|%]) $"

# Does "stuff with things" as root

spawn ssh -l $rtusr $host 
expect "(yes/no)?"
send "yes\n"
expect "password:"
send "$rtpass\n"
expect ">"
send "mkuser id=1234 pgrp=system home=/home/user gecos='My Name Here' shortname\n"
expect ">"
send "passwd shortname\n"
expect "password:"
send "$temp\n"
expect "Re-enter"
send "$temp\n"
expect ">"
send "exit\n"

sleep 2

# After user is created
spawn ssh -l $user $host
expect "password:" 
send "$temp\n"
expect "Old password:"
send "$temp\n"
expect "New password:"
send "$newpass\n"
expect "password:"
send "$newpass\n"
expect ">"
send "mkdir .ssh\n"
expect ">"
send "exit\n"

# This section pushes SSH keys if you have them to push
#
spawn scp /home/thenders/.ssh/authorized_keys $host:/home/thenders/.ssh/authorized_keys
expect "ssword:"
send "$newpass\n"
sleep 2
expect "100%"

# ------------------ END SCRIPT ------------
