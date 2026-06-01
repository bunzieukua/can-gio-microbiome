#!/bin/bash

#Join demultiplexed fastq files with q2-vsearch

qiime vsearch merge-pairs \
--i-demultiplexed-seqs demux-paired-end.qz.qza \
--o-merged-sequences joined-reads.qza \
--o-unmerged-sequences unjoined-reads.qza \
--p-threads 4
