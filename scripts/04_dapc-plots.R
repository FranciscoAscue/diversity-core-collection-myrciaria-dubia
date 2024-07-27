### DAPC scatter plot default
my_pal <- c("#ff3030", "#cd853f", "#836fff", "#ffd700", "#66cdaa",
            "#00bfff", "#858585", "#228b22", "#8b4500", "#ff6a6a",
            "#0000cd", "#d02090", "#dda0dd", "#9acd32", "#e9967a", 
            "#ff7f24", "#ffec8b")

my_pal2 <- c("firebrick1", "tan3", "slateblue1", "gold1", "mediumaquamarine", 
            "gray52","forestgreen", "darkorange4", "indianred1", "mediumblue",
            "violetred","plum","olivedrab3","deepskyblue","darksalmon","chocolate1",
            "lightgoldenrod1")

## DAPC without find.cluster
dapc_plots <- function(CAMU, npca = 200, nda = 5,mapa_ind_tree,core, pallete){
  DAPC_CAMU_K <- dapc(CAMU, n.pca = npca, n.da = nda)
  # scatter(DAPC_CAMU_K, posi.da="bottomright", pch=15:23, cstar=0, col=my_pal, 
  #         clabel = F, leg=T, grid = T, cex=1.8, scree.pca = T, 
  #         ratio.pca = 0.18, ratio.da = 0.18, inset.pca = 0.02, inset.da = 0.02)
  ## DAPC ggplot
  my_df1_camu <- as.data.frame(DAPC_CAMU_K$ind.coord)
  my_df1_camu$Group <- DAPC_CAMU_K$grp
  indx <- which(rownames(my_df1_camu) %in% mapa_ind_tree$Sample)
  my_df1_camu$Cuenca <- mapa_ind_tree$Cuenca[indx]
  my_df1_camu$ID <- rownames(my_df1_camu)
  my_df1_camu$ID[which(my_df1_camu$ID %in% core$sel)] <- "Core collection"
  my_df1_camu$ID[which(my_df1_camu$ID != "Core collection")] <- "Whole Samples"
  coreColection <- my_df1_camu %>% dplyr::filter(ID == "Core collection")
  
  p2 <- ggplot(my_df1_camu, aes(x = LD1, y = LD2, color = Group)) + 
    geom_point(size = 5, shape = 19) + 
    geom_point(data= coreColection, aes(x = LD1, y = LD2, 
                                        fill = "Core collection") , size = 5.5, pch = 1, 
               colour="black") + 
    labs(color = "Cuenca") + 
    scale_color_manual(values=c(pallete)) + 
    theme_minimal()
  
  return(list(table = my_df1_camu, plot = p2))
}



