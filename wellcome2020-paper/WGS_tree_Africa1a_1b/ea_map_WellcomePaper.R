################################################################################
# Brunker et al 2020, Wellcome Open Research
# # Rabies minor clade Afr1a and Afr1b WGS tree: fig 7 tree    
################################################################################

rm(list=ls())
library(rworldmap)

# map of African continent
sPDF=getMap(resolution="less islands")
sPDF=getMap()
africa=sPDF[which(sPDF$continent=="Africa"),]

# plot base map
plot(africa, border="darkgrey", col = "grey", lwd=.5)

# colour scheme
pal=c("#FFB643","#6F459E")

# add Africa 1b countries to base map
plot(africa[which(africa$NAME=="Zimbabwe"|africa$NAME=="Uganda"|africa$NAME=="Rwanda"|africa$NAME=="Mozambique"|africa$NAME=="Central African Republic"),],col="white",border="darkgrey", lwd=1,add=T)
plot(africa[which(africa$NAME=="Zimbabwe"|africa$NAME=="Uganda"|africa$NAME=="Rwanda"|africa$NAME=="Mozambique"|africa$NAME=="Central African Republic"),],col=alpha(pal[1],0.1),border="darkgrey", lwd=1,add=T)
plot(africa[which(africa$NAME=="Namibia"),],col="white",border="darkgrey", lwd=.5,add=T,lwd=1)
plot(africa[which(africa$NAME=="Namibia"),],col=alpha(pal[1],0.3),border="darkgrey", lwd=.5,add=T,lwd=1)
plot(africa[which(africa$NAME=="Kenya"|africa$NAME=="South Africa"),],border="darkgrey", lwd=.5,col=alpha(pal[1],0.5),add=T,lwd=1)
plot(africa[which(africa$NAME=="Tanzania"),],border="darkgrey", lwd=.5,col="white",add=T,lwd=1)
plot(africa[which(africa$NAME=="Tanzania"),],border="darkgrey", lwd=.5,col=pal[1],add=T,lwd=1)

# legend for africa 1b
leg.txt=c("1", "3", "5","195")
leg.col=c(alpha(pal[1],0.1), alpha(pal[1],0.3),alpha(pal[1],0.5),pal[1])
legend("topright", legend=leg.txt, fill=leg.col,  bty = "n", title="Africa 1b genomes", cex=1.3)
#addnortharrow(pos="topleft", scale=0.6)


# add Africa 1a countries to base map
plot(africa[which(africa$NAME=="Algeria"|africa$NAME=="Gabon"|africa$NAME=="Nigeria"|africa$NAME=="Tunisia"),],col="white",add=T, border="black",lwd=1)
plot(africa[which(africa$NAME=="Algeria"|africa$NAME=="Gabon"|africa$NAME=="Nigeria"|africa$NAME=="Tunisia"),],col=alpha(pal[2],0.1),add=T, border="darkgrey",lwd=1)
plot(africa[which(africa$NAME=="Ethiopia"|africa$NAME=="Somalia"),],col="white",add=T, border="darkgrey",lwd=1)
plot(africa[which(africa$NAME=="Ethiopia"|africa$NAME=="Somalia"),],col=alpha(pal[2],0.4),add=T, border="darkgrey",lwd=1)
plot(africa[which(africa$NAME=="Morocco"|africa$NAME=="Kenya"),],col="white",add=T, border="darkgrey",lwd=1)
plot(africa[which(africa$NAME=="Morocco"|africa$NAME=="Kenya"),],col=alpha(pal[2]),add=T, border="darkgrey",lwd=1)
leg.txt=c("1", "2", "5")
leg.col=c(alpha(pal[2],0.1), alpha(pal[2],0.4),pal[2])
legend("bottomleft", legend=leg.txt, fill=leg.col,  bty = "n", title="Africa 1a genomes", cex=1.3)
#addnortharrow(pos="topleft", scale=0.5)

# kenya has both lineages - add pattern and bold outline kenya/tanzania
kenya=africa[which(africa$NAME=="Kenya"),]
plot(kenya, add=T, col="white", border="transparent", lwd=1)  
plot(kenya, add=T, col=alpha(pal[1],0.5), border="black", lwd=1)  
plot(kenya, add=T, density=35, angle=90, col=pal[2], lwd=2) 
plot(africa[which(africa$NAME=="Tanzania"),], add=T, col="transparent", border="black", lwd=2) 
                