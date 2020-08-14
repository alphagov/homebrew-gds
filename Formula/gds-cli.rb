class GdsCli < Formula
  desc "CLI for common commands used by Government Digital Service staff"
  homepage "https://github.com/alphagov/gds-cli"
  url "git@github.com:alphagov/gds-cli.git",
      :using    => :git,
      :tag      => "v2.19.0",
      :revision => "8e27288a0326451ae18030af7a8ef317080c54e2"
  head "git@github.com:alphagov/gds-cli.git", :using => :git

  depends_on "go" => :build
  depends_on "aws-vault" if OS.linux?
  depends_on "awscli"

  def install
    ENV["GOOS"] = OS.mac? ? "darwin" : "linux"
    ENV["GOARCH"] = "amd64"

    system "make"

    bin.install "gds"
    bin.install_symlink("gds" => "gds-cli")

    output = Utils.safe_popen_read("#{bin}/gds-cli bash-completion")
    (bash_completion/"gds-cli").write output
    (bash_completion/"gds").write output

    output = Utils.safe_popen_read("#{bin}/gds-cli zsh-completion")
    (zsh_completion/"_gds-cli").write output
    (zsh_completion/"_gds").write output
  end

  def caveats
    return if OS.linux?

    "gds-cli depends on aws-vault being installed.  You can install it with `brew cask install aws-vault`."
  end

  test do
    assert_match("USAGE", shell_output("#{bin}/gds"))
  end
end
