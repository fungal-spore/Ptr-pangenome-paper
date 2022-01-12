data <- read.table('Z:/User/genome/Ptr/pangenome/intergeneic-distances/I73-1.gff3')
data <- read.table('Z:/User/genome/Ptr/pangenome/intergeneic-distances/D308.gff3')
data <- read.table('Z:/User/genome/Ptr/pangenome/intergeneic-distances/I73-1.fasta.mod.EDTA.TEanno.gff')
effdata <- read.table('Z:/User/genome/Ptr/pangenome/intergeneic-distances/I73-1_effectors.attributes')

gene_frame = data.frame(subset(data, data$V3 == 'gene'))
#efflist <- effdata$V3
gene_frame <- within(gene_frame, V3[V3 == 'gene' & V4 == efflookup] <- 'effector')
efflookup <- effdata$V3
eff_frame2 = data.frame(subset(gene_frame, is.na(gene_frame$V3)))

new <- gene_frame
new[]<- lapply(gene_frame, function(x) efflist[match(gene_frame$V4, )])

#replace blanks
df[is.na(df)]<-'effector'

te_frame = data.frame(subset(data, data$V2 == 'EDTA'))

#function to shift a column up or down by 1
shiftup <- function(x, n){
  c(x[-(seq(n))], rep(0, n))
}

shiftdown <- function(x, n){
  c(x[+(seq(n))], rep(0, n))
}

#all genes
gene_frame <- gene_frame[,4:5]

#duplicate columns
gene_frame$V4.2 <- gene_frame$V4
gene_frame$V5.2 <- gene_frame$V5

#shift duplicates up by 1
gene_frame$V5.2 <- shiftup(gene_frame$V5.2, 1)
gene_frame['V4.2'] <- c(0, head(gene_frame['V4.2'], dim(gene_frame)[1] - 1)[[1]])

#gene length
gene_frame$gene <- gene_frame$V5 - gene_frame$V4
#intergenic distance 3' of previous gene to 5' of the current gene
gene_frame$fiveITL <- gene_frame$V5 - gene_frame$V4.2
#intergenic distance 3' of the current gene to 5' of the next
gene_frame$threeITL <- gene_frame$V5.2 - gene_frame$V4

gene_frame <- gene_frame[gene_frame$fiveITL >= 0, ]
gene_frame <- gene_frame[gene_frame$threeITL >= 0, ]

library(ggplot2)
options(scipen = 999)
iso <- ggplot(gene_frame, aes(x=threeITL,y=fiveITL)) +
  geom_hex(aes(color=..count..),bins=50)+
  scale_fill_distiller(palette = "Spectral", name="Gene\ncount")+
  #geom_point(data=subset(table2, group == "SP"), color = 'black',alpha = 0.25)+
  #geom_point(data=subset(table2, Gene_name == "BLGH_03023"), color = 'orange',alpha = 1)+
  #geom_point(data=subset(table2, Gene_name == "BLGH_03022"), color = 'orange',alpha = 1)+
  #geom_point(data=subset(table2, Gene_name == "BLGH_02099"), color = 'red',alpha = 1)+
  scale_x_log10()+
  scale_y_log10()+
  ylab("5' prime intergenic length (bp)") +
  xlab("3' prime intergenic length (bp)") +
  guides(color = FALSE)+
  ggtitle("I73-1 ITLs")+
  theme_minimal()
iso

###BELOW NOT YET FUNCTIONAL####
#effectors (darn right now this shows distance between effectors, not their ITLS)
#duplicaeff columns
head(eff_frame)
eff_frame$V4.2 <- eff_frame$V3
eff_frame$V5.2 <- eff_frame$V4

#shift duplicaeffs up by 1
eff_frame$V5.2 <- shiftup(eff_frame$V5.2, 1)
eff_frame['V4.2'] <- c(0, head(eff_frame['V4.2'], dim(eff_frame)[1] - 1)[[1]])

#eff length
eff_frame$eff <- eff_frame$V5 - eff_frame$V4
#ineffrgenic distance 3' of previous eff to 5' of the current eff
eff_frame$fiveITL <- eff_frame$V5 - eff_frame$V4.2
#ineffrgenic distance 3' of the current eff to 5' of the next
eff_frame$threeITL <- eff_frame$V5.2 - eff_frame$V4

eff_frame <- eff_frame[eff_frame$fiveITL >= 0, ]
eff_frame <- eff_frame[eff_frame$threeITL >= 0, ]


library(ggplot2)
options(scipen = 999)
iso 
  ggplot(eff_frame, aes(x=threeITL,y=fiveITL)) +
  geom_point(data=eff_frame, aes(x=threeITL,y=fiveITL), inherit.aes = FALSE)+
  scale_fill_distiller(palette = "Spectral", name="eff\ncount")+
  #geom_point(data=subset(table2, group == "SP"), color = 'black',alpha = 0.25)+
  #geom_point(data=subset(table2, te_name == "BLGH_03023"), color = 'orange',alpha = 1)+
  #geom_point(data=subset(table2, te_name == "BLGH_03022"), color = 'orange',alpha = 1)+
  #geom_point(data=subset(table2, te_name == "BLGH_02099"), color = 'red',alpha = 1)+
  scale_x_log10()+
  scale_y_log10()+
  ylab("5' prime intergenic length (bp)") +
  xlab("3' prime intergenic length (bp)") +
  guides(color = FALSE)+
  ggtitle("I73-1 eff Distances")+
  theme_minimal()


#TEs
te_frame <- te_frame[,4:5]

#duplicate columns
te_frame$V4.2 <- te_frame$V4
te_frame$V5.2 <- te_frame$V5

#shift duplicates up by 1
te_frame$V5.2 <- shiftup(te_frame$V5.2, 1)
te_frame['V4.2'] <- c(0, head(te_frame['V4.2'], dim(te_frame)[1] - 1)[[1]])

#te length
te_frame$te <- te_frame$V5 - te_frame$V4
#intergenic distance 3' of previous te to 5' of the current te
te_frame$fiveITL <- te_frame$V5 - te_frame$V4.2
#intergenic distance 3' of the current te to 5' of the next
te_frame$threeITL <- te_frame$V5.2 - te_frame$V4

te_frame <- te_frame[te_frame$fiveITL >= 0, ]
te_frame <- te_frame[te_frame$threeITL >= 0, ]

library(ggplot2)
options(scipen = 999)
ggplot(te_frame, aes(x=threeITL,y=fiveITL)) +
  geom_hex()+
  scale_fill_distiller(palette = "Spectral", name="te\ncount")+
  #geom_point(data=subset(table2, group == "SP"), color = 'black',alpha = 0.25)+
  #geom_point(data=subset(table2, te_name == "BLGH_03023"), color = 'orange',alpha = 1)+
  #geom_point(data=subset(table2, te_name == "BLGH_03022"), color = 'orange',alpha = 1)+
  #geom_point(data=subset(table2, te_name == "BLGH_02099"), color = 'red',alpha = 1)+
  scale_x_log10()+
  scale_y_log10()+
  ylab("5' prime intergenic length (bp)") +
  xlab("3' prime intergenic length (bp)") +
  guides(color = FALSE)+
  ggtitle("I73-1 TE Distances")+
  theme_minimal()

