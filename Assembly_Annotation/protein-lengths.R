#All proteins
#rep_all - Copy has all proteins >2000 grouped and headers renamed for figure
all <- read.table("Z:/User/genome/Ptr/pangenome/graph_data/protein_lengths/rep_all - Copy.lengths", header=TRUE)

core <- all[all$type == "Core",]
clen <- core$length
median(clen)
mean(clen)

acc <- all[all$type == "Accessory",]
alen <- acc$length
median(alen)
mean(alen)

sing <- all[all$type == "Singletons",]
slen <- sing$length
median(slen)
mean(slen)
sing
#Core, base histogram
hist <- hist(clen, breaks = 50,col="lightblue", xlim=c(0,2000))
counts<-hist$counts
breaks<-hist$breaks[2:195]-25
lines(breaks,counts, col = "red", lwd = 1)

#All, ridgeline plot
install.packages("ggridges")
library(ggplot2)
library(ggridges)
level_order <- c('Core', 'Accessory', 'Singletons')
ggplot(all, aes(x = length, y = factor(type, level = level_order), fill=type))+
  geom_density_ridges(scale = 10, alpha=0.6) + 
  scale_y_discrete(expand = c(0, 0)) +     # will generally have to set the `expand` option
  xlab("Protein lengths (aa)")+
  ylab("")+
  scale_x_continuous(expand = c(0, 0)) +   # for both axes to remove unneeded padding
  coord_cartesian(clip = "off") + # to avoid clipping of the very top of the top ridgeline
  theme_ridges()+
  scale_x_continuous(labels = scales::comma)+
  theme(legend.position = "none")+
  theme(        axis.title = element_text(size=14),
                axis.text = element_text(size=10),
                legend.title = element_blank(),
                legend.text = element_text(size = 12))
  
#Effectors (including R4)
core <- read.table("Z:/User/genome/Ptr/pangenome/effectors/effectorome/effector_core.lengths")
acc <- read.table("Z:/user/genome/Ptr/pangenome/effectors/effectorome/effectors_acc-nosingle.lengths")
sin <- read.table("Z:/User/genome/Ptr/pangenome/effectors/effectorome/effectors_acc-singletons.lengths")

clen<- core$V2
alen<- acc$V2
slen<- sin$V2

boxplot(clen, alen, slen)


