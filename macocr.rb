class Macocr < Formula
  include Language::Python::Virtualenv

  desc "macocr is a python script for OCR on macOS"
  homepage "https://github.com/rioriost/homebrew-macocr/"
  url "https://files.pythonhosted.org/packages/f0/c8/d551c799d776afafc9582d92f41d76e4436124c8ac6746dc67205583ee37/macocr-0.1.8.tar.gz"
  sha256 "c277c5e587616cc90a7074197a8eb0a57a623197f53d4d99ab65266e13c58754"
  license "MIT"

  depends_on "python@3.11"

  resource "click" do
    url "https://files.pythonhosted.org/packages/cd/0f/62ca20172d4f87d93cf89665fbaedcd560ac48b465bd1d92bfc7ea6b0a41/click-8.2.0.tar.gz"
    sha256 "f5452aeddd9988eefa20f90f05ab66f17fce1ee2a36907fd30b05bbb5953814d"
  end

  resource "ocrmac" do
    url "https://files.pythonhosted.org/packages/e5/f4/eef75cb750ff3e40240c8cbc713d68f8fc12b10eef016f7d4966eb05b065/ocrmac-1.0.0-py2.py3-none-any.whl"
    sha256 "0b5a072aa23a9ead48132cb2d595b680aa6c3c5a6cb69525155e35ca95610c3a"
  end

  resource "pyobjc-core" do
    url "https://files.pythonhosted.org/packages/ab/dc/6d63019133e39e2b299dfbab786e64997fff0f145c45a417e1dd51faaf3f/pyobjc_core-12.0.tar.gz"
    sha256 "7e05c805a776149a937b61b892a0459895d32d9002bedc95ce2be31ef1e37a29"
  end

  resource "pyobjc-framework-cocoa" do
    url "https://files.pythonhosted.org/packages/37/6f/89837da349fe7de6476c426f118096b147de923139556d98af1832c64b97/pyobjc_framework_cocoa-12.0.tar.gz"
    sha256 "02d69305b698015a20fcc8e1296e1528e413d8cf9fdcd590478d359386d76e8a"
  end

  resource "pyobjc-framework-coreml" do
    url "https://files.pythonhosted.org/packages/0c/a0/875b5174794c984df60944be54df0282945f8bae4a606fbafa0c6b717ddd/pyobjc_framework_coreml-12.0.tar.gz"
    sha256 "e1d7a9812886150881c86000fba885cb15201352c75fb286bd9e3a1819b5a4d5"
  end

  resource "pyobjc-framework-vision" do
    url "https://files.pythonhosted.org/packages/0f/5a/07cdead5adb77d0742b014fa742d503706754e3ad10e39760e67bb58b497/pyobjc_framework_vision-12.0.tar.gz"
    sha256 "942c9583f1d887ac9f704f3b0c21b3206b68e02852a87219db4309bb13a02f14"
  end

  resource "python-magic" do
    url "https://files.pythonhosted.org/packages/da/db/0b3e28ac047452d079d375ec6798bf76a036a08182dbb39ed38116a49130/python-magic-0.4.27.tar.gz"
    sha256 "c1ba14b08e4a5f5c31a302b7721239695b2f0f058d125bd5ce1ee36b9d9d3c3b"
  end

  def install
    virtualenv_install_with_resources
    system libexec/"bin/python", "-m", "pip", "install", "pillow", "pillow_heif", "pyobjc_framework_quartz"
  end

  test do
    system "#{bin}/macocr", "--help"
  end
end
