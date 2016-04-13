#!/usr/bin/expect -f
#
# Created: 07/25/2008 by thenders
# etlftp.ex
#
# This script FTP's to a local site and grabs a file, renames it
# and sends it to a remote site that requires SFTP
#
# --------------- BEGIN SCRIPT ----------------

# Sets conservative mode (wait between commands) to fix potential timing issues

set force_conservative 0  ;
                         
if {$force_conservative} {
        set send_slow {1 .1}
        proc send {ignore arg} {
                sleep .1
                exp_send -s -- $arg
        }
  }

# Set some variables for use

# Host 1 Information
set host1 "myhost1"
set user1 "user"
set pass1 "password"

# Host 2 Information
set host2 "myhost1"
set user2 "user"
set pass2 "password"

# File Information
set date [timestamp -format "%Y-%m-%d"]
set orig "WFB_REP1.txt"
set newf "WFB_REP1_$date.txt"

# Get the file from the first host

exec cd /etldata/infafiles/Pgms/Temp

spawn ftp -n $host1
expect "User"
send "$user1\r"
expect "assword:"
send "$pass1\r"
expect "ftp> "
send "cd /mydir/dest\r"
expect "ftp> "
send "get $orig\r"
expect "ftp> "
send "quit\r"
expect eof

# Rename the gotten file and send it to the second host

exec mv $orig $newf

spawn sftp $user2@$host2
expect "assword:"
send "$pass2\r"
expect "sftp> "
send "cd /CabelaXfer\r"
expect "sftp> "
send "put $newf\r"
expect "sftp> "
send "quit\r"
expect eof

# ------------------ END SCRIPT ------------
