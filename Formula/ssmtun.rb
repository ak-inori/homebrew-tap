class Ssmtun < Formula
  desc "Supervised AWS SSM port-forwarding tunnels to RDS and friends"
  homepage "https://github.com/ak-inori/ssmtun"
  url "https://github.com/ak-inori/ssmtun/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "8a9f4734bafd64c18876939ae965d60eec4b426ccf2c674972504a307f0a78f7"
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
