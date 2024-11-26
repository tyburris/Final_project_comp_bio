#!/bin/bash

# this script queries all fqgz file names and boils them down to individuals

queryPATH="../../*data_processing"
queryPATH="../../pire_cssl_data_processing/leiognathus_equula"
queryPATH=$1
filePATTERN="*.fq.gz"
filterOUT="deprecated"
FILTER="data_processing/.*raw"

find $queryPATH -type f -name $filePATTERN | \
grep -v $filterOUT | \
grep -E $FILTER

