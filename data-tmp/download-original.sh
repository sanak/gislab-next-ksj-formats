#!/usr/bin/env bash

set -ex

SCRIPT_DIR=$(cd $(dirname $0); pwd)
BASE_DIR=$SCRIPT_DIR/original

cd $BASE_DIR

################################################################################
# L01-24_地価公示データ_2024年(令和6年)版 （ポイント）
# 国土数値情報ダウンロードサイト「地価公示データ」
# https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-L01-2024.html
L01_FNAME=L01-24_GML
L01_DIR=L01-24
if [ ! -e $L01_FNAME.zip ]; then
  wget https://nlftp.mlit.go.jp/ksj/gml/data/L01/L01-24/$L01_FNAME.zip
fi
if [ ! -d $L01_DIR ]; then
  unzip -j $L01_FNAME.zip -d $L01_DIR
fi

################################################################################
# N03-20240101_行政区域データ_2024年(令和6年)版 （ポリゴン）
# 国土数値情報ダウンロードサイト「行政区域データ」
# https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-N03-2024.html
N03_FNAME=N03-20240101_GML
N03_DIR=N03-20240101
if [ ! -e $N03_FNAME.zip ]; then
  wget https://nlftp.mlit.go.jp/ksj/gml/data/N03/N03-2024/$N03_FNAME.zip
fi
if [ ! -d $N03_DIR ]; then
  unzip $N03_FNAME.zip -d $N03_DIR
fi

################################################################################
# W05_河川データ_2009年度～2006年度(平成21年度～平成18年度) （ライン）
# 国土数値情報ダウンロードサイト「河川データ」
# https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-W05.html
W05_DIR=W05
W05_YEAR_PREFS=(
  "09_01" "07_02" "07_03" "07_04" "07_05" "07_06" "07_07"
  "08_08" "08_09" "08_10" "08_11" "08_12" "08_13" "08_14"
  "07_15" "07_16" "07_17" "07_18" "08_19" "08_20" "08_21"
  "08_22" "08_23" "08_24" "09_25" "09_26" "09_27" "09_28"
  "09_29" "09_30" "08_31" "08_32" "08_33" "08_34" "08_35"
  "06_36" "06_37" "06_38" "06_39" "07_40" "07_41" "07_42"
  "07_43" "07_44" "07_45" "07_46" "07_47"
)
W05_OUT_FNAME=W05-Stream.shp
mkdir -p $W05_DIR
cd $W05_DIR
mkdir -p zip
mkdir -p shp
for year_pref in ${W05_YEAR_PREFS[@]} ; do
  year=${year_pref:0:2}
  no=${year_pref:2:2}
  w05_fname=W05-$year_pref
  if [ ! -e "zip/$w05_fname.zip" ]; then
    wget https://nlftp.mlit.go.jp/ksj/gml/data/W05/W05-$year/${w05_fname}_GML.zip -O zip/$w05_fname.zip
  fi
  unzip -jo zip/$w05_fname.zip -d shp/$w05_fname
  append_option=""
  if [ "$no" != "01" ]; then
    append_option="-update -append"
  fi
  ogr2ogr -f "ESRI Shapefile" \
    -lco ENCODING=CP932 \
    -oo ENCODING=CP932 \
    $append_option \
    $W05_OUT_FNAME \
    "shp/$w05_fname/$w05_fname-g_Stream.shp"
done
rm -rf shp

cd $SCRIPT_DIR
