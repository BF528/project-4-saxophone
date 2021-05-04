setwd('/projectnb2/bf528/users/saxophone/project4/biologist')

marker_genes <- read.csv('/projectnb/bf528/users/saxophone/project4/analyst/marker_genes.csv', as.is = TRUE)
cluster <- unique(marker_genes$cluster)

for (n in cluster){
  mg <- paste0("marker_genes",n,sep='')
  mg_var <- assign(mg, marker_genes[marker_genes$cluster == n,])
}

#Filtered each cluster separately to get # of genes ~100
mg0 <- marker_genes0[marker_genes0$p_val<0.01,]
mg1 <- marker_genes1[marker_genes1$p_val<0.01,]
mg2 <- marker_genes2[marker_genes2$p_val<0.01,]
mg3 <- marker_genes3[marker_genes3$p_val<0.01,]
mg4 <- marker_genes4[marker_genes4$p_val<0.01,]
mg5 <- marker_genes5[marker_genes5$p_val<0.01,]
mg6 <- marker_genes6[marker_genes6$p_val<0.01 & abs(marker_genes6$avg_log2FC) > log(1.75,2),]
mg7 <- marker_genes7[marker_genes7$p_val<0.01,]
mg8 <- marker_genes8[marker_genes8$p_val<0.01 & abs(marker_genes8$avg_log2FC) > log(2,2),]
mg9 <- marker_genes9[marker_genes9$p_val<0.01 & abs(marker_genes9$avg_log2FC) > log(1.5,2),]
mg10 <- marker_genes10[marker_genes10$p_val<0.01 & abs(marker_genes10$avg_log2FC) > log(2.5,2),]
mg11 <- marker_genes11[marker_genes11$p_val<0.01 & abs(marker_genes11$avg_log2FC) > log(2.5,2),]
mg12 <- marker_genes12[marker_genes12$p_val<0.01,]

writeLines(mg0$gene,paste("genelist",0,".txt",sep=''),sep='\n')
writeLines(mg1$gene,paste("genelist",1,".txt",sep=''),sep='\n')
writeLines(mg2$gene,paste("genelist",2,".txt",sep=''),sep='\n')
writeLines(mg3$gene,paste("genelist",3,".txt",sep=''),sep='\n')
writeLines(mg4$gene,paste("genelist",4,".txt",sep=''),sep='\n')
writeLines(mg5$gene,paste("genelist",5,".txt",sep=''),sep='\n')
writeLines(mg6$gene,paste("genelist",6,".txt",sep=''),sep='\n')
writeLines(mg7$gene,paste("genelist",7,".txt",sep=''),sep='\n')
writeLines(mg8$gene,paste("genelist",8,".txt",sep=''),sep='\n')
writeLines(mg9$gene,paste("genelist",9,".txt",sep=''),sep='\n')
writeLines(mg10$gene,paste("genelist",10,".txt",sep=''),sep='\n')
writeLines(mg11$gene,paste("genelist",11,".txt",sep=''),sep='\n')
writeLines(mg12$gene,paste("genelist",12,".txt",sep=''),sep='\n')