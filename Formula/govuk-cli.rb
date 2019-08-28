class GovukCli < Formula
  desc "CLI for GOV.UK to help connecting to machines in the estate"
  homepage "https://github.com/alphagov/govuk-cli.git"
  # The repo doesn't tag versions (yet).
  url "https://github.com/alphagov/govuk-cli.git"
  version "0.0.1"
  head "https://github.com/alphagov/govuk-cli.git"

  def install
    bin.install "bin/govuk-connect"
    bin.install "bin/govuk"
  end
end
