# colnames for alleles variants

headerD <- c("ID", "NAME", "Mdu_022.a", "Mdu_022.b", "Mdu_023.a", "Mdu_023.b",
             "Mdu_036.a", "Mdu_036.b", "Mdu_049.a", "Mdu_049.b", "Mdu_083.a",
             "Mdu_083.b", "Mdu_100.a", "Mdu_100.b", "Mdu_101.a", "Mdu_101.b",
             "Mdu_118.a", "Mdu_118.b", "Mdu_119.a", "Mdu_119.b", "Mdu_172.a",
             "Mdu_172.b", "Mdu_195.a", "Mdu_195.b", "Mdu_198.a", "Mdu_198.b",
             "Mdu_200.a", "Mdu_200.b", "Mdu_214.a", "Mdu_214.b", "Mdu_265.a",
             "Mdu_265.b", "Mdu_294.a", "Mdu_294.b")


# Set ploidy and strata information

core_collection <- function(CAMU, mapa_ind_tree, colnames){
  
  ### Save csv in default format genotypes
  genind2genalex(
    CAMU,
    filename = "results/freq.csv",
    overwrite = TRUE,
    quiet = FALSE,
    pop = NULL,
    allstrata = TRUE,
    geo = FALSE,
    geodf = "xy",
    sep = ",",
    sequence = FALSE
  )
  
  ### Edit the freq.csv and change headers to Ind:ID and Pop:NAME
  camu <- read.table("results/freq.csv", sep = ",", header = TRUE)
  
  camu <- camu[3:nrow(camu),]
  colnames(camu) <- headerD
  write.csv(camu, "results/freqE.csv", row.names = FALSE)
  
  ## Calculate core collection
  my.data <- genotypes(file = "results/freqE.csv", format = "default")
  core <- sampleCore(data = my.data, size = 0.25)
  cat("Subset size : ", length(core$sel))
  evaluateCore(core, my.data, objective(
    type = c("CV"),
    measure = c("MR"),
    weight = 1,
    range = NULL
  ))
  
  return(core)
}
