class GdsCli < Formula
  desc "CLI for common commands used by Government Digital Service staff"
  homepage "https://github.com/alphagov/gds-cli"
  url "git@github.com:alphagov/gds-cli",
      :using    => :git,
      :tag      => "v1.5.0",
      :revision => "1c1511ea1eecbd0d9d1f9aa51f98f602c272a6fd"

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
