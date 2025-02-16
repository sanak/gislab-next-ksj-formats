#!/usr/bin/env bash

set -ex

SCRIPT_DIR=$(cd $(dirname $0); pwd)

cd $SCRIPT_DIR

ogr2ogr -f GeoJSON L01-24.geojson ./short-code-to-snake_case.vrt
ogr2ogr -f FlatGeobuf L01-24.fgb ./short-code-to-snake_case.vrt
ogr2ogr -f Parquet L01-24.parquet ./short-code-to-snake_case.vrt
ogr2ogr -f Arrow L01-24.arrow ./short-code-to-snake_case.vrt
ogr2ogr -f GPKG L01-24.gpkg ./short-code-to-snake_case.vrt

tippecanoe -o L01-24.pmtiles -f L01-24.fgb
