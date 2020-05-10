################################################################################
# Brunker et al 2020, Wellcome Open Research
# Rabies minor clade Afr1a and Afr1b WGS spatial distribution: fig 7 map                      
################################################################################

### Trees
rm(list=ls())
#source("https://bioconductor.org/biocLite.R")
#biocLite("ggtree")
library(ggtree)
library(ape)
library(stringr)
library(data.table)
library(treeio)
library(tidytree)
require(phylobase)
library(ggrepel)
library(wesanderson)

# Note: set working directory to wellcome2020-paper/WGS_tree_Africa1a_1b

## import tree
tree=read.tree("AL_WG_COSMOPOLITAN_AF1a1b_og_rerooted.tree")
# remove outgroups from plot 
tree=drop.tip(tree,grep("KX148162|KX148190|KX148191",tree$tip.label))

# metadata
meta=read.csv("AL_WG_COSMOPOLITAN_AF1a1b_metadata.csv")
# customise labels
meta$sample_id2=toupper(meta$sample_id2)
meta$label2 = paste(meta$country,meta$year,meta$sample_id2,sep="|")

# attach meta to tree
p <- ggtree(tree) %<+% meta

#colour scheme
pal=c("#8DBD61","#6F459E", "#F66F8D", "#FFB643")
reg_colours = c(pal[c(3,1)])

#base plot
plot=
  p+ theme(plot.margin=unit(c(1,2,1,1),"cm"))+
  # bars to highlight clades
  geom_cladelabel(node=269, label="Africa 1b", align=F, geom='text',angle=90, barsize=1, offset=0.002, colour=pal[4], offset.text=0.001, fontsize=6)+
  geom_cladelabel(node=246, label="Africa 1a", align=F, geom='text', angle=90, barsize=1, offset=0.006,colour=pal[2], offset.text=0.001, hjust=0.5, fontsize=6)+
  # internal node shapes for support>80
  geom_nodepoint(size=2, shape=15,alpha=.3,aes(label=node,subset = !is.na(as.numeric(label)) & as.numeric(label) > 80))+
  # tip points coloured by country- only for samples seq in the paper
  geom_tippoint(size=5,alpha=.7,aes(subset= source=="this paper",fill=country, color=country, shape=country))+
  # customise scales
  scale_colour_manual(values=c("black","black")) +
  scale_fill_manual(values=reg_colours) +
  scale_shape_manual(values=c(21,24)) +
  #add trees scale
  geom_treescale(x=0, y=45, offset=1)+
  # customise legend
  theme(legend.position = "bottom",legend.text=element_text(size=14), legend.title=element_text(size=14), legend.key.size = unit(1.5, "cm"))+
  guides(fill = guide_legend(override.aes = list(colour = reg_colours)))


# actual plot
#pdf("figs/eAfrica_phylo.pdf", height=11, width=8)
p2=plot+
  #add trees scale
  geom_treescale(x=0, y=45, offset=1)+
# customise legend
  theme(legend.position = "bottom",legend.text=element_text(size=14), legend.title=element_text(size=14), legend.key.size = unit(1.5, "cm"))+
  guides(fill = guide_legend(override.aes = list(colour = reg_colours)))
# expand view of clusters with samples
p2 %>% scaleClade(443, scale=3, vertical_only=T) %>% scaleClade(479, scale=3, vertical_only=T)%>% scaleClade(354, scale=3, vertical_only=T)%>% scaleClade(265, scale=3, vertical_only=T)
#dev.off() 