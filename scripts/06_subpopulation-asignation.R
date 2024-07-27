# pallete
asignation_pallete <- c("gold1", "firebrick1","slateblue1","deepskyblue", "gray52", "mediumblue", "mediumaquamarine", 
            "violetred","tan3", "darkorange4", "indianred1","plum","olivedrab3","forestgreen","darksalmon","chocolate1",
            "lightgoldenrod1")


posterior_probability <- function(subpopulation,CAMU, npca = 200, nda = 5, pallete){
  pop_qgis <- read.csv(subpopulation, , header = TRUE)
  rownames(pop_qgis) <- pop_qgis$Sample
  tabla_asignacion <- find.clusters(CAMU)
  DAPC_CAMU_Posterior <- dapc(CAMU,tabla_asignacion$grp,n.pca = npca, n.da = nda )
  summary(DAPC_CAMU_Posterior)
  bic_table <- as.data.frame(tabla_asignacion$Kstat)
  print("=======> Export BIC table : bic_table.csv")
  write.csv(bic_table,"results/bic_table.csv")
  dapc_original_river <- as.data.frame(DAPC_CAMU_Posterior$posterior)
  pop_qgis <- pop_qgis[order(rownames(dapc_original_river)),]
  dapc_original_river$pop <- pop(CAMU)
  dapc_original_river$sample_group <- pop_qgis$Pop
  dapc_original_river$indNames <- rownames(dapc_original_river)
  dapc_original_river_ggplot <- melt(dapc_original_river)
  
  
  tt_asign <- as.data.frame(DAPC_CAMU_Posterior$grp)
  tt_asign$samples <- rownames(tt_asign)
  tt_asign <- tt_asign[rownames(pop_qgis),]
  tt_asign$Samples_group <- pop_qgis$Pop
  colnames(tt_asign) <- c("Group","Samples","Pop") 
  tt_asign$Group <- paste0("Group_",tt_asign$Group)
  pp <- table(tt_asign$Pop, tt_asign$Group)
  print("=======> Export table of subpopulation : table_pop.csv")
  write.csv(as.matrix(pp),"results/table_pop.csv")
 
  colnames(dapc_original_river_ggplot) <- c("orginal_population","Sample_group","Samples","Group","ppa")
  p1_camu <- ggplot(dapc_original_river_ggplot, aes(x=Samples, y=ppa, fill=Group))
  p1_camu <- p1_camu + geom_bar(stat='identity',  position = "fill") + 
    labs(y="Posterior probability of assignment",
         x="Samples") 
  p1_camu <- p1_camu + scale_fill_manual(values = pallete) 
  p1_camu <- p1_camu + facet_grid(~orginal_population, scales = "free")
  return(p1_camu)
}



