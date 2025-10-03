class Pasir < Formula
  desc "PHP Application Server in Rust"
  homepage "https://github.com/el7cosmos/pasir"
  url "https://github.com/el7cosmos/pasir/archive/refs/tags/0.5.2.tar.gz"
  sha256 "0520f3a1a04764eae75d826d675736f3e488bb1685e9da7f447e343918ae7280"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://ghcr.io/v2/el7cosmos/pasir"
    sha256 cellar: :any, arm64_sequoia: "08cda3dc09bb93b7b4a47540eabe636238973719a78f68f8d432ba7490cd21f5"
    sha256 cellar: :any, arm64_sonoma:  "b1064c34b1aa0a4950089b8e27710d3e6066f40750fd2e86d63607b5b2c146f6"
  end

  depends_on "rust" => :build

  depends_on "shivammathur/php/php-zts"

  def install
    php_config = "#{Formula["shivammathur/php/php-zts"].opt_bin}/php-config"

    ENV["PHP"] = "#{Formula["shivammathur/php/php-zts"].opt_bin}/php"
    ENV["PHP_CONFIG"] = php_config.to_s
    ENV["LIBRARY_PATH"] = `#{php_config} --lib-dir`.strip!
    ENV["PASIR_VERSION"] = "0.3.1"

    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"pasir", "--version"
  end
end
