#!/bin/bash

#===============================================#
# Rarefy samples with q2-diversity
#===============================================#

# Set up folder and create new script file for this command
touch 7_rarefaction.sh
chmod +x 7_rarefaction.sh
nano 7_rarefaction.sh

# Rarefy data
qiime diversity alpha-rarefaction \
  --i-table table.qza \
  --i-phylogeny rooted-tree.qza \
  --p-max-depth 47012 \
  --m-metadata-file Metadata_Capstone.tsv \
  --o-visualization alpha-rarefaction.qzv
