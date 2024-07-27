##### Core collection and diversity of Myrciaria dubia #####

## Source scripts
source("scripts/01_libraries.R", local = TRUE)
source("scripts/02_genind-object.R", local = TRUE)
source("scripts/03_core-collection.R", local = TRUE)
source("scripts/04_dapc-plots.R",local = TRUE)
source("scripts/05_allelic-richness.R",local = TRUE)
source("scripts/06_subpopulation-asignation.R", local = TRUE)
source("scripts/07_export-tree-nwk.R", local = TRUE)

## Convert genepop data to complete genind data
total_data <- read.genepop("data/path/data_complete.gen")

## Load and set up metadata
mapa_ind_tree <- read.csv("data/path/data_complete.csv")
rownames(mapa_ind_tree) <- mapa_ind_tree$Sample

## Create complete genind object
CAMU <- genind_object(total_data, metadata = mapa_ind_tree)

## Calculate Core Collection
core <- core_collection(CAMU, mapa_ind_tree, headerD)

## DAPC plot
mfd <- dapc_plots(CAMU = CAMU, mapa_ind_tree = mapa_ind_tree, core = core, palette = my_pal)

## Allelic Richness Comparison Between Core Collection and All Data
allelic_richness(CAMU = CAMU, mfd$table)

## Export Core Collection table
core_table <- as.data.frame(mfd$table) %>% dplyr::filter(ID == "Core collection")
core_table <- core_table %>% dplyr::select(Group)
write.csv(core_table, "results/core_selection.csv")
core_table %>% group_by(Group) %>% summarise(n = n())

## Posterior probability with Adegenet package and subpopulation assignment
posterior_probability("data/path/subpopulation.csv", CAMU = CAMU, pallete = asignation_pallete)

## NJ tree export in nwk format
tree_nj_export(genind_obj = CAMU, pop_qgis = pop_qgis)

## Convert genepop data to genind without Putumayo River
Wp_data <- read.genepop("data/path/data_without_Putumayo.gen")

## Load and set up metadata
mapa_ind_tree_sp <- read.csv("data/path/data_without_Putumayo.csv")

## Create genind object without Putumayo River
CAMU_R <- genind_object(Wp_data, metadata = mapa_ind_tree_sp)

## DAPC plot without Putumayo River
mfd_sp <- dapc_plots(CAMU = CAMU_R, mapa_ind_tree = mapa_ind_tree_sp, core = core, pallete = my_pal2)
mfd_sp
