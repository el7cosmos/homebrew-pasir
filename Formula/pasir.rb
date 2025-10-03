class Pasir < Formula
  desc "PHP Application Server in Rust"
  homepage "https://github.com/el7cosmos/pasir"
  url "https://github.com/el7cosmos/pasir/archive/refs/tags/0.5.2.tar.gz"
  sha256 "0520f3a1a04764eae75d826d675736f3e488bb1685e9da7f447e343918ae7280"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://ghcr.io/v2/el7cosmos/pasir"
    sha256 cellar: :any, arm64_sequoia: "37704e3f2f59e5b857d4103e2b730e8e2ee11e277660d7ca0460300156f6a185"
    sha256 cellar: :any, arm64_sonoma:  "0d2f186b970aa871c4549bd5f03b486f75535e51fdea372e50c0342b1c3edda5"
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
