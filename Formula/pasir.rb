class Pasir < Formula
  desc "PHP Application Server in Rust"
  homepage "https://github.com/el7cosmos/pasir"
  url "https://github.com/el7cosmos/pasir/archive/refs/tags/0.3.1.tar.gz"
  sha256 "7f412cd021530b717a8b286111a70177e5176caf7ba3d289cebc69be9f765d51"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://ghcr.io/v2/el7cosmos/pasir"
    sha256 cellar: :any, arm64_sequoia: "c08cc3381c1fb3ce9c1b759913873cae66588659b6cef9b2bc0d9d558c356d98"
    sha256 cellar: :any, ventura:       "3e068ad53b4c7cde704ea201fe0b69017a403f7c5ec8748259b159f95129ca5f"
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
