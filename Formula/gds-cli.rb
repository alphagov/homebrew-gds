class GdsCli < Formula
  desc "CLI for common commands used by Government Digital Service staff"
  homepage "https://github.com/alphagov/gds-cli"
  url "git@github.com:alphagov/gds-cli.git",
      using:    :git,
      tag:      "v5.5.0",
      revision: "8d0f88cb286ce3003458503e376b2f9ff4029b44"
  head "git@github.com:alphagov/gds-cli.git",
      using:  :git,
      branch: "main"

  depends_on "go" => :build
  depends_on "aws-vault" if OS.linux?
  depends_on "awscli"
  depends_on "ykman"

  def install
    ENV["GOOS"] = OS.mac? ? "darwin" : "linux"
    ENV["GOARCH"] = "amd64"

    system "make"

    bin.install "gds"
    bin.install_symlink("gds" => "gds-cli")

    output = Utils.safe_popen_read("#{bin}/gds-cli", "bash-completion")
    (bash_completion/"gds-cli").write output
    (bash_completion/"gds").write output

    output = Utils.safe_popen_read("#{bin}/gds-cli", "zsh-completion")
    (zsh_completion/"_gds-cli").write output
    (zsh_completion/"_gds").write output
  end

  def caveats
    return if OS.linux?

    "gds-cli depends on aws-vault being installed.  You can install it with `brew install --cask aws-vault`."
  end

  test do
    assert_match("USAGE", shell_output("#{bin}/gds"))
  end
end
