homebrew-gds
============

A private Homebrew tap for the internal GDS CLI tooling, like the [gds-cli](https://github.com/alphagov/gds-cli) and the [govuk-cli](https://github.com/alphagov/govuk-cli).

## GDS CLI

### Pre-requisites

- An SSH key configured, as the gds-cli repo clones over SSH.

### Usage

```
brew tap alphagov/gds
brew install gds-cli
gds --version
```

or

```
brew install alphagov/gds/gds-cli
gds --version
```

## GOV.UK CLI

### Pre-requisites

- An understanding that this is the `govuk connect` tool, not the [`govukcli` tool from the govuk-aws repo](https://docs.publishing.service.gov.uk/manual/howto-ssh-to-machines-in-aws.html). Both are valid tools to use!

### Usage

```
brew tap alphagov/gds
brew install --HEAD govuk-cli
govuk connect
```

or

```
brew install --HEAD alphagov/gds/govuk-cli
```
