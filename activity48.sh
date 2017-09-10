#!/bin/bash

# Name:  Teresa Henderson
# Date: 07/22/2017
# Class/Instructor: IFT383/Shafer
# Assignment: Examples, Activity 48

cat addr2 | awk -F, '{print $1, "\t", $4, "\t", $5, "\t", $6}'
