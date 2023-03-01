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
