# Core Collection and Diversity of Myrciaria dubia

This repository contains scripts and data for the analysis of the core collection and genetic diversity of *Myrciaria dubia* (Camu Camu). The scripts included cover various aspects of genetic analysis, from data conversion and core collection calculation to DAPC plots and allelic richness comparisons.

## Table of Contents

1. [Source Scripts](#source-scripts)
2. [Data Preparation](#data-preparation)
3. [Core Collection Calculation](#core-collection-calculation)
4. [DAPC Plots](#dapc-plots)
5. [Allelic Richness Comparison](#allelic-richness-comparison)
6. [Core Collection Export](#core-collection-export)
7. [Subpopulation Assignment](#subpopulation-assignment)
8. [NJ Tree Export](#nj-tree-export)
9. [Analysis Without Putumayo River](#analysis-without-putumayo-river)

## Source Scripts

The following scripts are sourced to perform various tasks throughout the analysis:

- `scripts/01_libraries.R`: Load necessary libraries.
- `scripts/02_genind-object.R`: Functions for handling genind objects.
- `scripts/03_core-collection.R`: Functions for calculating the core collection.
- `scripts/04_dapc-plots.R`: Functions for creating DAPC plots.
- `scripts/05_allelic-richness.R`: Functions for calculating allelic richness.
- `scripts/06_subpopulation-asignation.R`: Functions for subpopulation assignment.
- `scripts/07_export-tree-nwk.R`: Functions for exporting the NJ tree in nwk format.

## Data Preparation

Convert Genepop data to complete genind data:

```r
total_data <- read.genepop("../CamuCamu2/Cuencas_2024.gen")
mapa_ind_tree <- read.csv("../CamuCamu2/accesion_data.csv")
rownames(mapa_ind_tree) <- mapa_ind_tree$Sample
CAMU <- genind_object(total_data, metadata = mapa_ind_tree)
```

## Core Collection Calculation

Calculate the core collection:

```r
core <- core_collection(CAMU, mapa_ind_tree, headerD)
```

## DAPC Plots

Create DAPC plots:

```r
mfd <- dapc_plots(CAMU = CAMU, mapa_ind_tree = mapa_ind_tree, core = core, palette = my_pal)
```

## Allelic Richness Comparison

Compare allelic richness between the core collection and all data:

```r
allelic_richness(CAMU = CAMU, mfd$table)
```

## Core Collection Export

Export the core collection table to CSV:

```r
core_table <- as.data.frame(mfd$table) %>% dplyr::filter(ID == "Core collection")
core_table <- core_table %>% dplyr::select(Group)
write.csv(core_table, "results/core_selection.csv")
core_table %>% group_by(Group) %>% summarise(n = n())
```

## Subpopulation Assignment

Calculate posterior probabilities for subpopulations:

```r
posterior_probability("../CamuCamu2/pop_qgis.csv", CAMU = CAMU, palette = asignation_palette)
```

## NJ Tree Export

Export NJ tree to nwk format:

```r
tree_nj_export(genind_obj = CAMU, pop_qgis = pop_qgis)
```

## Analysis Without Putumayo River

Convert Genepop data to genind without Putumayo River and create DAPC plots:

```r
Wp_data <- read.genepop("../CamuCamu2/Sin_Putumayo.gen")
mapa_ind_tree_sp <- read.csv("../CamuCamu2/sinPutumayo.csv")
CAMU_R <- genind_object(Wp_data, metadata = mapa_ind_tree_sp)
mfd_sp <- dapc_plots(CAMU = CAMU_R, mapa_ind_tree = mapa_ind_tree_sp, core = core, palette = my_pal2)
mfd_sp
```

## Acknowledgments

-
