# gislab-next-ksj-formats

## 概要

[国土数値情報のファイル形式に関する意見募集](https://github.com/gislab-mlit/next-ksj-formats) での各データフォーマットの調査用の個人リポジトリです。

## 開発環境

macOS+Homebrew環境を想定しています。

```sh
brew install gdal tippecanoe wget
```

### オリジナル・サンプルデータの取得

```sh
cd data-tmp
bash download-original.sh
bash download-sample.sh
```

### 属性フィールドの持たせ方の調査

https://github.com/gislab-mlit/next-ksj-formats/issues/20

現状、地価公示データのみ調査中で、[data-tmp/field_names/field_names.xlsx](data-tmp/field_names/field_names.xlsx) でフィールド名を整理しています。

```sh
cd data-tmp/field_names/L01-24
bash convert-to-snake_case.sh
```

## ライセンス

* データ: CC BY 4.0
* データ以外のコンテンツ: MIT License
