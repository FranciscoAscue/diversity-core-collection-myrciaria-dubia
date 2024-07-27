
tree_nj_export <- function(genind_obj,pop_qgis){
  
  genind_obj <- CAMU
  ###poblacion###
  tree_river <- aboot(
    genind_obj,
    strata = pop(genind_obj),
    tree = "nj",
    distance = "nei.dist",
    sample = 1000,
    cutoff = 0,
    showtree = TRUE,
    missing = "mean",
    mcutoff = 0,
    quiet = FALSE,
    root = TRUE)
  print("=======> Export newick: tree_river.nwk")
  write.tree(tree_river, file = "results/tree_river.nwk")
  
  
  ###Accession###
  
  rownames(pop_qgis) <- pop_qgis$Sample
  accesion <- pop_qgis[rownames(genind_obj@tab),]
  pop(genind_obj) <- accesion$Pop
  
  tree_accesion <- aboot(
    genind_obj,
    strata = pop(genind_obj),
    tree = "nj",
    distance = "nei.dist",
    sample = 1000,
    cutoff = 0,
    showtree = TRUE,
    missing = "mean",
    mcutoff = 0,
    quiet = FALSE,
    root = TRUE)
  print("=======> Export newick: tree_accesion.nwk")
  write.tree(tree_accesion, file = "results/tree_accesion.nwk")
  
  ####individuos###
  
  tree_ind <- aboot(
    genind_obj,
    strata = NULL,
    tree = "nj",
    distance = "nei.dist",
    sample = 1000,
    cutoff = 0,
    showtree = TRUE,
    missing = "mean",
    mcutoff = 0,
    quiet = FALSE,
    root = TRUE)
  print("=======> Export newick: tree_individuos.nwk")
  write.tree(tree_ind, file = "results/tree_individuos.nwk")
}

