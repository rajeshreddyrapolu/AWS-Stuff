#!/bin/bash

unset AWS_SESSION_TOKEN

temp_role=$(aws sts assume-role \
					--role-arn "arn:aws:iam::097878324419:role/admins" \
					--role-session-name "CloudFormationSession")
echo "Testing"
export AWS_ACCESS_KEY_ID=$(echo $temp_role | jq .Crredentials.AccessKeyId | xargs)
export AWS_SECRET_ACCESS_KEY=$(echo $temp_role | jq .Crredentials.SecretAccessKey | xargs)
export AWS_ACCESS_KEY_ID=$(echo $temp_role | jq .Crredentials.AccessKeyId | xargs)
env | grep -i AWS_
echo "running ansible playbook $ANSIBLE_PLAYBOOK_PATH $ANSIBLE_PLAYBOOK_TAGS"

if [ -z "$ANSIBLE_PLAYBOOK_TAGS" ]; then
	ansible-playbook "$ANSIBLE_PLAYBOOK_PATH"
else
	ansible-playbook "$ANSIBLE_PLAYBOOK_PATH" -t "$ANSIBLE_PLAYBOOK_TAGS"
fi
