class Identme < Formula
  desc "Public IP address lookup"
  homepage "https://www.ident.me"
  url "https://github.com/pcarrier/ident.me/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "1199360eb5561a00b275fda5a55c26091c78f4c2ae085f75e579eef202e4b2ed"
  license "0BSD"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "cmake" => :build
  uses_from_macos "curl"

  def install
    system "cmake", "-S", "cli", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_match(/Elapsed time:/, pipe_output(bin/"identme"))
  end
end
