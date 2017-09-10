#!/bin/bash

# Name:  Teresa Henderson
# Date: 07/22/2017
# Class/Instructor: IFT383/Shafer
# Assignment: Examples, Activity 47

for line in `cat /etc/group`
do
  IFS=:
  var=($line)
  echo -e "${var[0]} \t ${var[3]}"
done
