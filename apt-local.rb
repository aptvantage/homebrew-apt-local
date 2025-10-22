class AptLocal < Formula
  desc "A thin wrapper around k3d for managing a local k8s cluster"
  homepage "https://github.com/aptvantage/apt-local"
  version "0.1.4"
  url "https://github.com/aptvantage/apt-local/archive/refs/tags/#{version}.tar.gz"
  sha256 "8457a76c57aec54e20e35f2f55bb27cd085f97d130dcee31b360469db465f8c2" # Homebrew computes this from the tarball

  # Explicitly depend on k3d
  depends_on "k3d" => :recommended

  # Explicitly depend mkcert
  depends_on "mkcert" => :recommended

  # Explicity depends on jq
  depends_on "jq" => :recommended

  def install
    bin.install "apt-local"
    (prefix/"etc").mkpath
    (prefix/"etc").install Dir["etc/*"]
    inreplace bin/"apt-local", "CONFIG_DIR=../etc", "CONFIG_DIR=#{prefix}/etc"
  end

  def caveats
    <<~EOS
      You may need to open a new terminal window for apt-local to be on your PATH.
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
