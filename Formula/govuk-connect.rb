class GovukConnect < Formula
  desc "Tool for GDS staff to connect to GOV.UK infrastructure"
  homepage "https://github.com/alphagov/govuk-connect"
  url "https://rubygems.org/downloads/govuk-connect-0.3.2.gem"
  sha256 "46d47e5d788ad5063b636c56fc99303b310defe735ada6f4bdb4cb9f45c87757"

  bottle :unneeded

  depends_on "ruby"

  def install
    ENV["GEM_HOME"] = libexec

    system "gem", "install", "--ignore-dependencies", "govuk-connect-#{version}.gem"
    bin.install libexec/"bin/govuk-connect"
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV["GEM_HOME"])
  end

  test do
    error_message = "error: you must specify the environment"
    assert_match(error_message, shell_output("#{bin}/govuk-connect ssh 2>&1 >/dev/null", 1))
  end
end
