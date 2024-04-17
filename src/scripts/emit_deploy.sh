#!/bin/bash
# This example uses envsubst to support variable substitution in the string parameter type.
# https://circleci.com/docs/orbs-best-practices/#accepting-parameters-as-strings-or-environment-variables
TO=$(circleci env subst "${PARAM_TO}")
# If for any reason the TO variable is not set, default to "World"
echo "Hello ${TO:-World}!"

#!/bin/sh -l

OPSLEVEL_FILE=./opslevel.yml
if test -f "$OPSLEVEL_FILE"; then
  OPSLEVEL_SERVICE=$(cat ./opslevel.yml | grep "name:" | awk '{gsub("name:",""); print}' | xargs)
fi

cat <<EOF > data.yaml
service: "${INPUT_SERVICE:-${OPSLEVEL_SERVICE:-${GITHUB_REPOSITORY}}}"
description: "${INPUT_DESCRIPTION}"
environment: "${INPUT_ENVIRONMENT:-production}"
deploy-number: "${INPUT_NUMBER:-${GITHUB_RUN_NUMBER}}"
deploy-url: "${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}"
dedup-id: "${INPUT_DEDUPLICATION_ID:-${GITHUB_RUN_ID}}"
deployer:
  name: "${INPUT_DEPLOYER_NAME:-${GITHUB_ACTOR}}"
  email: "${INPUT_DEPLOYER_EMAIL}"
EOF

opslevel create deploy -i "${INPUT_INTEGRATION_URL}" -f .

rm data.yaml
