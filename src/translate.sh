# Get CDS sequences, and translate to proteins


MONTH=$1
IN_DIR=results/all/$MONTH
OUT_DIR=results/all/$MONTH
mkdir -p $OUT_DIR/{cds,protein}

GENOME=${IN_DIR}/genome.aln.fa
GTF=refs/NC_045512.2.CDS.gtf


# CDS
cat $GTF | parallel -j 8 --colsep '\t' seqkit subseq -r {4}:{5} $GENOME -o $OUT_DIR/cds/{9}.aln.fa

# Merge cds
CDSs=$(cat $GTF | cut -f 9 | parallel echo $OUT_DIR/cds/{}.aln.fa | tr "\n" " ")
seqkit concat $CDSs > $OUT_DIR/cds/all.aln.fa
seqkit concat $CDSs | seqkit seq -g > $OUT_DIR/cds/all.fa

seqkit fx2tab $OUT_DIR/cds/all.aln.fa | cut -f 1-2 > $OUT_DIR/cds/all.aln.tsv

# Remove gaps
cat $GTF |  parallel -j 8 --colsep '\t' seqkit seq -g $OUT_DIR/cds/{9}.aln.fa -o $OUT_DIR/cds/{9}.fa

# Protein
cat $GTF | parallel -j 8 --colsep '\t' seqkit translate $OUT_DIR/cds/{9}.fa -o $OUT_DIR/protein/{9}.fa
