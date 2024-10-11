class Texttest < Formula
  include Language::Python::Virtualenv

  desc "Tool for text-based Approval Testing"
  homepage "https://www.texttest.org/"
  url "https://files.pythonhosted.org/packages/78/ad/26a9b4447d1a6692119b2600606f813755bb44eca72640c95cbad92ecf2a/TextTest-4.4.0.1.tar.gz"
  sha256 "f80ba8a65d048de52a038f3d125a5f47cb5b629e50a7a7f358cff404a8838fa8"
  license "LGPL-2.1-or-later"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "ec803d226e75ee7645794e66076882e92a992b8d1a506b86b1e295966e90375c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "ae3a79098c5ee58b1cb655e7b2295edd208201c21683ccbbe5f759ede6feb19e"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "cf446711e2a3519c3e8d80c044a65e569e656f81db55454f5add3f9808c2c764"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "71fdef508725b2daec109bf60c342dc4f4d2d5f5dbab07da0f18ed5c4f9da580"
    sha256 cellar: :any_skip_relocation, sonoma:         "8a7b0e5bb949d8d82148d5b6488bcfc5d936ef5c184d6b298aa97cb7cad94df4"
    sha256 cellar: :any_skip_relocation, ventura:        "6e4c642521fd8bcb1a1f9bfd6443db1e34f76a6a14c2fabc2ba8d911a00343e3"
    sha256 cellar: :any_skip_relocation, monterey:       "a1826bcdea50ad49534c149df8f516874a2aee2d8441e10478413521e2e95165"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "65185cb0ea5cc2599c779abec776178b829b78a80d83baaffc8d60ccda25ab67"
  end

  depends_on "adwaita-icon-theme"
  depends_on "gtk+3"
  depends_on "pygobject3"
  depends_on "python@3.12"

  resource "psutil" do
    url "https://files.pythonhosted.org/packages/18/c7/8c6872f7372eb6a6b2e4708b88419fb46b857f7a2e1892966b851cc79fc9/psutil-6.0.0.tar.gz"
    sha256 "8faae4f310b6d969fa26ca0545338b21f73c6b15db7c4a8d934a5482faa818f2"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    (testpath/"testsuite.test").write <<~EOS
      Test1
    EOS

    (testpath/"config.test").write <<~EOS
      executable:/bin/echo
      filename_convention_scheme:standard
    EOS

    (testpath/"Test1/options.test").write <<~EOS
      Success!
    EOS

    (testpath/"Test1/stdout.test").write <<~EOS
      Success!
    EOS

    File.write(testpath/"Test1/stderr.test", "")

    output = shell_output("#{bin}/texttest -d #{testpath} -b -a test")
    assert_match "S: TEST test-case Test1 succeeded", output
  end
end
