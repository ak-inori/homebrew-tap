class Ssmtun < Formula
  desc "Supervised AWS SSM port-forwarding tunnels to RDS and friends"
  homepage "https://github.com/ak-inori/ssmtun"
  url "https://github.com/ak-inori/ssmtun/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "e2b37f722caba27c591e6654d8797c935a0d226eed3491af8925701d9f72138e"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/ak-inori/ssmtun/internal/cli.Version=#{version}"
    system "go", "build", *std_go_args(ldflags:), "./cmd/ssmtun"
    generate_completions_from_executable(bin/"ssmtun", "completion")
  end

  def caveats
    <<~EOS
      ssmtun drives the AWS Session Manager plugin, which Homebrew ships as a cask:
        brew install --cask session-manager-plugin
      Then run `ssmtun doctor`.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ssmtun --version")
  end
end
