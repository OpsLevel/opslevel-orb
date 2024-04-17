# OpsLevel - Report Deploy CircleCI Orb

[![CircleCI Build Status](https://circleci.com/gh/OpsLevel/opslevel-orb.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/OpsLevel/opslevel-orb) [![CircleCI Orb Version](https://badges.circleci.com/orbs/namespace-1/opslevel.svg)](https://circleci.com/developer/orbs/orb/namespace-1/opslevel) [![GitHub License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/OpsLevel/opslevel-orb/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)

This orb emits a deploy event for service to OpsLevel.

## Inputs

## Inputs

### `integration_url`

**Required** The OpsLevel deploy integration url.

### `service`

The service alias for the event - Default: `<github_org_or_user_name>/<repository_name>`

If the repository has an `./opslevel.yml` file the service name will get pulled from it.

### `description`

The description or release notes for the event - Default: ""

### `environment`

The environment for the event - Default: ""

### `number`

The deploy number for the event - Default: `${GITHUB_RUN_NUMBER}`

### `deployer_name`

The deployer name who created the event - Default: `${GITHUB_ACTOR}`

### `deployer_email`

The deployer email who create the event - Default: ""

### `deduplication_id`

An identifier that can be used to deduplicate deployments - Default: `${GITHUB_RUN_ID}`

## Example usage

TODO: update these examples/redirect to orb docs...

```yaml
jobs:
  deploy:
    steps:
      - name: Report Deploy
        uses: OpsLevel/report-deploy-github-action@v0.7.0
        with:
          integration_url: ${{ secrets.DEPLOY_INTEGRATION_URL }}
          service: "my-service"
```

If you want to add the git commit author as the deployer

```yaml
jobs:
  deploy:
    steps:
      - name: Get Deployer
        id: deployer
        run: |
          DEPLOYER=$(git show -s --format='%ae')
          echo "DEPLOYER=${DEPLOYER}" >> $GITHUB_OUTPUT
      - name: Report Deploy
        uses: OpsLevel/report-deploy-github-action@v0.7.0
        with:
          integration_url: ${{ secrets.DEPLOY_INTEGRATION_URL }}
          service: "my-service"
          deployer_email: ${{ steps.deployer.outputs.DEPLOYER }}
```
