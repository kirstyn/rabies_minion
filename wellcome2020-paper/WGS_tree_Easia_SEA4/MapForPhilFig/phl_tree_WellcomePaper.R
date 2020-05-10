################################################################################
# Brunker et al 2020, Wellcome Open Research
# Rabies minor clade SEA4 WGS tree: fig 6 tree                      
################################################################################

#source("https://bioconductor.org/biocLite.R")
#biocLite("ggtree")
# install_github("YuLab-SMU/ggtree")
library(ape)
library(stringr)
library(data.table)
library(tidytree)
library(phylobase)
library(ggrepel)
library(ggtree)
library(treeio)
library(devtools)
library(dplyr)
library(rgdal)
library(ggplot2)
library(broom)
library(rgeos)
library(prettymapr)
library(viridis)
library(RColorBrewer)
library(wesanderson)

# Note: set working directory to wellcome2020-paper/WGS_tree_Easia_SEA4/MapForPhilFig
## import tree
tree = read.tree("data/AL_WG_ASIAN_SEA4_og_rerooted.tree")
# to drop outgroups (comment out to keep in tree)
tree=drop.tip(tree,grep("GU358653|GU647092",tree$tip.label))

## import metadata:
meta = read.csv("data/AL_WG_ASIAN_SEA4_metadata.csv")
# customise labels for trees
meta$label2 = paste("Reg", meta$region,"|",meta$year,"|",meta$sample_id.1, sep="" )
meta$label2=gsub("Regunknown","unknown", meta$label2)
meta$label2=gsub("Regoutgroup","outgroup", meta$label2)
meta$label2[meta$label2=="outgroup|na|GU647092"]=""

## colour palette
pal=wes_palette(7, name = "FantasticFox1", type = "continuous")
reg_colours = c(pal[c(1:4,6:7)],"burlywood4")

## attach metadata to tree
p <- ggtree(tree) %<+% meta

## plot tree
# pdf("figs/phl_region_tree.pdf", height=11, width=8)
p+
# shapes for internal node points with support>80  
  geom_nodepoint(size=2, shape=15,alpha=.3,aes(label=node,subset = !is.na(as.numeric(label)) & as.numeric(label) > 80))+
# tip points coloured by region and shape by source
  geom_tippoint(size=4,aes(shape = source, color = region, fill=region))+ 
# increase font size
  theme(legend.text=element_text(size=14), legend.title=element_text(size=14),legend.position = "bottom")+
# include tree scalebar  
  geom_treescale(linesize=0.5, offset=-2)+
# customise scales  
  scale_fill_manual(values=reg_colours)+scale_shape_manual(values=c(24,21))+scale_colour_manual(values=rep("black",8))+
# add legend  
  theme(legend.position = "bottom",legend.text=element_text(size=14), legend.title=element_text(size=14))+
# customise legend  
  guides(fill = guide_legend(override.aes = list(colour = reg_colours))) +theme(
    panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_rect(fill = "transparent",colour = NA),plot.background = element_rect(fill = "transparent",colour = NA)
  )  
# optional: add for tip labels:
#+geom_tiplab(aes(label=label2), size=1.5, linesize=0, align=F, offset=0.001)

#dev.off()

