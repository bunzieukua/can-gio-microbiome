#!/bin/bash

#===============================================#
# Train taxonomy classifier from reference genome with q2-feature-classifier
#===============================================#

# Set up folder and create new script file for this command
mkdir 5_Train_tax_classifier
touch 5_train_taxonomic_classifier.sh
chmod +x 5_train_taxonomic_classifier.sh
nano 5_train_taxonomic_classifier.sh

# First download the marker genes reference database 
wget ftp://greengenes.microbio.me/greengenes_release/gg_13_5/gg_13_8_otus.tar.gz # download file
tar xzf gg_13_8_otus.tar.gz                                                      # unzip file
md5sum gg_13_8_otus/rep_set/99_otus.fasta                                        # check if the files have been properly downloaded. this should return e5b6dd84844118591f3d9e9b6a77a846

# The downloaded file is full-length database, which we don't really need for our V3-V4 16s rRNA data. We will use the 99_otus.fasta file from the downloaded database for our data
qiime tools import \
--input-path gg_13_8_otus/rep_set/99_otus.fasta \
--type FeatureData[Sequence] \
--output-path 99_otus.qza

# Extract the reference reads that match our data
qiime feature-classifier extract-reads \
--i-sequences "99_otus.qza" \
--p-f-primer ACTCCTACGGGAGGCAGCAG \      # this is the forward primer obtained from the sequencing center
--p-r-primer GGACTACHVGGGTWTCTAAT \      # this is the reverse primer obtained from sequencing center
--p-trunc-len 446 \  
--p-min-length 100 \
--p-max-length 450 \
--p-n-jobs 10 \
--o-reads ref-seqs.qza                   # output reference data

# Map reads onto a reference taxonomy
qiime tools import \
--type FeatureData[Taxonomy] \
--input-format HeaderlessTSVTaxonomyFormat \
--input-path gg_13_8_otus/taxonomy/99_otu_taxonomy.txt \
--output-path ref-tax.qza

#Train classifier
qiime feature-classifier fit-classifier-naive-bayes \
--i-reference-reads ref-seqs.qza \
--i-reference-taxonomy ref-tax.qza \
--o-classifier classifier.qza

echo Done!
