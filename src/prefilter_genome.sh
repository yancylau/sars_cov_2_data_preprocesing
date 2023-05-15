# Remove low quality genomes ( ~1 h )

# a. recommend ids
# b. length range: 29000 ~ 31000
# c. Remove sequence with N < 1500
# d. remove duplicates


MONTH=$1
IN_DIR=/home/li_lab/liuyuexing/ncov/raw/month
OUT_DIR=results/all/${MONTH}
mkdir -p $OUT_DIR

FA=$IN_DIR/${MONTH}.fa
CSV=$IN_DIR/${MONTH}.csv


# 1. Filte out low quality ( ~20 seconds ) 
csvtk filter2 -f '$is_recommend != "False"' $CSV > $OUT_DIR/genome_recommend.csv


# 2. Filter by length, Ns
seqkit fx2tab $FA -n -H -C ATCG -C N -l | sed 's/#name/virus_id/' | csvtk tab2csv > $OUT_DIR/genome_summary.csv
csvtk join -f1 $OUT_DIR/genome_recommend.csv $OUT_DIR/genome_summary.csv --left-join | csvtk filter2 -f '$length > 29000 && $length < 31000 && $N < 1500' | csvtk uniq -f virus_id > $OUT_DIR/genome.csv


# Get genome (~20min)
csvtk cut -f1 $OUT_DIR/genome.csv | grep -v "virus_id" > $OUT_DIR/genome.id_list
seqkit grep $FA -f $OUT_DIR/genome.id_list | seqkit rmdup > $OUT_DIR/genome.fa


# Remove tempary files
#rm -f $OUT_DIR/genome_recommend.csv
#rm -f $OUT_DIR/genome_summary.csv

