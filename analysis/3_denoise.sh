#!/bin/bash

#===============================================#
# Denoise sequences to amplicon sequence variants (ASV)
#===============================================#

# Set up folder and create new script file for this command
mkdir 3_Denoise
touch 3_denoise.sh
chmod +x 3_denoise.sh

# Open the script file and run the following command to denoise the reads (note that --p-trim-length is dependent on vsearch_joinedreads_summary.qzv from step 1)
qiime deblur denoise-16S \
--i-demultiplexed-seqs joined-reads-filtered.qza \
--p-trim-length 446 \ 
--o-representative-sequences rep-seqs-deblur.qza \
--o-table table-deblur.qza \
--p-sample-stats \
--o-stats deblur-stats.qza

# To view the human-readable output
qiime deblur visualize-stats \
  --i-deblur-stats deblur-stats.qza \
  --o-visualization deblur-stats.qzv

qiime feature-table summarize 
--i-table table-deblur.qza 
--o-visualization table.qzv 
--m-sample-metadata-file Metadata_Casptone.tsv 

qiime feature-table tabulate-seqs \
--i-data rep-seqs-deblur.qza \
--o-visualization rep-seqs-deblur.qzv

