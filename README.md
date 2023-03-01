# Delete-gitlab-ci-pipelines-script
This bash script allows you to delete several gitlab pipelines using api

```bash
#! /usr/bin/bash
set -e

TOKEN="YOUR_GITLAB_API_TOKEN"
PROJECT_ID="YOUR_PRJECT_ID"
#Specify your gitlab instance
GITLAB_INSTANCE="http://localhost:80/api/v4/projects"
#Specify how many pipelines to load
PER_PAGE=100

for PIPELINE in $(curl --header "PRIVATE-TOKEN: $TOKEN" "$GITLAB_INSTANCE/$PROJECT_ID/pipelines?per_page=$PER_PAGE&sort=asc" | jq '.[].id') ; do
	echo "Deleting pipeline $PIPELINE"
	curl --header "PRIVATE-TOKEN: $TOKEN" --request "DELETE" "$GITLAB_INSTANCE/$PROJECT_ID/pipelines/$PIPELINE"
done
```

To run this script you need register api token in gitlab instance and install jq on your machine

Example of how to install jq on RHEL distros

```
yum install epel-release -y
yum update -y
yum install jq -y
```
