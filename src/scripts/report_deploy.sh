#!/bin/bash

echo "installing ca-certificates ..."
apt-get update >/dev/null 2>&1
apt-get install -y ca-certificates >/dev/null 2>&1

cat <<EOF > data.yaml
service: "${SERVICE:-${CIRCLE_PROJECT_REPONAME}}"
description: "${DESCRIPTION}"
environment: "${ENVIRONMENT}"
deploy-number: "${CIRCLE_BUILD_NUM}"
deploy-url: "${CIRCLE_BUILD_URL}"
dedup-id: "${CIRCLE_PIPELINE_ID}"
deployer:
  name: "${DEPLOYER_NAME}"
  email: "${DEPLOYER_EMAIL}"
EOF

echo "request body preview ..."
cat data.yaml

echo "sending request to opslevel ..."
opslevel create deploy -i "$INTEGRATION_URL" -f .
