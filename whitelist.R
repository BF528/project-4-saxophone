setwd("C:/Users/jason/Desktop/BU/BF528/project_4")
library(dplyr)


#Import bc_1 counts to make ecdf plots

SRR3879606_bc1<-read.table(file = "SRR3879606_bc1.txt", header = F, row.names=2)
SRR3879605_bc1<-read.table(file = "SRR3879605_bc1.txt", header = F, row.names=2)
SRR3879604_bc1<-read.table(file = "SRR3879604_bc1.txt", header = F, row.names=2)

plot(ecdf(SRR3879606_bc1[,'V1']))
plot(ecdf(SRR3879605_bc1[,'V1']))
plot(ecdf(SRR3879604_bc1[,'V1']))

#Whitelist top 1000 barcodes, make header into a column then subset out the counts.
SRR3879606<-read.table(file = "SRR3879606_bc1.txt", header = F)
SRR3879605<-read.table(file = "SRR3879605_bc1.txt", header = F)
SRR3879604<-read.table(file = "SRR3879604_bc1.txt", header = F)

SRR3879606_wl <- top_n(SRR3879606_bc1, 1000)
SRR3879606_wl2 <- setDT(SRR3879606_wl, keep.rownames = TRUE)[]
SRR3879606_wl2 = subset(SRR3879606_wl2, select = -c(2))

SRR3879605_wl <- top_n(SRR3879605_bc1, 1000)
SRR3879605_wl2 <- setDT(SRR3879605_wl, keep.rownames = TRUE)[]
SRR3879605_wl2 = subset(SRR3879605_wl2, select = -c(2))

SRR3879604_wl <- top_n(SRR3879604_bc1, 1000)
SRR3879604_wl2 <- setDT(SRR3879604_wl, keep.rownames = TRUE)[]
SRR3879604_wl2 = subset(SRR3879604_wl2, select = -c(2))

#Merge lists then remove duplicates
combined_list <- rbind(SRR3879606_wl2, SRR3879605_wl2, SRR3879604_wl2)
combined_list.un <- combined_list[!duplicated(combined_list), ]

#Write whitelist to a txt
write.table(combined_list.un, "combined_wl.txt", row.names = F, quote = F, col.names = F)