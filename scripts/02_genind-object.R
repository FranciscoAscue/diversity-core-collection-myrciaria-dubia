genind_object <- function(object, ploidy = 2, metadata){
  ploidy(object) <- ploidy
  indNames(object) <- metadata$Sample
  strata(object) <- data.frame(metadata$Pop)
  nameStrata(object) <- ~Pop
  
  # Summary of object
  print(table(strata(object, ~Pop)))
  print(summary(object))
  # object@tab
  return(object)
}

