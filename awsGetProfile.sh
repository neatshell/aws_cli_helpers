############
## Perform a fuzzy search on the result of aws configure list-profiles
## with the passed profile_substring string 
###########
profile_substring=${1}
[ ! ${profile_substring} ] && echo "Missing required arg: profile_substring" && exit 1

profiles=$(aws configure list-profiles)
match=$(echo "${profiles}" | grep "${profile_substring}")

print_error(){
	if [ ! ${n} ]; then
		echo "Cannot find any matches with the passed profile_substring: \"${profile_substring}\""
		echo
		echo "Here the list of profiles currently handled:"
		echo "${profiles}"
	else
		echo "Cannot find a single match with the passed profile_substring: \"${profile_substring}\""
		echo
		echo "Here the list of matches:"
		echo "${match}"
	fi
	exit 1
}

if [[ ${match} ]]; then
	n=$(echo "${match}" | wc -l)
	if [[ ${n} -eq 1 ]]; then
		echo "${match}"
	else
		print_error ${n}
	fi
else
	print_error
fi	
