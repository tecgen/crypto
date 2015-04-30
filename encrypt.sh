#!/bin/bash
me="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
argumentCount=$#
password=$2

# load configurations
source user.cfg
source global.cfg


checkIfParametersAreGiven $me $argumentCount

# get file name and extension
filenameWithExtension=$(basename "$1")
# persist extension only
extension="${filenameWithExtension##*.}"
filename="${filenameWithExtension%.*}"

# when one parameter is available
if [ $argumentCount -eq 1 ]
then
  openssl enc -$cipher -a -salt -in $filenameWithExtension -out $filenameWithExtension.$encrypted
fi

# when two parameters are available
if [ $argumentCount -eq 2 ]
then
  openssl enc -$cipher -a -salt -in $filenameWithExtension -out $filenameWithExtension.$encrypted -k $password
fi

# when error code is 0
if [ $? -eq 0 ]
then
  echo "$filename => encryped"
  exit 0
else
  echo "$filename => NOT encrypted" >&2
  # return error code 1 to caller
  exit 1
  #rm $filenameWithExtension
fi
