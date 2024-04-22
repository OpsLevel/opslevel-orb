# Official OpsLevel CircleCI Orb

[![CircleCI Build Status](https://circleci.com/gh/OpsLevel/opslevel-orb.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/OpsLevel/opslevel-orb) [![CircleCI Orb Version](https://badges.circleci.com/orbs/opslevel/opslevel.svg)](https://circleci.com/developer/orbs/orb/opslevel/opslevel) [![GitHub License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/OpsLevel/opslevel-orb/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs) [![Overall](https://img.shields.io/endpoint?style=flat&url=https%3A%2F%2Fapp.opslevel.com%2Fapi%2Fservice_level%2Fz4MrqnIp05YYdNN_OCK-hVbdHBxWYjT5zRpJQz9YHpc)](https://app.opslevel.com/services/opslevel_circleci_orb/maturity-report)

This CircleCI orb emits a deploy event for a service to OpsLevel.

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

The deploy number for the event - Default: `${CIRCLE_BUILD_NUM}`

### `deployer_name`

The deployer name who created the event - Default: `${CIRCLE_USERNAME}`

### `deployer_email`

The deployer email who create the event - Default: ""

### `deduplication_id`

An identifier that can be used to deduplicate deployments - Default: `${CIRCLE_JOB}`
