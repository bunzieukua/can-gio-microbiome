# Workflow
<img width="870" height="455" alt="Screenshot 2026-06-01 at 5 12 55 PM" src="https://github.com/user-attachments/assets/f61c2700-8e50-4bb3-ba7e-7aea58c14510" />
Caption: Overview of the QIIME2 bioinformatics workflow. Data input is indicated in pink (solid line: this study’s
data, dashed line: outsourced data). Data processing steps are indicated in orange, with the main purpose bolded and the
main QIIME2 plugin in parentheses. The output files of each step are indicated in green. Final human-readable results are
indicated in blue. Orange boxes are discussed in detail in the subsections. Abbreviation: q2, QIIME2. Created with
BioRender®.

## Joining Single-end Sequences
As previously described, sequencing was performed using paired-
end 250-base reads, which returns two fastq files. Paired-end reads were joined using vsearch50
plugin available in QIIME2 environment (via q2-vsearch).

## Denoising Sequences to ASVs
In recent years, the field has shifted from clustering sequences into
operational taxonomic units (OTUs), which group sequences with at least 97% similarity, to denoising
methods that identify amplicon sequence variants (ASVs). Denoising allows researchers to identify
true community composition as it produces high-resolution amplicon sequence variants that resolve
differences of as little as 1 nucleotide. In this study, the chosen denoising method is Deblur, which utilizes a pre-calculated static sequence error profile to link erroneous sequence reads to their original
true biological sequence. This method is available in QIIME2 via q2-deblur.

## Sequence Alignment and Filtering
Upon denoising, ASVs were aligned, and highly variable
positions on the sequences, which generally add noise to the resulting phylogenetic tree in future steps,
were filtered. This step is done with the q2-alignment plugin.

## Phylogenetic Tree Construction
After that, the filtered alignment was used to construct an
unrooted phylogenetic tree (which illustrates relationships among species, but does not indicate their
common ancestor). The root of this phylogenetic tree was placed at the midpoint of the longest tip-
to-tip distance in the unrooted tree. The workflow described above was done through a single pipeline
align-to-tree-mafft-fasttree available in QIIME2 via q2-phylogeny.

## Training Taxonomy Classifier
To learn more about the specific organisms present in our sample,
we next classified our representative ASVs into different taxonomy using a machine learning approach.
As suggested by the developers of QIIME2, taxonomic classifier performs best when it is trained
based on how specific samples are amplified and sequenced, using information about the primers and
the length of the sequence reads. In this study, primers 338F and 806R were used to amplify the V3-
V4 hypervariable regions of the 16S rRNA gene (as discussed above). Therefore, these primers were
passed into the fit-classifier-naïve-bayes pipeline (via q2-feature-classifier
plugin) to train the classifier against the SILVA 138 SSURef full-length database. Upon
training, we validated our self-trained classifier with published data.

## Taxonomic Classification. 
Once the classifier has been trained, the representative sequences are
input into the pipeline for taxonomic classification. Then this information was used to visualize the
phylogenetic tree with q2-empress. The relative abundance of each taxonomy was visualized with
barplot using q2-taxa.

## Rarefaction Plotting
Despite constant effort in understanding the microbial community’s diversity,
the interpretation of these data is complicated by statistical challenges. One of these is the difference
in the sequencing depth of samples, which might result in increased diversity due to differential
efficiency of the sequencing process rather than true biological variation. To resolve this, rarefaction
is employed. This method involves subsampling reads without replacement to a predefined sequencing
depth, thereby generating a standardized library size across all samples. In this study, the rarefaction
curve was constructed using the diversity plugin (via q2-diversity). All samples were then
rarefied to 5000 sequences per sample.

## Diversity Analysis
After rarefaction and phylogenetic tree construction, alpha diversity metrics
(observed features, Shannon Diversity, Pielou’s Evenness, Faith’s Phylogenetic Diversity) and beta
diversity metrics (weighted UniFract, unweighted UniFrac, Jaccard distance, and Bray-Curtis
dissimilarity) were estimated using q2-diversity plugin. 

