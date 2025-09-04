class Pasir < Formula
  desc "PHP Application Server in Rust"
  homepage "https://github.com/el7cosmos/pasir"
  url "https://github.com/el7cosmos/pasir/archive/refs/tags/0.2.0.tar.gz"
  sha256 "d856e61896fe8e0a0689811dd885f45b38bc605e4c1e35a85949f0a576e73c1d"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://ghcr.io/v2/el7cosmos/pasir"
    sha256 cellar: :any, arm64_sequoia: "e9ccfb622664d0fb1e4a838dd6e5e98ff19e2dafa4959edf84e36dc53342bd70"
    sha256 cellar: :any, ventura:       "d4b775a82f1b0c6c669a7ac1044c79526e4db488ce8310f66af7db614fb8cca2"
  end

  depends_on "rust" => :build

  depends_on "shivammathur/php/php-zts"

  def install
    php_config = "#{Formula["shivammathur/php/php-zts"].opt_bin}/php-config"

    ENV["PHP"] = "#{Formula["shivammathur/php/php-zts"].opt_bin}/php"
    ENV["PHP_CONFIG"] = php_config.to_s
    ENV["LIBRARY_PATH"] = `#{php_config} --lib-dir`.strip!
    ENV["PASIR_VERSION"] = "0.1.0"

    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"pasir", "--version"
  end
end
