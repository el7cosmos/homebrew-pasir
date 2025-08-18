class Pasir < Formula
  desc "PHP Application Server in Rust"
  homepage "https://github.com/el7cosmos/pasir"
  url "https://github.com/el7cosmos/pasir/archive/refs/tags/0.1.0.tar.gz"
  sha256 "01e28fde4727d2cd2d9af9be2fea1397fe5e4918a0db20842cfacdf5e2d7ea71"
  license "GPL-3.0-or-later"

  depends_on "rust" => :build

  depends_on "shivammathur/php/php-zts"

  # Additional dependency
  # resource "" do
  #   url ""
  #   sha256 ""
  # end

  def install
    php_config = "#{Formula["shivammathur/php/php-zts"].opt_bin}/php-config"

    ENV["PHP"] = "#{Formula["shivammathur/php/php-zts"].opt_bin}/php"
    ENV["PHP_CONFIG"] = "#{php_config}"
    ENV["LIBRARY_PATH"] = `#{php_config} --lib-dir`.strip!

    system "cargo", "install", *std_cargo_args
  end

  test do
    system "#{bin}/pasir", "--version"
  end
end
