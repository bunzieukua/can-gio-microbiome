# Library calling
library(vegan)
library(tidyverse)
library (ggprism)
library(ggplot2)
library(qiime2R)
library(corrplot)
library(RColorBrewer)
library(pheatmap)

#===============================================#
# Alpha diversity
#===============================================#

# Faith's Phylogenetic Diversity
faithpdrarefied <- read_qza("faith_pd_vector.qza")

faithpdrarefied$data$V1 <- factor(faithpdrarefied$data$V1, 
                          levels = c("CG1", "CG2", "CG3"),
                          labels = c("Low", "Medium", "High"))

ggplot(faithpdrarefied$data, aes(x=V1, y=V2, fill=V1)) + 
  geom_bar(stat='identity', width = 0.5, color = "black", linewidth = 0.4) +
  scale_fill_brewer(palette = "BuGn") +
  xlab(NULL) +
  ylab("Faith's Phylogenetic Diversity") +
  ylim(0,60)+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank(), axis.line = element_line(colour = "black", size = 0.4)) +
  #geom_text(aes(x=2, y=70.5, label="***"), size =5, color="black") +
  theme(legend.position = "none") +
  theme(legend.position = "none",
        axis.text.x = element_text(color = "black", size = 12),
        axis.text.y = element_text(color = "black", size=12),
        axis.title.y = element_text(color = "black", size=12)
  ) 

# Shannon Entropy
shannon_rarefied <- read_qza("shannon_vector.qza")

shannonrarefied <- data.frame(name=c("Low", "Medium", "High"),
                   value=c(9.565601, 9.174068, 9.503032))

shannonrarefied$name <- factor(shannonrarefied$name, levels = c("Low", "Medium", "High"))

ggplot(shannonrarefied, aes(x=name, y=value, fill=name)) + 
  geom_bar(stat="identity", width = 0.5, color = "black", size = 0.4, dpi = 700) +
  scale_fill_brewer(palette ="BuGn") +
  xlab(NULL) +
  ylab("Shannon Entropy") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank(), axis.line = element_line(colour = "black", size = 0.4)) +
  theme(legend.position = "none") +
  theme(legend.position = "none",
        axis.text.x = element_text(color = "black", size = 12),
        axis.text.y = element_text(color = "black", size=12),
        axis.title.y = element_text(color = "black", size=12)
  ) 

# Pielou's Evenness
evenness_rarefied <- read_qza("evenness_vector.qza")

pielou_rarefied <- data.frame(name=c("Low", "Medium", "High"),
                     value=c(0.9222722, 0.8975190, 0.9183784))

pielou_rarefied$name <- factor(pielou_rarefied$name, levels = pielou_rarefied$name)

ggplot(pielou_rarefied, aes(x=name, y=value, fill=name)) + 
  geom_bar(stat="identity", width = 0.5, color = "black", size = 0.4) +
  scale_fill_brewer(palette ="BuGn") +
  xlab(NULL) +
  ylab("Pielou's Evenness") +
  ylim(0,1)+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank(), axis.line = element_line(colour = "black", size = 0.4)) +
  #guides(fill=guide_legend(title=NULL))
  theme(legend.position = "none") +
  theme(legend.position = "none",
        axis.text.x = element_text(color = "black", size = 12),
        axis.text.y = element_text(color = "black", size=12),
        axis.title.y = element_text(color = "black", size=12)
  ) 


#===============================================#
# Beta diversity
#===============================================#

# Load data
feature <- read_qza("observed_features_vector.qza")
rarefied <- read_qza("rarefied_table.qza")
uw_unifrac <- read_qza("unweighted_unifrac_distance_matrix.qza")
w_unifrac <- read_qza("weighted_unifrac_distance_matrix.qza")
jaccard <- read_qza("jaccard_distance_matrix.qza")
bray_curtis <- read_qza("bray_curtis_distance_matrix.qza")


# Observed features
observed_features <- data.frame(name=c("Low", "Medium", "High"),
                              value=c(1325, 1194, 1303))

observed_features$name <- factor(observed_features$name, levels = observed_features$name)

ggplot(observed_features, aes(x=name, y=value, fill=name)) + 
  geom_bar(stat="identity", width = 0.5, color = "black", size = 0.4) +
  scale_fill_brewer(palette ="BuGn") +
  xlab("Sampling Site") +
  ylab("Observed Species") +
  ylim(0,1500)+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank(), axis.line = element_line(colour = "black", size = 0.4)) +
  guides(fill=guide_legend(title=NULL))
  theme(legend.position = "none") +
  theme(legend.position = "none",
        axis.text.x = element_text(color = "black", size = 12),
        axis.text.y = element_text(color = "black", size=12),
        axis.title.y = element_text(color = "black", size=12)
  ) 

# Set color for heat map:
my_colors <- brewer.pal(n=5, name = "BuGn")
global_min <- 1
global_max <- 0
breaks <- seq(global_min, global_max, length.out = 100)
colors <- colorRampPalette(c('white',"#ccf5cc", "#99e699", "#66cc66"))(length(breaks) - 1)


# Jaccard distance
jaccard <- data.frame(
  Low = c(0000000, 0.7492552, 0.9381818),
  Medium = c(0.7492552, 0000000, 0.9152911),
  High = c(0.9381818, 0.9152911, 0000000)
)
rownames(jaccard) <- c("Low", "Medium", "High")

pheatmap(jaccard,
         cluster_rows = FALSE,
         cluster_cols = FALSE,
         display_numbers = TRUE,
         number_format = "%.2f",           # show 2 decimal points
         fontsize_number = 10,
         color = colors,
         breaks = breaks,
         border_color = "grey80",
         main = "Jaccard Similarity"
)

# Bray-Curtis dissimilarity
bray_curtis <- data.frame(
  Low = c(0000000, 0.6920, 0.9116),
  Medium = c(0.6920, 0000000, 0.8782),
  High = c(0.9116, 0.8782, 0000000)
)

rownames(bray_curtis) <- c("Low", "Medium", "High")
pheatmap(bray_curtis,
         cluster_rows = FALSE,
         cluster_cols = FALSE,
         display_numbers = TRUE,
         number_format = "%.2f",           # show 2 decimal points
         fontsize_number = 10,
         color = colors,
         breaks = breaks,
         border_color = "grey80",
         main = "Bray-Curtis Distance"
)

# Unweighted UniFrac 
unweighted_unifrac <- data.frame(
  Low = c(0000000, 0.4437063, 0.6277147),
  Medium = c(0.4437063, 0000000, 0.6277147),
  High = c(0.6384181, 0.6277147, 0000000)
)
rownames(unweighted_unifrac) <- c("Low", "Medium", "High")

pheatmap(unweighted_unifrac,
         cluster_rows = FALSE,
         cluster_cols = FALSE,
         display_numbers = TRUE,
         number_format = "%.2f",           # show 2 decimal points
         fontsize_number = 10,
         color = colors,
         breaks = breaks,
         border_color = "grey80",
         main = "Unweighted UniFrac"
)

# Weighted UniFrac 
weighted_unifrac <- data.frame(
  Low = c(0000000, 0.1651216, 0.2409965),
  Medium = c(0.1651216, 0000000, 0.2344135),
  High = c(0.2409965, 0.2344135, 0000000)
)
rownames(weighted_unifrac) <- c("Low", "Medium", "High")

pheatmap(weighted_unifrac,
         cluster_rows = FALSE,
         cluster_cols = FALSE,
         display_numbers = TRUE,
         number_format = "%.2f",           # show 2 decimal points
         fontsize_number = 10,
         color = colors,
         breaks = breaks,
         border_color = "grey80",
         main = "Weighted UniFrac"
)
