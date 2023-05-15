#!/bin/bash

# Determine lineages of variants with PANGO
# Ref: cov-lineages.org
# Usage: src/pangolin.sh <in_file> <out_file>

# Note: Update pango_data to the latest one before running !!


N_THREADS=4

FA=$1
OUT_DIR=$(dirname $FA)
OUT_FILE=$(basename $FA .fa)
mkdir -p $OUT_DIR

time \
pangolin \
  $FA \
  -t $N_THREADS \
  --outdir $OUT_DIR \
  --outfile ${OUT_FILE}.lineage.csv \
  --expanded-lineage

