
allelic_richness <- function(CAMU, table){
  richAl <- t(as.matrix(allelic.richness(genind2hierfstat(CAMU))$Ar))
  richAl <- richAl[order(row.names(richAl)),]
  pop(CAMU) <- table$ID
  richAl_core <- t(as.matrix(allelic.richness(genind2hierfstat(CAMU))$Ar))
  richAl <- rbind(richAl, richAl_core[2,])
  rownames(richAl)[9] <- "Core collection"
  heatmap_alric <- pheatmap(richAl, cluster_rows = T, cluster_cols = F, treeheight_row = 80)
  return(heatmap_alric)
} 

