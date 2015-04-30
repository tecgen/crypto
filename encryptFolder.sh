#!/bin/bash
me="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
argumentCount=$#
folder=$1
password=$2


# load configurations
source user.cfg
source global.cfg


checkIfParametersAreGiven $me $argumentCount

# when no password has been given
if [ $argumentCount -eq 1 ]
then
  read -s -p "encryption password? " password
  echo thank you!

fi

# check first how many files need to be processed
# in order to be able to calculate an progress
for f in $folder/*
do
  # file or directory?
  if [[ -d $f ]];
    then
      # echo $f is a directory
      # call this script recursivly with the directory and password
      ./$0 $f $password
    else
      # echo $f is a file
      # encrypt this file by using the password
      ./encrypt.sh $f $password
      gzip $f.$encrypted
  fi
done
