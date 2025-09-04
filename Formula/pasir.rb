class Pasir < Formula
  desc "PHP Application Server in Rust"
  homepage "https://github.com/el7cosmos/pasir"
  url "https://github.com/el7cosmos/pasir/archive/refs/tags/0.2.0.tar.gz"
  sha256 "d3792398a939bc4ad68eb8a69ac98282505af453564f40d2c53107864a565539"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://ghcr.io/v2/el7cosmos/pasir"
    sha256 cellar: :any, arm64_sequoia: "de75013a85366d205f6b5a3f7850271070011490f0a6f0d26d6b4764e7fe6e57"
    sha256 cellar: :any, ventura:       "9956da06bb66283c7fb95e75792f26453d9ca4ff1e59ddd4f4d036d04dfecba5"
  end

  depends_on "rust" => :build

  depends_on "shivammathur/php/php-zts"

  def install
    php_config = "#{Formula["shivammathur/php/php-zts"].opt_bin}/php-config"

    ENV["PHP"] = "#{Formula["shivammathur/php/php-zts"].opt_bin}/php"
    ENV["PHP_CONFIG"] = php_config.to_s
    ENV["LIBRARY_PATH"] = `#{php_config} --lib-dir`.strip!
    ENV["PASIR_VERSION"] = "0.2.0"

    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"pasir", "--version"
  end
end
