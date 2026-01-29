class GdsCli < Formula
  desc "CLI for common commands used by Government Digital Service staff"
  homepage "https://github.com/alphagov/gds-cli"
  url "git@github.com:alphagov/gds-cli.git",
      using:    :git,
      tag:      "v5.147.0",
      revision: "9c00538d55a59f1227763125b8d54d5825d5a84d"
  head "git@github.com:alphagov/gds-cli.git",
      using:  :git,
      branch: "main"

  depends_on "go" => :build
  depends_on "aws-vault"
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

  test do
    assert_match("USAGE", shell_output("#{bin}/gds"))
  end
end
