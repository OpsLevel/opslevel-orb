#!/bin/bash

echo "installing ca-certificates ..."
apt-get update >/dev/null 2>&1
apt-get install -y ca-certificates >/dev/null 2>&1

echo "sending opslevel request with vars ..."
echo "INTEGRATION_URL: XXX"
echo "SERVICE: $SERVICE"
echo "DESCRIPTION: $DESCRIPTION"
echo "ENVIRONMENT: $ENVIRONMENT"
echo "NUMBER: $NUMBER"
echo "DEPLOYER_NAME: $DEPLOYER_NAME"
echo "DEPLOYER_EMAIL: $DEPLOYER_EMAIL"
echo "DEDUPLICATION_ID: $DEDUPLICATION_ID"

OPSLEVEL_FILE=./opslevel.yml
if test -f "$OPSLEVEL_FILE"; then
  OPSLEVEL_SERVICE=$(grep "name:" < "$OPSLEVEL_FILE" | awk '{gsub("name:",""); print}' | xargs)
fi

cat <<EOF > data.yaml
service: "${SERVICE:-${OPSLEVEL_SERVICE:-${CIRCLE_PROJECT_REPONAME}}}"
description: "${DESCRIPTION}"
environment: "${ENVIRONMENT:-production}"
deploy-number: "${NUMBER:-${CIRCLE_BUILD_NUM}}"
deploy-url: "${CIRCLE_BUILD_URL}"
dedup-id: "${DEDUPLICATION_ID:-${CIRCLE_JOB}}"
deployer:
  name: "${DEPLOYER_NAME:-${CIRCLE_USERNAME}}"
  email: "${DEPLOYER_EMAIL}"
EOF

opslevel create deploy -i "$INTEGRATION_URL" -f .
