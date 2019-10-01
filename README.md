homebrew-gds
============

A private Homebrew tap for the internal GDS CLI tooling, like the [gds-cli](https://github.com/alphagov/gds-cli).

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
