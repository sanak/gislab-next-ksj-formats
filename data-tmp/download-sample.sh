#!/usr/bin/env bash

set -ex

SCRIPT_DIR=$(cd $(dirname $0); pwd)
BASE_DIR=$SCRIPT_DIR/sample

cd $BASE_DIR

EXTENSIONS=("geojson" "fgb" "parquet" "arrow" "pmtiles" "gpkg")

################################################################################
# L01-24_地価公示データ_2024年(令和6年)版 （ポイント）
L01_DIR=L01-24
L01_FNAME=L01-24
mkdir -p $L01_DIR
for ext in ${EXTENSIONS[@]}; do
  if [ ! -e $L01_DIR/$L01_FNAME.$ext ]; then
    wget https://public-data.geolonia.com/mlit-ksj-vector-2024/sample-data/$L01_DIR/$L01_FNAME.$ext -O $L01_DIR/$L01_FNAME.$ext
  fi
done

################################################################################
# N03-20240101_行政区域データ_2024年(令和6年)版 （ポリゴン）
N03_DIR=N03-20240101
N03_FNAME=N03-20240101
mkdir -p $N03_DIR
for ext in ${EXTENSIONS[@]}; do
  if [ ! -e $N03_DIR/$N03_FNAME.$ext ]; then
    wget https://public-data.geolonia.com/mlit-ksj-vector-2024/sample-data/$N03_DIR/$N03_FNAME.$ext -O $N03_DIR/$N03_FNAME.$ext
  fi
done

################################################################################
# W05_河川データ_2009年度～2006年度(平成21年度～平成18年度) （ライン）
W05_DIR=W05
W05_FNAME=W05-Stream
mkdir -p $W05_DIR
for ext in ${EXTENSIONS[@]}; do
  if [ ! -e $W05_DIR/$W05_FNAME.$ext ]; then
    wget https://public-data.geolonia.com/mlit-ksj-vector-2024/sample-data/$W05_DIR/$W05_FNAME.$ext -O $W05_DIR/$W05_FNAME.$ext
  fi
done

cd $SCRIPT_DIR
