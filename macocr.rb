class Macocr < Formula
  include Language::Python::Virtualenv

  desc "macocr is a python script for OCR on macOS"
  homepage "https://github.com/rioriost/homebrew-macocr/"
  url "https://files.pythonhosted.org/packages/c3/a8/a09cf9ad00cfa686c72c5f9ea3f4f76a7e4c7f65f5e5cb7d1ea411a6dc85/macocr-0.1.3.tar.gz"
  sha256 "5cf2ee99f822afcca816f36839b6344741900949ff8dbc8505e078d98903bab2"
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
    url "https://files.pythonhosted.org/packages/e8/e9/0b85c81e2b441267bca707b5d89f56c2f02578ef8f3eafddf0e0c0b8848c/pyobjc_core-11.1.tar.gz"
    sha256 "b63d4d90c5df7e762f34739b39cc55bc63dbcf9fb2fb3f2671e528488c7a87fe"
  end

  resource "pyobjc-framework-cocoa" do
    url "https://files.pythonhosted.org/packages/4b/c5/7a866d24bc026f79239b74d05e2cf3088b03263da66d53d1b4cf5207f5ae/pyobjc_framework_cocoa-11.1.tar.gz"
    sha256 "87df76b9b73e7ca699a828ff112564b59251bb9bbe72e610e670a4dc9940d038"
  end

  resource "pyobjc-framework-coreml" do
    url "https://files.pythonhosted.org/packages/0d/5d/4309f220981d769b1a2f0dcb2c5c104490d31389a8ebea67e5595ce1cb74/pyobjc_framework_coreml-11.1.tar.gz"
    sha256 "775923eefb9eac2e389c0821b10564372de8057cea89f1ea1cdaf04996c970a7"
  end

  resource "pyobjc-framework-vision" do
    url "https://files.pythonhosted.org/packages/40/a8/7128da4d0a0103cabe58910a7233e2f98d18c590b1d36d4b3efaaedba6b9/pyobjc_framework_vision-11.1.tar.gz"
    sha256 "26590512ee7758da3056499062a344b8a351b178be66d4b719327884dde4216b"
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
