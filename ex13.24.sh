
#!/bin/bash

# Name:  Teresa Henderson
# Date: 07/22/2017
# Class/Instructor: IFT383/Shafer
# Assignment: Hwk4 Question 13.24

# Comments:  This assignment wound up having a LOT of edge cases and had a
# prequisite of having done 3.18, which isn't included as a question.

#set -x

# Assumes the file teledir.txt exists.  If it doesn't, the first "new"
# entry will create it regardless.

# if no arguments are entered, exit
case $# in 0)
echo "You must enter at least one argument!" ;;
1)
  # if one argument is entered, check whether it is a string or a number
  # if it is a string, look for it in the file - if it is found, display the record
  if [[ $* =~ ^([a-zA-Z\]) ]] ; then
    name=`echo $*`
    search=`cat teledir.txt | grep -i -m 1 $name | cut -d: -f2`
    echo "The phone number for $name is $search"
    # if the string argument is not found, ask the user for a phone number to go with it
    if  [[ -z $search ]] ; then
        echo "Please enter the phone number for this name: "
        echo "in the format: nnn-nnn-nnnn where n1 != 0"
        read mnumber
      # if the user entered phone number starts with a 0 prompt for a valid number
      if [[ $mnumber == 0* ]] ; then
        echo "Invalid phone number, please re-enter: "
        read mnumber
      fi
      # create the new entry based on user input in the proper format
      echo "A new entry for $name has been added!"
      echo "$name : $mnumber" >> teledir.txt
    fi
  # if the argument given is a number then check to make sure it is a valid phone number
  # in the format nnn-nnn-nnnn
  # if it's valid, look for it in the file.  If it's found display it.
  elif [[ $* =~ ^([0-9\]) ]] ; then
    number=`echo $*`
    if [[ ! $number == 0* ]] && [[ ${#number} == 12 ]] && [[ $number =~ [0-9]+$ ]] ; then
      num_valid=`cat teledir.txt | grep -i -m 1 $number | cut -d: -f1`
      echo "The name for number $number is $num_valid"
      # if the number is valid and does not exist, ask the user for a name to go with it
      if [[ -z $num_valid ]] ; then
        echo "Please enter the name for this number: "
        read mname
        # create the new entry based on user input in the proper format
        echo "A new entry has been added to the directory."
        echo "$mname : $number" >> teledir.txt
      fi
      else
      # if a phone number does not pass the validation test, exit
       echo "Invaid phone number format! Correct format is: "
       echo "1nn-nnn-nnn"
    fi
  fi ;;
2)
  # for two arguments, first separate them so we can manipulate them
  arg1=`echo $* | cut -d' ' -f1`
  arg2=`echo $* | cut -d' ' -f2`
  # if either argument starts with 0, it is invalid
  if [[ $arg1 || $arg2 =~ 0* ]] ; then
   echo "Invalid phone number entered!"
   exit 1
  fi
  # for each argument make sure it is a string or a number
  if [[ $arg1 || $arg2 =~ ^([a-zA-Z\]) ]] || [[ $arg1 || $arg2  =~ ^([0-9\]) ]]; then
    # look for both arguments in the file, if either is found, display it
    arg_search=`cat teledir.txt | grep $arg1` || `cat teledir.txt | grep $arg2`
    echo "Record found! $arg_search"
    # if the search doesn't return anything, see if one of the arguments is a number
    # to determine order to put it in the file
    if [[ -z $arg_search ]] ; then
      t='^[1-9]'
      if ! [[ $arg1 =~ $t ]] ; then
        echo "Entry does not exist.  A new one has been created."
        echo "$arg1 : $arg2" >> teledir.txt
      else
        echo "Entry does not exist.  A new one has been created."
        echo "$arg2 : $arg1" >> teledir.txt
      fi
    fi
  fi
esac
