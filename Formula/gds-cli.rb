class GdsCli < Formula
  desc "CLI for common commands used by Government Digital Service staff"
  homepage "https://github.com/alphagov/gds-cli"
  url "git@github.com:alphagov/gds-cli.git",
      :using    => :git,
      :tag      => "vv1.15.0",
      :revision => "4cd73843f72f4c99442034e732fdccb85cfb8e2b"
  head "git@github.com:alphagov/gds-cli.git", :using => :git

  depends_on "go" => :build
  depends_on "linuxbrew/extra/aws-vault" if OS.linux?

  def install
    ENV["GOOS"] = OS.mac? ? "darwin" : "linux"
    ENV["GOARCH"] = "amd64"

    system "make"

    bin.install "gds-cli"
    bin.install_symlink("gds-cli" => "gds")
  end

  def caveats
    return if OS.linux?

    "gds-cli depends on aws-vault being installed.  You can install it with `brew cask install aws-vault`."
  end

  test do
    assert_match("USAGE", shell_output("#{bin}/gds"))
  end
end
