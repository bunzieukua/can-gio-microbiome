#!/bin/bash

#===============================================#
# Sequence quality control with q2-deblur
#===============================================#


# Set up folder and create new script file for this command
mkdir 2_Qualitycontrol
touch 2_quality_control.sh
chmod +x 2_quality_control.sh
nano 2_quality_control.sh

# Open the script file and run the following command to view quality score of the joined reads
qiime quality-filter q-score \
--i-demux joined-reads.qza \
--o-filtered-sequences joined-reads-filtered.qza \
--o-filter-stats joined-reads-filtered-stats.qza
