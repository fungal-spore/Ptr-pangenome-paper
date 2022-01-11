#Hierarchical set using matchtable_0_1.txt from pangloss
#Have to manually add in a header row to identify isolates first
library(hierarchicalSets)

cl <- read.table('Z:/User/genome/Ptr/pangenome/graph_data/matchtable_0_1_head.txt', header = TRUE, stringsAsFactors = F)
#cl <- read.table('Z:/User/scripts_R/upset/matchtable_0_1_test.txt', header = F, stringsAsFactors = F)
cl_g <- cl[,1:41]
Set <- create_hierarchy(cl_g)
plot(Set)
plot(Set, type = 'intersectStack', showHierarchy = TRUE)
plot(Set, type = 'outlyingElements', quantiles = 0.8, alpha = 0.2)
plot(Set, type = 'heatmap', showHierarchy = TRUE)
Set2 <-outlier_hierarchy(Set)
Set2
plot(Set2, type = 'intersectStack', showHierarchy = TRUE)


genomes = ncol(cl_g) #number of columns in cl_g designated above
sum_column = rowSums(cl_g) #sum each row
cl_g$sum_column <- sum_column #add the row sums as extra column
cl_s = cl_g #for singleton counting
core_column = (sum_column - genomes)+1 #this makes it so any row with all 1's (i.e. core) will be 1, all others will be <1
cl_g$core_column <- core_column #add this new column to frame
cl_g[cl_g < 0] <- 0 
acc_frame =  data.frame(subset(cl_g, cl_g$core_column < 1)) #make new subset omiting rows with 1 in core (which we set above) 
acc_frame2 = data.frame(subset(acc_frame, acc_frame$sum_column > 0))
acc = data.frame(acc_frame2[,1:41])
acc_set <- create_hierarchy(acc)
plot(acc_set, type = 'intersectStack', showHierarchy = TRUE)
plot(acc_set, type = 'outlyingElements', quantiles = 0.75, alpha = 0.5)
