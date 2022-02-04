############
##
## eval $(./createAwsProfileExport.sh partial_profile_string)
##
## run aws configure list and check that the "Value" column has what you expect
##
###########
profile=$(./getAwsProfile.sh "$@")

if [[ $? -eq 0 ]]; then
	echo "export AWS_PROFILE=${profile}"
else
	echo "${profile}"
fi
