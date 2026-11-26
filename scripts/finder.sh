#! /usr/bin/env bash
#
# Name          : tool.sh
# Description   : Tool to find some random document in given directory
# Author        : ESGI 3 SI 3 & Dw4rF
# Usage         : ./tool.sh [-d directory] [-n name] [-s string] [-e extention]

#############
# FONCTIONS #
#############

usage(){
echo "$0 [-d directory] [-n name] [-s string] [-e extention]"
}

search_string(){
	grep -R -i "${str_string}" "${str_directory}" 2>/dev/null | cut -d ":" -f 1 | sort | uniq ${str_filename:+| grep -i "${str_filename}"}
	${str_extention:+| grep -i -E "${str_extention}\$"}
}

search_file(){
	find "${str_directory}" ${str_filename:+-iname "*${str_filename}*"}
	${str_extention:+-iname "*.${str_extention}"} 2>/dev/null
}



#############
# VARIABLES #
#############

str_directory=$PWD
str_extention=""
str_filename=""
str_string=""

########
# CODE #
########

while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
  -f | --file )
    shift; str_filename="${1}"; bool_file=1
    ;;
  -e | --extention )
    shift; str_extention="${1}"; bool_file=1
    ;;
  -s | --string )
    shift; str_string="${1}"; bool_string=1
    ;;
  -d | --directory )
    shift; str_directory="${1}"
    ;;
esac; shift; done
if [[ "$1" == '--' ]]; then shift; fi

if [[ ${bool_file} == 1 && ${bool_string} == 0 ]];then
        search_file
elif [[ ${bool_string} == 1 ]];then
        search_string
fi  

