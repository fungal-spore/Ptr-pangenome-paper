#Transposable Elements Ptr
data <- read.table('Z:/User/genome/Ptr/pangenome/TE/TEsummary_forR4.csv', header = TRUE, sep=",")
library(ggplot2)

#graph by full
cbPalette <- c("#999999", "#E69F00", "#56B4E9","#CC79A7", "#009E73", "#F0E442", "#0072B2", "#D55E00",  "red", "blue", "brown")

data.code <- aggregate(data$perc_masked ~ data$Isolate*data$Full, FUN = 'sum')
iso <- data.code$`data$Isolate`
Class <- data.code$`data$Full`
TE <- data.code$`data$perc_masked`

ggplot(data.code,aes(x=iso,y=TE, fill=Class))+
  geom_col(position="stack",width=0.7)  +
  xlab("Isolate")+ylab("Percentage of genome with transposable elements")+
  theme(text = element_text(size=14),
  axis.text.x = element_text(angle=45, hjust=1))+
  scale_fill_manual(values=cbPalette)


