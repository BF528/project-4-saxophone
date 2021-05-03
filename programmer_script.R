#load libraries 
library(Seurat)
library(dplyr)
library(patchwork)
library(tximport)
library(biomaRt)
library(fishpond)
library(stringr)
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")


################BF528 Project 4 - Programmer ##################

#Read in UMI counts matrix
files <- file.path("/projectnb/bf528/users/saxophone/project4/curator/salmon_output/alevin/quants_mat.gz")
file.exists(files)
txi <- tximport(files, type="alevin")

#Initialize seurat  
pbmc <- CreateSeuratObject(counts = txi$counts, project = "10X_PBMC", min.cells = 3, min.features = 200)
pbmc

#Filter out low quality cells
# The [[ operator can add columns to object metadata. 
#pbmc[["percent.mt"]] <- PercentageFeatureSet(pbmc, pattern = "^MT-")
# visualize as a violin plot - no outstanding points 
violin_plot<- VlnPlot(pbmc, features = c("nFeature_RNA", "nCount_RNA"), ncol = 3)
#plot features (molecules detected) vs Count (genes detected)
FeatureScatter(pbmc, feature1 = "nCount_RNA", feature2 = "nFeature_RNA")
#subset qualified cells
pbmc <- subset(pbmc, subset=nFeature_RNA > 200 & nFeature_RNA < 2500 & percent.mt <5)
dim(pbmc@meta.data)
head(pbmc@meta.data)

#Normalize data, scaling by 10000
pbmc<- NormalizeData(pbmc, normalization.method = "LogNormalize", scale.factor = 10000)
head(pbmc@meta.data)

#Filter out low variance genes
pbmc <- FindVariableFeatures(pbmc, selection.method = "vst", nfeatures = 2000)
top10 <- head(VariableFeatures(pbmc), 10)
# plot variance
plot1 <- VariableFeaturePlot(pbmc)
#plot2<- LabelPoints(plot=plot1, points=top10, rebel=TRUE)
#scale the data
all.genes <- rownames(pbmc)
pbmc <- ScaleData(pbmc, features = all.genes)

#Perform and plot PCA 
pbmc <- RunPCA(pbmc, features = VariableFeatures(object = pbmc))
DimPlot(pbmc, reduction = "pca")

#Cluster cells 
ElbowPlot(pbmc)
pbmc <- FindNeighbors(pbmc, dims = 1:10)
pbmc <- FindClusters(pbmc, resolution = 0.5)
head(Idents(pbmc),5)
#Non-linear dimensional reduction plot
pbmc <- JackStraw(pbmc, num.replicate = 100)
pbmc <- ScoreJackStraw(pbmc, dims = 1:20)
JackStrawPlot(pbmc, dims = 1:15)

#Make cluster results into bar graph 
plot(Idents(pbmc))