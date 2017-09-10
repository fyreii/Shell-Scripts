# Homework question - emulate the pkill command

BEGIN {

a=ARGV[1]
if (a ~ $1) {
  cmd =  "ps axco comm,pid | grep "a
  while (cmd | getline l) {
   k = substr(l,17)
   print k
   system("kill -9 "k)
  }
} else {
  print "Process not found!"
  }
}

