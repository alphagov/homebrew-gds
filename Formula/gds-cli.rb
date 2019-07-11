class GdsCli < Formula
  desc "CLI for common commands used by Government Digital Service staff"
  homepage "https://github.com/alphagov/gds-cli"
  url "git@github.com:alphagov/gds-cli.git",
      :using    => :git,
      :tag      => "v1.11.0",
      :revision => "000b35cbb6d2a0e7d1393a105526c0afaa7f0eed"
  head "git@github.com:alphagov/gds-cli.git", :using => :git

  depends_on "go" => :build
  if OS.linux?
    depends_on "linuxbrew/extra/aws-vault"
  end

  def install
    ENV["GOOS"] = OS.mac? ? "darwin" : "linux"
    ENV["GOARCH"] = "amd64"

    system "go", "generate"
    system "go", "build"
    bin.install "gds-cli"
    bin.install_symlink({ "gds-cli" => "gds" })
  end

  def caveats
    if OS.mac?
      return 'gds-cli depends on aws-vault being installed.  You can install it with `brew cask install aws-vault`.'
    end
  end

  test do
    assert_match("USAGE", shell_output("#{bin}/gds"))
  end
end
