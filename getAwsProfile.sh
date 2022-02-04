############
## Perform a fuzzy search on the result of aws configure list-profiles
## with the passed profile string 
###########
profile=${1}
[ ! ${profile} ] && echo "Missing required arg: profile" && exit 1

profiles=$(aws configure list-profiles)
match=$(echo "${profiles}" | grep "${profile}")


print_error(){
	echo "Cannot found a match with \"${profile}\""
	echo
	echo "${profiles}"
	exit 1
}

if [[ ${match} ]]; then
	n=$(echo "${match}" | wc -l)
	if [[ ${n} -eq 1 ]]; then
		echo "${match}"
	else
		print_error
	fi
else
	print_error
fi	
