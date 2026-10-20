class Ssmtun < Formula
  desc "Supervised AWS SSM port-forwarding tunnels to RDS and friends"
  homepage "https://github.com/ak-inori/ssmtun"
  url "https://github.com/ak-inori/ssmtun/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "02c7464050bd2795cf51b6856c0396b0af30d89940e4b4d03a3b66f3c73375fd"
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
