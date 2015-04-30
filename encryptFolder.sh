#!/bin/bash
me="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
argumentCount=$#
folder=$1
password=$2

# load configurations
source user.cfg
source global.cfg


checkIfParametersAreGiven $me $argumentCount

# check first how many files need to be processed
# in order to be able to calculate an progress
for f in $folder/* do

  # file or directory?
  if [[ -d $f ]];
    then
        # $f is a directory
    else
        # $f is a file
  fi
done
