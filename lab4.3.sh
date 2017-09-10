#!/bin/bash

# Name:  Teresa Henderson
# Date: 07/20/2017
# Class/Instructor: IFT383/Shafer
# Assignment: Lab 4.3

# Description: Produces tablular output from the given file

# uncomment for debugging
#set -x

# prints headers, date is static
echo "Performance Data"
echo "Date: 12-30-2006"

# create an array with an index of letters corresponding to lines we want
# and ignoring any lines that don't matter
index=("B" "P" "Q" "R" "H" "O" "C" "K" "W" "L")
# read in file data.iva line by line
cat data.iva | while read line
do
  # grab the first letters from the lines passed in
  match=(`echo $line | cut -d' ' -f1`)
  # loop through the index array and look for matching letters
  for i in ${index[@]}
  do
    # if the letter at the front of the line matches an array value
    # grab the rest of the line minus the first letter    
    if [[ "$match" == "${i}" ]] ; then
        calc=(`echo $line | cut -c2-`)
	# set each set of numbers per array location to a variable
        num1=${calc[0]}
        num2=${calc[1]}
        num3=${calc[2]}
        
	# calculate the sum of each set of numbers from the array
	# pass sum through bc to retain decimal points
        sum=(`echo $num1 + $num2 + $num3 | bc`)

	# calculate the average of each sum (I could have used a count, but since it's 3 values, meh.)
	# pass average through bc with the -l  flag to force decimal printing, pass scale flag to set 
	# the number of decimal places bc displays.  Interestingly, scale= only works with division.
        avg=(`echo "scale=2; $sum/3" | bc -l`)
	
	# grab our matches from above (I suppose looking at it now I could have just used index, but w/e)
	# for each letter, echo back the category it corresponds to according to the report in the lab
        case $match in "B")
         echo "Tamb (C) $avg" ;;
          "P")
         echo "Tref (C) $avg" ;;
          "Q")
         echo "Tm (C) $avg" ;;
          "R")
         echo "Irradiance (W/m%2) $avg" ;;
          "H")
         echo "Isc (A) $avg" ;;
          "O")
         echo "Voc (V) $avg" ;;
          "C")
         echo "Imp (A) $avg" ;;
          "K")
         echo "Vmp (V) $avg" ;;
          "W")
         echo "Pm (W) $avg" ;;
          "L")
         echo "FF (%) $avg" ;;
        esac
    fi
  done
done

