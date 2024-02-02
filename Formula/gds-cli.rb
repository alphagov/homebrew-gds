class GdsCli < Formula
  desc "CLI for common commands used by Government Digital Service staff"
  homepage "https://github.com/alphagov/gds-cli"
  url "git@github.com:alphagov/gds-cli.git",
      using:    :git,
      tag:      "v5.88.0",
      revision: "ba345251c171702dc4e8a0a4dfa7c7a52f508c59"
  head "git@github.com:alphagov/gds-cli.git",
      using:  :git,
      branch: "main"

  depends_on "go" => :build
  depends_on "aws-vault" if OS.linux?
  depends_on "awscli"
  depends_on "ykman"

  def install
    ENV["GOOS"] = OS.mac? ? "darwin" : "linux"
    ENV["GOARCH"] = `uname -m`.strip == "x86_64" ? "amd64" : "arm64"

    system "make"

    bin.install "gds"
    bin.install_symlink("gds" => "gds-cli")

    # Completion for `gds`
    output = Utils.safe_popen_read("#{bin}/gds", "shell-completion", "bash")
    (bash_completion/"gds").write output
    output = Utils.safe_popen_read("#{bin}/gds", "shell-completion", "zsh")
    (zsh_completion/"_gds").write output

    # Completion for `gds-cli`
    output = Utils.safe_popen_read("#{bin}/gds-cli", "shell-completion", "bash")
    (bash_completion/"gds-cli").write output
    output = Utils.safe_popen_read("#{bin}/gds-cli", "shell-completion", "zsh")
    (zsh_completion/"_gds-cli").write output
  end

  def caveats
    return if OS.linux?

    "gds-cli depends on aws-vault being installed.  You can install it with `brew install --cask aws-vault`."
  end

  test do
    assert_match("USAGE", shell_output("#{bin}/gds"))
  end
end
