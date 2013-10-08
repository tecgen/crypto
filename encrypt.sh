#!/bin/bash
filenameWithExtension=$(basename "$1")
extension="${filenameWithExtension##*.}"
filename="${filenameWithExtension%.*}"
openssl enc -aes-256-cbc -a -salt -in $filenameWithExtension -out $filename.$extension.encrypted
rm $filenameWithExtension

