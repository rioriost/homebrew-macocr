# macocr

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Python](https://img.shields.io/badge/Python-3.11%2B-blue)

## Overview

macocr is a python script for OCR on macOS

## Table of Contents

- [Installation](#installation)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Release Notes](#release-notes)
- [License](#license)

## Installation

Just add tap and install homebrew package.

```bash
brew tap rioriost/macocr
brew install macocr
```

## Prerequisites

- Python 3.11 or higher

## Usage

Execute macocr command.

```bash
macocr --help
usage: macocr [-h] image_dir output_dir

positional arguments:
  image_dir   Directory containing images to OCR
  output_dir  Directory to output OCR results

options:
  -h, --help  show this help message and exit
```

The indentical usage is shown below.

```bash
macocr images results
Processing /Users/rifujita/ownCloud/bin/macocr/images/img_horz01.png
Processing /Users/rifujita/ownCloud/bin/macocr/images/img_vert02.HEIC
Processing /Users/rifujita/ownCloud/bin/macocr/images/img_vert01.png
```

results

```bash
cat results/*
日本国内の交差点は約100万あるとされている
ので、そこに接続しているエッジは  T字路で 3
本、2本の道路が交差していれば4本、さらに五
叉路や側道があるパターンでは、1 つのノードに
20 ぐらいのエッジが接続しているパターンも実
在します。
航空路線に例えると、ハブ空港が日本国内だけ
で約100万あり、エッジがその10倍・約1,000万
存在する、みたいなものです*3。そしてその巨大
なネットワーク内で乗り継ぎを数十回、数百回す
るというのが、私たちが日常行っている、自動車
の運転を含めた地上での移動です。
道路ネットワークよりもさらに大規模なネット
ワークとしては、SNS やウェブのリンクなども
考えられます。PostgreSQL に航空路線のデータを格納する例を考えてみましょう。現在世界には約三千五百の空港があり、それらの空港を結ぶ航空路線
は数万に及びますが、羽田空港からシアトルタコマ空港への直行便は、航空会社の別を考慮しなければ一路線しかありません。条件は「羽田発
シアトルタコマ着」のみです。
しかし乗り継ぎを考慮すると、羽田からシアトルタコマへの経路は複数通り存在します。クエリの条件は「羽田発・空港（A）着」「空港（A）発シ
アトルタコマ着」です。さらに乗り継ぎが二回になると、「羽田発・空港（A）着」「空港（A）発-空港（B）着」「空港（B）着・シアトルタコマ着」とな
り、経路のパターンが増えることが分かります。空港（ノード）の数より、路線（エッジ）の数がかなり多くなるのはこういう理由です。
航空路線の場合、乗り継ぎ回数がそれほど増えることはないので、クエリもあまり難しくなるとは考えにくく、SQL で十分対応できるでしょ
う。•この薬はあなたの症状に合わせ処方したものです。他の人には譲らないでください。
•お薬は指示どおりにお飲みください。自己判断で服用量や回数を加減しないでください。
•お薬はお子様の手の届かない場所に置いてください。
•この薬以外に他の医療機関の薬又は市販薬を服用している方は、医師又は薬剤師に申し
出てください。
口食前とは食事前30分位、食後とは食後30分位に服用することです。
口食間とは食後2時間位に服用することです。
口（糖尿病の方を除き）食事のとれない方でも食事をする時と同じ時間に服用してください。
口時間ごとに定められた薬は食事に関係なく服用してください。
```

## Release Notes

### 0.1.1 Release
* Dependency updates

### 0.1.0 Release
* Initial release.

## License
MIT License
