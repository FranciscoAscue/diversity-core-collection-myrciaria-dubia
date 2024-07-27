# Package R dependencies

dependencies <- c("adegenet","ggplot2","hierfstat","poppr","corehunter","ape",
                  "pheatmap","edgeR","readr","reshape2","tidyr","polysat","dplyr")

# devtools 

if( !is.element("devtools",rownames(installed.packages() ) ) ){
  install.packages("devtools")
  install.packages("BiocManager")
}
library(devtools)

# Install missing packages

missingPackages <- function(pkg){
  if( !is.element(pkg,rownames(installed.packages() ) ) ){
    message(pkg, "-----> Package is not installed ")
    BiocManager::install(pkg)
  }
}

for(i in dependencies){
  missingPackages(i)
  library(i, character.only = TRUE)
}