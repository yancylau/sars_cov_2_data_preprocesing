
set -u

MONTH=$1
IN_DIR=results/all/${MONTH}/spike
OUT_DIR=results/uk/${MONTH}
mkdir -p $OUT_DIR

# Top 5 dataset (by 2022-09)
# 1. United States | USA 2980111+2453013
# 2. United Kingdom 3862690
# 3. Germany 979681 
# 4. Denmark 561751 
# 5. Japan 406349 
#REGION=Germany
#REGION="United States"


# Metadata
grep "virus_id" $IN_DIR/metadata.csv > $OUT_DIR/metadata.csv
cat $IN_DIR/metadata.csv | csvtk filter2 -f '$country=="United Kingdom"' > $OUT_DIR/metadata.csv

# ID list
csvtk cut -f1 $OUT_DIR/metadata.csv | grep -v "virus_id" > $OUT_DIR/id_list

# Spike protein
seqkit grep $IN_DIR/protein.fa -f $OUT_DIR/id_list > $OUT_DIR/protein.fa
seqkit rmdup -s $OUT_DIR/protein.fa -o $OUT_DIR/protein.unique.fa

# Aligned spike protein
seqkit grep $IN_DIR/protein.aln.fa -f $OUT_DIR/id_list > $OUT_DIR/protein.aln.fa
seqkit rmdup -s $OUT_DIR/protein.aln.fa -o $OUT_DIR/protein.unique.aln.fa

# Distance list (Sorting)
grep -Fwf $OUT_DIR/id_list $IN_DIR/distance_list.csv > $OUT_DIR/distance_list.csv



## Pairwise distance form alignment matrix


#cat $IN_DIR/identity_latitude/${MONTH}.tsv | grep -Fwf $OUT_DIR/${MONTH}/id.list | csvtk tab2csv | csvtk add-header -n "id,hamming" > $OUT_DIR/${MONTH}/identity_latitude.csv

# Metadata update
# cat $OUT_DIR/${MONTH}/metadata.csv | csvtk add-header -n "id,date,country,lineage,who" | csvtk join -f 1 $OUT_DIR/${MONTH}/identity_latitude.csv - > $OUT_DIR/${MONTH}/metadata.sorted.csv 



