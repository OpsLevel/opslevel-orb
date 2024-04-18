#!/bin/bash

INPUT_DESCRIPTION=$(eval echo "$DESCRIPTION")
INPUT_DEDUPLICATION_ID=$(eval echo "$DEDUPLICATION_ID")
INPUT_DEPLOYER_EMAIL=$(eval echo "$DEPLOYER_EMAIL")
INPUT_DEPLOYER_NAME=$(eval echo "$DEPLOYER_NAME")
INPUT_ENVIRONMENT=$(eval echo "$ENVIRONMENT")
INPUT_INTEGRATION_URL=$(eval echo "$INTEGRATION_URL")
INPUT_NUMBER=$(eval echo "$NUMBER")
INPUT_SERVICE=$(eval echo "$SERVICE")

OPSLEVEL_FILE=./opslevel.yml
if test -f "$OPSLEVEL_FILE"; then
  OPSLEVEL_SERVICE=$(grep "name:" < "$OPSLEVEL_FILE" | awk '{gsub("name:",""); print}' | xargs)
fi

cat <<EOF > data.yaml
service: "${INPUT_SERVICE:-${OPSLEVEL_SERVICE:-${CIRCLE_PROJECT_REPONAME}}}"
description: "${INPUT_DESCRIPTION}"
environment: "${INPUT_ENVIRONMENT:-production}"
deploy-number: "${INPUT_NUMBER:-${CIRCLE_BUILD_NUM}}"
deploy-url: "${CIRCLE_BUILD_URL}"
dedup-id: "${INPUT_DEDUPLICATION_ID:-${CIRCLE_JOB}}"
deployer:
  name: "${INPUT_DEPLOYER_NAME:-${CIRCLE_USERNAME}}"
  email: "${INPUT_DEPLOYER_EMAIL}"
EOF

opslevel create deploy -i "$INPUT_INTEGRATION_URL" -f .

rm data.yaml
