#Parse binary gene matchtable (matchtable_0_1.txt) from pangloss to generate boxplot figures

#import matchtable
cl <- read.table('Z:/User/genome/Ptr/pangenome/graph_data/matchtable_0_1.txt', header = F , stringsAsFactors = F)

#create empty dataframe for output
output_data = data.frame()

#loop for generating statistics, the ordering of genomes is important, so we will run many times to get stats
for (i in 1:100){

#Randomize genomes
set.seed(i)
rand <- sample(ncol(cl))
cl_rand <- cl[,rand]

#create data frame using first genome 
df <- c(1,sum(cl_rand[,1]),0,0,sum(cl_rand[,1])) #for first genome
names(df)<-c("genomes","total_core","total_acc","singletons","total_genes")

#set number of genomes you want, min is two
for (number_genomes in c(2:41)){
  cl_g <- cl_rand[,1:number_genomes]
  genomes = ncol(cl_g) #number of columns in cl_g designated above
  sum_column = rowSums(cl_g) #sum each row
  cl_g$sum_column <- sum_column #add the row sums as extra column
  cl_s = cl_g #for singleton counting
  core_column = (sum_column - genomes)+1 #this makes it so any row with all 1's (i.e. core) will be 1, all others will be <1
  cl_g$core_column <- core_column #add this new column to frame
  cl_g[cl_g < 0] <- 0 #converts any number less than 0 into a 0, this way only 1's in core genes remain and negatives won't interfere with sum
  core=cl_g$core_column  #assign column as variable
  total_core = sum(core) #sum 
  
  #calculate accessory genes
  acc_frame =  data.frame(subset(cl_g, cl_g$core_column < 1)) #make new subset omiting rows with 1 in core (which we set above) 
  acc_frame2 = data.frame(subset(acc_frame, acc_frame$sum_column > 0)) #this subset omits rows where all are zero (i.e. gene is not present in any of selected genome)
  total_acc = nrow(acc_frame2) #count of rows is total genes in the subset where gene is not core and present in at least one selected genome
  
  #count singletons
  sing_frame =  data.frame(subset(cl_s, cl_s$sum_column <2)) #make new subset omiting rows above 1 in sum (i.e. present in more than 1 genome)
  sing_frame2 = data.frame(subset(sing_frame, sing_frame$sum_column > 0)) #this subset omits rows where all are zero (i.e. gene is not present in any of selected genome)
  singletons = nrow(sing_frame2) #count of rows is total genes in the subset where gene is not core and present in at least one selected genome
  
  #output to df made above
  total_genes= total_core + total_acc 
  output<-data.frame(genomes,total_core,total_acc, singletons, total_genes)
  names(output)<-c("genomes","total_core","total_acc","singletons","total_genes")
  df <- rbind(df,output)
}
output_data <-rbind(output_data,df)
}
write.csv(output_data, "Z:/User/genome/Ptr/pangenome/graph_data/pan_gene-count_out.csv", row.names = FALSE)

#Basic plots
plot(output_data)
num_genomes=output_data$genomes
pcore=output_data$total_core
total.genes=output_data$total_genes
plot(num_genomes,total.genes)

#Generate stats 
data <- read.table("Z:/User/genome/Ptr/pangenome/graph_data/pan_gene-count_out.csv", header=TRUE, sep=",")
data.mean <- aggregate(data$total_core ~ data$genomes, data, FUN = 'mean')
names(data.mean)<-c("genomes","total_core")
data.sd <- aggregate(data$total_core ~ data$genomes, data, FUN = 'sd')
names(data.sd)<-c("genomes","sd")
sd <-data.sd$sd
data.l <- aggregate(data$total_core ~ data$genomes, FUN = 'length')
names(data.l)<-c("genomes","length")
length <-data.l$length
graph.data<-data.frame()
graph.data<-rbind(graph.data,data.mean)
graph.data[,'sd']<-sd
graph.data[,'length']<-length
write.csv(graph.data, "Z:/User/genome/Ptr/pangenome/graph_data/gene-numbers_graph-data.csv", row.names = FALSE)

#ggplot
#plot(genomes,total)
library(ggplot2)
library(scales)

# allgenes boxplot graph
ggplot(output_data, aes(x=num_genomes, y=total.genes, font=2, group=num_genomes)) +
  geom_boxplot()+      
  #geom_smooth(inherit.aes = F, aes(x=num_genomes, y=total.genes), se=F)+
  geom_line()+
  theme_gray()+
  xlab("Number of genomes")+ylab("Pangenome size (genes)")+
  scale_y_continuous(label=comma)

#coregenes boxplot graph
ggplot(output_data, aes(x=num_genomes, y=total_core, font=2, group=num_genomes)) +
  geom_boxplot()+      
  #geom_smooth(inherit.aes = F, aes(x=num_genomes, y=total.genes), se=F)+
  geom_line()+
  theme_gray()+
  xlab("Number of genomes")+ylab("Core genome size (genes)")+
  scale_y_continuous(label=comma)

