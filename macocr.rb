class Macocr < Formula
  include Language::Python::Virtualenv

  desc "macocr is a python script for OCR on macOS"
  homepage "https://github.com/rioriost/homebrew-macocr/"
  url "https://files.pythonhosted.org/packages/c4/a4/3aa2b473a0a358389c44c87423b2a7f2e8d11684d02cdbb3ce30d6b70381/macocr-0.1.11.tar.gz"
  sha256 "57247526bc4483a9721cfe1b85cce6f2765a0c51d9d883a153ef483d9812870c"
  license "MIT"

  depends_on "python@3.11"

  resource "click" do
    url "https://files.pythonhosted.org/packages/3d/fa/656b739db8587d7b5dfa22e22ed02566950fbfbcdc20311993483657a5c0/click-8.3.1.tar.gz"
    sha256 "12ff4785d337a1bb490bb7e9c2b1ee5da3112e94a8622f26a6c77f5d2fc6842a"
  end

  resource "ocrmac" do
    url "https://files.pythonhosted.org/packages/37/15/7cc16507a2aca927abe395f1c545f17ae76b1f8ed44f43ebe4e8670ee203/ocrmac-1.0.1-py3-none-any.whl"
    sha256 "1cef25426f7ae6bbd57fe3dc5553b25461ae8ad0d2b428a9bbadbf5907349024"
  end

  resource "pyobjc-core" do
    url "https://files.pythonhosted.org/packages/b8/b6/d5612eb40be4fd5ef88c259339e6313f46ba67577a95d86c3470b951fce0/pyobjc_core-12.1.tar.gz"
    sha256 "2bb3903f5387f72422145e1466b3ac3f7f0ef2e9960afa9bcd8961c5cbf8bd21"
  end

  resource "pyobjc-framework-cocoa" do
    url "https://files.pythonhosted.org/packages/02/a3/16ca9a15e77c061a9250afbae2eae26f2e1579eb8ca9462ae2d2c71e1169/pyobjc_framework_cocoa-12.1.tar.gz"
    sha256 "5556c87db95711b985d5efdaaf01c917ddd41d148b1e52a0c66b1a2e2c5c1640"
  end

  resource "pyobjc-framework-coreml" do
    url "https://files.pythonhosted.org/packages/30/2d/baa9ea02cbb1c200683cb7273b69b4bee5070e86f2060b77e6a27c2a9d7e/pyobjc_framework_coreml-12.1.tar.gz"
    sha256 "0d1a4216891a18775c9e0170d908714c18e4f53f9dc79fb0f5263b2aa81609ba"
  end

  resource "pyobjc-framework-vision" do
    url "https://files.pythonhosted.org/packages/c2/5a/08bb3e278f870443d226c141af14205ff41c0274da1e053b72b11dfc9fb2/pyobjc_framework_vision-12.1.tar.gz"
    sha256 "a30959100e85dcede3a786c544e621ad6eb65ff6abf85721f805822b8c5fe9b0"
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
