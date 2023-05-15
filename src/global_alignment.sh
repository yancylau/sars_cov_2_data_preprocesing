# Multiple sequence alignment

# Ref
# https://github.com/roblanf/sarscov2phylo/blob/master/scripts/global_profile_alignment.sh
# https://github.com/biopython/biopython/issues/1521
# https://rdrr.io/bioc/DECIPHER/man/DistanceMatrix.html


MONTH=$1
IN_DIR=results/all/$MONTH
OUT_DIR=results/all/${MONTH}

N_THREADS=16


REF=refs/genome/NC_045512.2.fasta
cp $REF $OUT_DIR/NC_045512.2.fa

time mafft \
  --anysymbol \
  --thread $N_THREADS \
  --auto \
  --quiet \
  --keeplength \
  --distout \
  --addfragments \
  ${IN_DIR}/genome.fa \
  ${OUT_DIR}/NC_045512.2.fa \
  > ${OUT_DIR}/genome.new.aln.fa

# Distance between reference
paste -d , <(csvtk cut -f1 $OUT_DIR/metadata.csv) <(sed '/^Distance/d; /^$/d' $OUT_DIR/NC_045512.2.fa.hat2 | sed '1i distance_to_ref') > $OUT_DIR/distance_list.tsv

