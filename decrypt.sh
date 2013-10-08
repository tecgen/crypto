#!/bin/bash
openssl enc -d -aes-256-cbc -a -in $1 -out $2
