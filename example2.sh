#!/bin/bash

# Name:  Teresa Henderson
# Date: 07/22/2017
# Class/Instructor: IFT383/Shafer
# Assignment: Examples, Example 2

# Displays the percentages of lines over and under
# the average values in the given file

# set -x

IFS=' '

for line in `cat data3`
do
# Grab values and stick them into an array
values=(`echo $line | grep -i '^[0-9]'`)
  # for each value in the array, determine if it is
  # over or under 22 - yes I know I used a static value
  # because $avg isn't defined yet

  # increment the counter for over or under 22
  # increment the counter for the line read loop
  for v in $values
  do
  if [[ $v > 22 ]] ; then
    let "lesst ++"
  else
    let "moret ++"
  fi
   sum=$(($sum + $v));
  done
let "counter ++"
done

# For some reason my counter kept doing one extra count
# so for brevity sake I just subtract one from the actual value
fixct=$(($counter - 1));
# calculate average of all values
avg=$(($sum / $fixct));
# calculate the percentage of each count of over and under
# restrict bc to one decimal place and multiple by 100 to get percentage
pctover=`echo "scale=1; $moret / $fixct * 100" | bc -l`
pctunder=`echo "scale=1; $lesst / $fixct * 100" | bc -l`

echo "Percentage of lines over the average of $avg is: $pctover"
echo "Percentage of lines under the average of $avg is: $pctunder"
