class GdsCli < Formula
  desc "CLI for common commands used by Government Digital Service staff"
  homepage "https://github.com/alphagov/gds-cli"
  url "git@github.com:alphagov/gds-cli.git",
      :using    => :git,
      :tag      => "v1.9.0",
      :revision => "126f7aeb79200517d2d0647ed938cfd3711089ed"
  head "git@github.com:alphagov/gds-cli.git", :using => :git

  depends_on "go" => :build
  tap_name = OS.mac? ? "homebrew/cask" : "linuxbrew/extra"
  depends_on "#{tap_name}/aws-vault"

  def install
    ENV["GOOS"] = OS.mac? ? "darwin" : "linux"
    ENV["GOARCH"] = "amd64"

    system "go", "generate"
    system "go", "build"
    bin.install "gds-cli"
  end

  test do
    assert_match("USAGE", shell_output("#{bin}/gds-cli"))
  end
end
