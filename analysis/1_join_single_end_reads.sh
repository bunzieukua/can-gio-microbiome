#!/bin/bash

#===============================================#
# Join demultiplexed fastq files with q2-vsearch
#===============================================#


# Set up folder and create new script file for this command
mkdir 1_Joinreads
touch 1_join_single_end_reads.sh
chmod +x 1_join_single_end_reads.sh
nano 1_join_single_end_reads.sh

# Open the script file and run the following command to join single-end reads
qiime vsearch merge-pairs \
--i-demultiplexed-seqs demux-paired-end.qz.qza \
--o-merged-sequences joined-reads.qza \
--o-unmerged-sequences unjoined-reads.qza \
--p-threads 4

# Verify paired reads quality
qiime demux summarize \
--i-data joined-reads.qza \
--o-visualization vsearch_joinedreads_summary.qzv

# To view the human-readable output
qiime tools view vsearch_joinedreads_summary.qzv
