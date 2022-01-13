data <- read.table('Z:/User/genome/Ptr/pangenome/intergeneic-distances/iso.gff3')

gene_frame = data.frame(subset(data, data$V3 == 'gene'))

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
