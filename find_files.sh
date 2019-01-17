#! /bin/bash

Num_Required_Args=2 # Atleast two arguments are required, but can be 3 if regular expression argument has to be passed
num_args=$#
# Do we have atleast two arguments?
if [ $num_args -lt $Num_Required_Args ];then
	echo " Not enough arguments! Use like this: bash find_files.sh ""PATH"" ""SUFFIX"" ""EXP"" "
	exit 1
fi

Path=$1
Suffix=$2
Exp=$3

echo "Your arguments were: $1 , $2 and  $3"


function find_files_and_suffix(){
	for dir in ${Path}; do
	#find ${Path} -type f -name ${Suffix}
	#find ${Path} -type f -name ${Suffix} -exec grep -rl ${Exp} {} +
	find . -type f -name ${Suffix} -regex '.*/'${Exp}'[^/]*$' -exec readlink -f {} \;| tee output0001.txt
	#result_all="$(find "$dir" -type f -name "${Suffix}" -printf .)"
	result="$(find . -type f -name "${Suffix}" -regex '.*/'"${Exp}"'[^/]*$' -printf .)"
	#echo "Folder '${dir}' contains ${#result_all} ${Suffix} files"
	echo "${#result} ${Suffix} matches your criteria"
	done
}

# call a function

find_files_and_suffix $Path $Suffix $Exp
exit 0
