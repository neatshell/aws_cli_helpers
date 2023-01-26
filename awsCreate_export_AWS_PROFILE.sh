############
##
## eval $(awsCreate_export_AWS_PROFILE.sh profile_substring)
##
## if awsGetProfile.sh profile_substring return one and only one value
## return the command to execute into the shell to set the AWS_PROFILE env var
##
###########
profile_substring=${1}
[ ! ${profile_substring} ] && echo "Missing required arg: profile_substring" && exit 1

script_folder=$( cd -- "$( dirname -- "$(readlink ${0})" )" &> /dev/null && pwd )

profile=$(${script_folder}/awsGetProfile.sh "${profile_substring}" 2>&1)

if [[ ${?} -eq 0 ]]; then
	echo "export AWS_PROFILE=${profile}"
else
	echo "${profile}"
fi
