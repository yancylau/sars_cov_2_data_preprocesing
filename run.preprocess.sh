

MONTH_LIST=data/month_list.tsv


# 1. Remove low quality sequences
cat $MONTH_LIST | parallel src/prefilter_genome.sh {}


# 2. Global alignment with mafft
cat $MONTH_LIST | parallel -j 1 src/global_alignment.sh {}

# 3. Get CDS and translate
cat $MONTH_LIST | parallel -j 1 src/translate.sh {}

# 4. Assign lineages with Pangolin
cat $MONTH_LIST | parallel -j 8 src/assign_lineages.sh {}
#sed -n '23,34p' $MONTH_LIST | parallel -j 1 src/assign_lineages.sh {}

# 5. Sort each month by sequence by identity
cat $MONTH_LIST | parallel -j 6 src/arrange_genome.sh {}

# 6. Get UK dataset
cat $MONTH_LIST | parallel src/subset_uk.sh {}
