class Pasir < Formula
  desc "PHP Application Server in Rust"
  homepage "https://github.com/el7cosmos/pasir"
  url "https://github.com/el7cosmos/pasir/archive/refs/tags/0.5.4.tar.gz"
  sha256 "ce7160f0afd8740f268f1107c70986b27a029ea543773c8057d00241835143f4"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://ghcr.io/v2/el7cosmos/pasir"
    sha256 cellar: :any, arm64_sequoia: "9b5a339a5f9246ae4fc461a14b9f1957eadde699188704136a88c808be5bdbb0"
    sha256 cellar: :any, arm64_sonoma:  "475d34d8fb589d09f12cc7c8572f820af2c1c98193337b521af257c7b82c4dfa"
  end

  depends_on "rust" => :build

  depends_on "shivammathur/php/php-zts"

  def install
    php_config = "#{Formula["shivammathur/php/php-zts"].opt_bin}/php-config"

    ENV["PHP"] = "#{Formula["shivammathur/php/php-zts"].opt_bin}/php"
    ENV["PHP_CONFIG"] = php_config.to_s
    ENV["LIBRARY_PATH"] = `#{php_config} --lib-dir`.strip!

    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"pasir", "--version"
  end
end
