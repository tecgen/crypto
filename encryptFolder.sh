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

#countOfFilesAndDirs=`find $folder -type f | wc -l`
#countOfDirectories=`find $folder -type d | wc -l`
#countOfFiles=$($countOfFilesAndDirs - $countOfDirectories)

#echo $countOfFiles

for f in $folder/*
do
  # directory or real file?
  if [[ -d $f ]];
    then
      # call this script recursivly with the directory and password
      ./$0 $f $password
    else
      # check if not already encrypted
      ext="${f##*.}"
      if [ $ext != "$encrypted.gz" ]
        then
        # encrypt this file by using the password
        ./encrypt.sh $f $password
        gzip $f.$encrypted
        else
          echo $f already encrypted
      fi

  fi
done
