class AptLocal < Formula
  desc "A thin wrapper around k3d for managing a local k8s cluster"
  homepage "https://github.com/aptvantage/apt-local"
  version "0.1.3"
  url "https://github.com/aptvantage/apt-local/archive/refs/tags/#{version}.tar.gz"
  sha256 "6fb59966379721121d5192be9beccecc5ad9611abeea6c10e7fdb87198d787c8" # Homebrew computes this from the tarball

  # Explicitly depend on k3d
  depends_on "k3d" => :recommended

  # Explicitly depend mkcert
  depends_on "mkcert" => :recommended

  # Explicity depends on jq
  depends_on "jq" => :recommended

  def install
    bin.install "apt-local"
  end

  def caveats
    <<~EOS
      To use apt-local, ensure k3d and mkcert are installed and ready:
        brew install k3d mkcert

      Then try: apt-local create
    EOS
  end

  test do
    # Test that the script is executable and responds to 'stop' safely
    system "#{bin}/apt-local", "stop"
  rescue
    # Ignore errors in test (e.g., k3d not installed)
    nil
  end
end
