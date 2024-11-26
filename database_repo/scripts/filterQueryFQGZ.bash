#!/bin/bash

cat ../output/allSeqFilePaths.txt | \
sed -e 's/^.*pire_//' \
-e 's/_data_processing\//\t/' \
-e 's/L[1-9]_.*$//' | \
grep -P "...\-" | \
sed -e 's/\//\t/g' \
-e 's/\(\t[A-Z][a-z][CA][0-9]\{5\}\)_.*$/\1/' \
-e 's/[_\-]Ex[0-9].*$//' \
-e 's/\tfq_raw//' \
-e 's/\traw_fq_capture//' \
-e 's/\t[1-9][snrt][tdh]_sequencing_run//' | \
sort | \
uniq | less

uniq > \
allSeqFilePathsFiltered.tsv

#cat ../output/allSeqFilePaths.txt | \
#sed -e 's/^.*pire_//' \
#-e 's/_data_processing\//\t/' \
#-e 's/L[1-9]_.*$//' | \
#sort | \
#uniq | \
#grep -P "...\-" | \
#sed -e 's/\//\t/g' \
#-e 's/\(\t[A-Z][a-z][CA][0-9]\{5\}\)_.*$/\1/' \
#-e 's/\-[0-9][0-9][A-H].*$//' \
#-e 's/\-[0-9][A-H].*$//' \
#-e 's/_$//' \
#-e 's/\-[c][s][s].*\..*$//' | \
#less
