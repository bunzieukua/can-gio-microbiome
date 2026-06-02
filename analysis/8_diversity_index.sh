#!/bin/bash

#===============================================#
# Calculate alpha and beta diversity metrics ưith q2-diveristy
#===============================================#

# Set up folder and create new script file for this command
touch 8_diversity_index.sh
chmod +x 8_diversity_index.sh
nano 8_diversity_index.sh

# Calculate the core metrics
qiime diversity core-metrics-phylogenetic \
  --i-phylogeny phylogeny-align-to-tree-mafft-fasttree/rooted_tree.qza \
  --i-table table-deblur.qza.qza \
  --p-sampling-depth 5000 \
  --m-metadata-file Metadata_Capstone.tsv \
  --output-dir core-metrics-results
