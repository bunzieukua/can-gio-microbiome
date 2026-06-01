#!/bin/bash

#===============================================#
# Align and filter reads with q2-alignment
# Generate phylogenetic tree with q2-phylogeny
#===============================================#

# Set up folder and create new script file for this command
mkdir 4_Buildtree
touch 4_build_tree.sh 
chmod +x 4_build_tree.sh 

#Transfer data from step 3 to this folder so the pipeline can run
cd 3_Denoise
cp rep-seqs-deblur.qza rep-seqs-deblur1.qza # make a copy of this file
mv rep-seqs-deblur1.qza ~/4_Buildtree # move the file needed to the folder of Step5
cd 4_Buildtree
mv rep-seqs-deblur1.qza rep-seqs-deblur.qza
nano 4_build_tree.sh

# Open the script file and run the following command to denoise the reads (note that --p-trim-length is dependent on vsearch_joinedreads_summary.qzv from step 1)
qiime phylogeny align-to-tree-mafft-fasttree \
  --i-sequences rep-seqs-deblur.qza \
  --o-alignment aligned-rep-seqs.qza \
  --o-masked-alignment masked-aligned-rep-seqs.qza \
  --o-tree unrooted-tree.qza \
  --o-rooted-tree rooted-tree.qza

# Export tree file to human-readable file
qiime tools export \
--input-path rooted-tree.qza
--output-path exported-rooted-tree

# This pipeline returns a directory named "exported-rooted-tree", in which there is a file named tree.nwk
# Move this tree.nwk file back to the 4_Buildtree folder

mv tree.nwk ~/4_Buildtree


