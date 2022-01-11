#Pangenome bar charts
#pan-bar-charts.csv generate by aggregating data from counts of genes in core, acc, singleton groups for whole pangenome, effectors, and cazymes

data <- read.table('Z:/Gourlie/genome/Ptr/pangenome/graph_data/pan-bar-charts.csv', header = T,  sep=",")

#pangenome set
data <- data[1:3,]
#cazyme set
data <- data[4:6,]
#effector set
data <- data[7:9,]

type <- data$type
perc <- data$perc

#default
palette <- c('dark red', '#31A9B8', '#2D4262')
ggplot(data, aes(x=factor(type, level=type), y=perc, fill=type)) + 
  geom_bar(stat = "identity" )+
  scale_fill_manual(values=palette,  breaks=c("core","accessory","singleton"))+
  scale_x_discrete(limits=c("singleton","accessory","core" ))+
  scale_y_continuous(limits=c(0,1))+
  theme_bw()+
  theme(axis.text.y = element_blank(), 
        legend.title = element_blank(),
        legend.position = c(0.9,0.35),
        legend.background=element_rect(fill = alpha("white", 0)),
        legend.text = element_text(size =14),
        text = element_text(size = 14))+
  xlab("")+
  ylab("Proportion in the category")+
  ggtitle("Pangenome")+
  coord_flip()

#pangenome set
ggplot(data, aes(x=factor(type, level=type), y=perc, fill=type)) + 
  geom_bar(stat = "identity" )+
  scale_fill_manual(values=palette,  breaks=c("core","accessory","singleton"))+
  scale_x_discrete(limits=c("singleton","accessory","core" ))+
  scale_y_continuous(limits=c(0,1))+
  theme_bw()+
  theme(axis.text.y = element_blank(), 
        axis.text.x = element_blank(),
        legend.title = element_blank(),
        legend.position = c(0.9,0.35),
        legend.background=element_rect(fill = alpha("white", 0)),
        legend.text = element_text(size =14),
        text = element_text(size = 14))+
  xlab("")+
  ylab("Proportion in the category")+
  ggtitle("Pangenome")+
  coord_flip()

#cazyme set
ggplot(data, aes(x=factor(type, level=type), y=perc, fill=type)) + 
  geom_bar(stat = "identity" )+
  scale_fill_manual(values=palette,  breaks=c("core","accessory","singleton"))+
  scale_x_discrete(limits=c("singleton","accessory","core" ))+
  scale_y_continuous(limits=c(0,1))+
  theme_bw()+
  theme(axis.text.y = element_blank(), 
        axis.text.x = element_blank(),
        text = element_text(size = 14))+
  guides(fill=FALSE)+
  xlab("")+
  ylab("Proportion in the category")+
  ggtitle("CAZyme")+
  coord_flip()

#effector set
palette <- c('dark red', '#31A9B8', '#2D4262')
ggplot(data, aes(x=factor(type, level=type), y=perc, fill=type)) + 
  geom_bar(stat = "identity" )+
  scale_fill_manual(values=palette,  breaks=c("core","accessory","singleton"))+
  scale_x_discrete(limits=c("singleton","accessory","core" ))+
  scale_y_continuous(limits=c(0,1))+
  theme_bw()+
  theme(axis.text.y = element_blank(), 
        legend.title = element_blank(),
        text = element_text(size = 14))+
  guides(fill=FALSE)+
  xlab("")+
  ylab("Proportion in the category")+
  ggtitle("Effectors")+
  coord_flip()
