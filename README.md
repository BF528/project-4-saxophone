# Project Description

Bulk transcriptomics profiling has been used to provide insight into tissues, disease, and development through RNA-seq using the entire population of cells within a sample. Single-cell sequencing is similar but for one cell at a time. First used in 2009 as a method to sequence scarce cells (tang et al), single-cell sequencing has been a tool to provide cellular heterogeneity. This kind of specificity allows us to create cellular maps, discover new targets, or discover new cells (Aldridge). The scaling of this technology has grown where it can be applied to the entire human body. For this project, we are using data from Baron et al., a study that uses single-cell sequencing on four human and two mice pancreata. 

Baron et al were to study and implemented a droplet-based, single-cell RNA-seq method to determine the transcriptomes of 12,000 individual panceratic cells from the four different human donors and two mouse strains. 

In this project our goal is the following:
1. Process the barcode reads of a single cell sequencing dataset
2. Perform cell-by-gene quantification of UMI counts
3. Perform quality control on a UMI count matrix
4. Analyse the UMI counts to identify clusters and marker genes for distinct cell type populations
5. Ascribe biological meaning to the clustered cell types and idnetify novel marker genes associated with them 


# Contributors

Data Curator - Jason Rose jjrose@bu.edu

Programmer - Sunny Yang yang98@bu.edu

Data Analyst - Sooyoun Lee leesu@bu.edu

Biologist - Daniel Goldstein djgoldst@bu.edu
# Repository Contents

Analyst: 
1. Seurat
The Seurat was used to analyze, and exploraiton of single-cell RNA-seq data. By using the Seurat, we were able to identify and interpret sources of heterogeneity from single-cell transcriptomic measurements, and to integrate diverse types of single-cell data.  

2. ggplot2
The ggplot2 function was used for the data visualization. By using the ggplot2, it can improve the quality and aesthetics of the graphics.  
