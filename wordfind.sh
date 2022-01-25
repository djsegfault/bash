#!/bin/bash
# wordfind [MIN_LETTERS] [MAX_LETTERS] [LETTER]...
#ex wordfind.sh
DICT=/usr/share/dict/words

if [[ ! -f "${DICT}" ]]
then
	echo "Dictionary ${DICT} not found"
	exit 1
fi
if [[ ${#} -lt 3 ]]
then
	echo "${#} parameters is not enough, at least 3 required"
	exit 1
fi
if [[ ${2} -lt ${1} ]]
then
	echo "minLetters must be less than maxLetters"
	exit 1
fi

minLetters="${1}"
shift
maxLetters="${1}"
shift

command="cat ${DICT} | egrep '^.{${minLetters},${maxLetters}}\$'"
while [[ -n "${1}" ]]
do
	command="${command} | grep -i ${1}"
	shift
done
# echo ${command}
eval ${command}
