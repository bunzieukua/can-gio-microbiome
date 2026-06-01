#!/bin/bash

#===============================================#
# Classify our data with the classifier in step 5 with q2-feature-classifier
#===============================================#

# Set up folder and create new script file for this command
touch 6_taxonomy.sh
chmod +x 6_taxonomy.sh
nano 6_taxonomy.sh

# Assign taxonomy to our denoised data
qiime feature-classifier classify-sklearn \
--i-classifier classifier.qza \
--i-reads rep-seqs-deblur.qza \
--o-classification taxnomy.qza

#Visualize
qiime metadata tabulate \
--m-input-file taxnomy.qza \
--o-visualization taxonomy.qzv

#Plot bar plots for interpretation
qiime taxa barplot \
--i-table table-deblur.qza \
--i-taxonomy taxonomy.qza \
--m-metadata-file Metadata_Capstone.tsv \
--o-visualization taxa-bar-plots.qzv
