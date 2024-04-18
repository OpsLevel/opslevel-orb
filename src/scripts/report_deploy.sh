#!/bin/bash

INPUT_INTEGRATION_URL=$(circleci env subst "${INTEGRATION_URL}")
INPUT_SERVICE=$(circleci env subst "${SERVICE}")
INPUT_DESCRIPTION=$(circleci env subst "${DESCRIPTION}")
INPUT_ENVIRONMENT=$(circleci env subst "${ENVIRONMENT}")
INPUT_NUMBER=$(circleci env subst "${NUMBER}")
INPUT_DEPLOYER_NAME=$(circleci env subst "${DEPLOYER_NAME}")
INPUT_DEPLOYER_EMAIL=$(circleci env subst "${DEPLOYER_EMAIL}")
INPUT_DEDUPLICATION_ID=$(circleci env subst "${DEDUPLICATION_ID}")

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

opslevel create deploy -i "${INPUT_INTEGRATION_URL}" -f .

rm data.yaml
