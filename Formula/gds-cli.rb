class GdsCli < Formula
  desc "CLI for common commands used by Government Digital Service staff"
  homepage "https://github.com/alphagov/gds-cli"
  url "git@github.com:alphagov/gds-cli.git",
      :using    => :git,
      :tag      => "v1.7.0",
      :revision => "b4aee3574cecc2cd7fa2b546e038765eb474defa"
  head "git@github.com:alphagov/gds-cli.git", :using => :git

  depends_on "go" => :build

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
