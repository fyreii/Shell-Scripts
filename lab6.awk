
# File name: lab6.awk
# Purpose: formats an address book
# Author: Teresa Henderson
# Course: IFT 383 Online
# Term: Summer 2017
# Date: 8/3/2017

BEGIN {
FS = ":"
}

# begin input loop
{
# Fixes the spacing in formal names
if (/^[A-Z][A-Z]/) {
 a = substr($2, 1,1) " " substr($2, 2)
}
# fixes the spacing for most things in the street number field
if (/^[A-Z][A-Z]/) {
 b = substr($8, 1,1) " " substr($8, 2)
}
# fixes the spaceing in the street names
if (/^[A-Z][a-z]/g) {
 c = substr($9, 1,7) " " substr($9, 8,5) " " substr($9, 13,15)
}
print $1, a", "  $3 # first, last, id
print $7, b, c # street number, name
print $10", " $6, $11 # city, state
print $4  # email
# prints the phone number in (xxx)xxx-xxxx format
print "(" substr($5, 1, 3) ") " substr($5, 4, 3) "-" substr($5, 7, 4) "\n"
}
