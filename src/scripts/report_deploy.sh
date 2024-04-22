#!/bin/bash

echo "installing ca-certificates ..."
apt-get update
apt-get install -y ca-certificates

echo "sending opslevel request with vars ..."
echo "INTEGRATION_URL: $INTEGRATION_URL"
echo "INPUT_SERVICE: $INPUT_SERVICE"
echo "INPUT_DESCRIPTION: $INPUT_DESCRIPTION"
echo "INPUT_ENVIRONMENT: $INPUT_ENVIRONMENT"
echo "INPUT_NUMBER: $INPUT_NUMBER"
echo "INPUT_DEPLOYER_NAME: $INPUT_DEPLOYER_NAME"
echo "INPUT_DEPLOYER_EMAIL: $INPUT_DEPLOYER_EMAIL"
echo "INPUT_DEDUPLICATION_ID: $INPUT_DEDUPLICATION_ID"

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
