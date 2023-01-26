credentials_text="$(pbpaste)"
profile=$(echo "${credentials_text}" | head -n 1 | tr -d '[]')
script_folder=$( cd -- "$( dirname -- "$(readlink ${0})" )" &> /dev/null && pwd )

${script_folder}/awsGetProfile.sh "${profile}" &>/dev/null

if [[ $? -ne 0 ]]; then
	echo "[33mWarning: \"${profile}\" doesn't exists and will be created[0m"
fi

get_value_for_key(){
	key=${1}
	echo "${credentials_text}" | grep ${key} | sed "s/${key}=//g"	
}

create_command(){
	key=${1}
	echo "aws configure --profile ${profile} set ${key} $(get_value_for_key ${key})"
}

keys="aws_access_key_id
aws_secret_access_key	
aws_session_token"

for key in ${keys}; do
	cmd=$(create_command ${key})
	echo "[92m${cmd}[0m" && ${cmd}
done

