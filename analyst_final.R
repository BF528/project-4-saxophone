library(dplyr)
library(Seurat)
library(scatterplot3d)
library(ggplot2)

dataset <- readRDS("GSM2230760_seurat.rda")
diff_expressed_genes <- FindAllMarkers(dataset, only.pos = TRUE, min.pct = 0.15, logfc.threshold = 0.25)

#Filter only the significant markers
diff_expressed_genes_sig <- diff_expressed_genes[diff_expressed_genes$p_val_adj<0.05,]

#save to CSV file
write.csv(diff_expressed_genes, file="marker_genes.csv")
write.csv(diff_expressed_genes_sig, file="diff_expressed_genes_sig.csv")

# top marker genes per cell cluster
top5 <- diff_expressed_genes %>% group_by(cluster) %>% top_n(n=5, wt=avg_log2FC)
top10 <- diff_expressed_genes %>% group_by(cluster) %>% top_n(n=10, wt=avg_log2FC)
cluster0.marker <- top10[top10$cluster==0,]
cluster1.marker <- top10[top10$cluster==1,]
cluster2.marker <- top10[top10$cluster==2,]
cluster3.marker <- top10[top10$cluster==3,]
cluster4.marker <- top10[top10$cluster==4,]
cluster5.marker <- top10[top10$cluster==5,]
cluster6.marker <- top10[top10$cluster==6,]
cluster7.marker <- top10[top10$cluster==7,]
cluster8.marker <- top10[top10$cluster==8,]
cluster9.marker <- top10[top10$cluster==9,]
cluster10.marker <- top10[top10$cluster==10,]
cluster11.marker <- top10[top10$cluster==11,]
cluster12.marker <- top10[top10$cluster==12,]

#Delta/Gamma = SST, PPY; cluster 0
#Beta = INS; cluster 1, 6
#Acinar = CPA1; cluster 3
#Alpha = GCG; cluster 4
#Ductal = KRT19; cluster 5, cluster 10
#Cytotoxic T = CD3,CD8; cluster 9
#Macrophage = CD163,CD68,IgG; cluster 10, 11, 12
#Vascular = VWF, PECAM1, CD34; cluster 12
#Epsilon = GHRL; not found
#Stellate = PDGFRB; not found
#Mast = TPSAB1, KIT, CPA3; not found

#create violin plots
pdf("violin_plots.pdf")
VlnPlot(dataset, features = c("GCG")) #alpha 
VlnPlot(dataset, features = c("INS")) #beta
VlnPlot(dataset, features = c("SST", "PPY")) #delta/gamma
VlnPlot(dataset, features = c("KRT19")) #ductal
VlnPlot(dataset, features = c("CPA1")) #acinar
VlnPlot(dataset, features = c("CD163", "CD68")) #macrophage
VlnPlot(dataset, features = c("VWF", "PECAM1", "CD34")) #vascular

#create UMAP_plot
new.cluster.ids <- c("Alpha", "Beta", "Delta", "Gamma", "Macrophage", "Ductal", "Acinal", "Vascular")
names(new.cluster.ids) <- levels(dataset)
DimPlot(dataset, reduction = "umap", label = TRUE, pt.size = 0.2,
        label.size = 6) + NoLegend()
png("UMAP_plot.png")

#create heatmap
DoHeatmap(dataset, features = top5$gene,size = 2.0, disp.max = 4, angle = 90,label=TRUE)

# novel marker genes based on cell type
novel_marker_genes <- FindAllMarkers(dataset, only.pos = TRUE, min.pct = 0.25, logfc.threshold = 0.50,verbose = TRUE,pseudocount.use = 1)
novel_list <- novel_marker_genes %>% group_by(cluster) %>% top_n(n=1, wt=avg_log2FC)
write.csv(novel_list,"novel_marker.csv")
