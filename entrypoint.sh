#!/usr/bin/env bash

c_path=$1
c_action=$2
c_password=$3

function dec_file() {
  echo "dec file ${1}";
  [ "${1: -4}" == '.enc' ] && { openssl enc -d -a -aes256 -pbkdf2 -k ${2} -in $1 -out "${1::-4}" && rm -f $1; } || {
    echo "dec file ${1} failure."
  }
}

function enc_file() {
  echo "enc file ${1}";
  [ "${1: -4}" != '.enc' ] && { openssl enc -e -a -aes256 -pbkdf2 -k ${2} -in $1 -out "${1}.enc" && rm -f $1; } || {
    echo "enc file ${1} failure."
  }
}

function dec_dir() {
  find $1 -type f -name '*.enc' | while read line; do
    dec_file $line $2;
  done
}

function enc_dir() {
  find $1 -type f ! -name '*.enc' | while read line; do
    enc_file $line $2;
  done
}


# check
[ -e $c_path ] || { echo "$c_path not exist." ; exit 1; }
[ "$c_action" == 'enc' ] || [ "$c_action" == 'dec' ] || { echo "action in 'enc,dec'"; exit 1; }
 
if [ -d $c_path ]; then 
  echo "action dir ${c_path}"
  [ "$c_action" == "enc" ] && enc_dir $c_path $c_password || dec_dir $c_path $c_password
else
  [ "$c_action" == 'enc' ] && enc_file $c_path $c_password || dec_file $c_path $c_password
fi
