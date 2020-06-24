class GovukConnect < Formula
  desc "Tool for GDS staff to connect to GOV.UK infrastructure"
  homepage "https://github.com/alphagov/govuk-connect"
  url "https://rubygems.org/downloads/govuk-connect-0.2.0.gem"
  sha256 "2867e012ca66512baea3b7cd0c3c34f6d7905c219947c54f1dc82403d7376e55"

  bottle :unneeded

  depends_on "ruby"

  def install
    ENV["GEM_HOME"] = libexec

    system "gem", "install", "--ignore-dependencies", "govuk-connect-#{version}.gem"
    bin.install libexec/"bin/govuk-connect"
    bin.env_script_all_files(libexec/"bin", :GEM_HOME => ENV["GEM_HOME"])
  end

  test do
    error_message = "error: you must specify the environment"
    assert_match(error_message, shell_output("#{bin}/govuk-connect ssh 2>&1 >/dev/null", 1))
  end
end
