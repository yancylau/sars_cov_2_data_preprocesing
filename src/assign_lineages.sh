# usage:
# Total thereads =  4 * 4 = 16


MONTH=$1
IN_DIR=results/all/${MONTH}
OUT_DIR=results/all/${MONTH}
mkdir -p $OUT_DIR
mkdir -p tmp/splited/${MONTH}

# 1. Split large file into smaller pieces
FA=$IN_DIR/genome.fa
seqkit split $FA -f -s 1000 -O tmp/splited/${MONTH}


# 2. Assign lineages
ls -1 tmp/splited/${MONTH}/genome.part_*.fa | parallel -j 12 src/pangolin.sh {}

cat tmp/splited/${MONTH}/genome.part_*.lineage.csv | grep "taxon" | head -1 | sed 's/taxon/virus_id/g' > $OUT_DIR/lineages.csv
cat tmp/splited/${MONTH}/genome.part_*.lineage.csv | grep -v "taxon" >> $OUT_DIR/lineages.csv


# 3. update metadata
csvtk join -f "virus_id" $OUT_DIR/genome.csv $OUT_DIR/lineages.csv > $OUT_DIR/metadata.csv

