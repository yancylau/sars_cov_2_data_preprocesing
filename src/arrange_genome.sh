

MONTH=$1
WD=results/all
mkdir -p $WD/arrange

# Run BLAST to get sequence identity
N_THREADS=8
BLAST_DB=refs/genome/NC_045512.2
blastn \
  -db $BLAST_DB \
  -query $WD/clean_data/${MONTH}.fa \
  -num_threads $N_THREADS \
  -outfmt '6 std qseq sseq' \
  -max_hsps 1 \
  -subject_besthit \
  > $WD/arrange/${MONTH}.fmt6

# Extract idnenty for blast results
cat $WD/arrange/${MONTH}.fmt6 | cut -f1-12 | csvtk tab2csv | csvtk uniq -f 1 | csvtk cut -f 1,3 | csvtk add-header -n "id,identity" | csvtk sort -k 2:nr > $WD/arrange/${MONTH}.identity.tsv
