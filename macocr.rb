class Macocr < Formula
  include Language::Python::Virtualenv

  desc "macocr is a python script for OCR on macOS"
  homepage "https://github.com/rioriost/homebrew-macocr/"
  url "https://files.pythonhosted.org/packages/dc/a6/053eb392f94f1a34bdbf71052b08237001d169be53e5feebc47ab05b2b70/macocr-0.1.2.tar.gz"
  sha256 "8fb0c556054842ce62c2c5da8a697687560e45c4ece9d4f247173c837d2ddf8d"
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
    url "https://files.pythonhosted.org/packages/5c/94/a111239b98260869780a5767e5d74bfd3a8c13a40457f479c28dcd91f89d/pyobjc_core-11.0.tar.gz"
    sha256 "63bced211cb8a8fb5c8ff46473603da30e51112861bd02c438fbbbc8578d9a70"
  end

  resource "pyobjc-framework-cocoa" do
    url "https://files.pythonhosted.org/packages/c5/32/53809096ad5fc3e7a2c5ddea642590a5f2cb5b81d0ad6ea67fdb2263d9f9/pyobjc_framework_cocoa-11.0.tar.gz"
    sha256 "00346a8cb81ad7b017b32ff7bf596000f9faa905807b1bd234644ebd47f692c5"
  end

  resource "pyobjc-framework-coreml" do
    url "https://files.pythonhosted.org/packages/2e/64/4f0a990ec0955fe9b88f1fa58303c8471c551996670216527b4ac559ed8f/pyobjc_framework_coreml-11.0.tar.gz"
    sha256 "143a1f73a0ea0a0ea103f3175cb87a61bbcb98f70f85320ed4c61302b9156d58"
  end

  resource "pyobjc-framework-vision" do
    url "https://files.pythonhosted.org/packages/ef/53/dc2e0562a177af9306efceb84bc21f5cf7470acaa8f28f64e62bf828b7e1/pyobjc_framework_vision-11.0.tar.gz"
    sha256 "45342e5253c306dbcd056a68bff04ffbfa00e9ac300a02aabf2e81053b771e39"
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
