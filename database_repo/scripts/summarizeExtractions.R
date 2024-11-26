#### Setup stuff ####
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#### User Defined Variables ####
source("wrangleDataBase.R")
source("joinDataBaseSheets.R")

#### PACKAGES ####
# packages_used <- 
#   c("tidyverse",
#     "janitor",
#     "readxl")
# 
# packages_to_install <- 
#   packages_used[!packages_used %in% installed.packages()[,1]]
# 
# if (length(packages_to_install) > 0) {
#   install.packages(packages_to_install, 
#                    Ncpus = Sys.getenv("NUMBER_OF_PROCESSORS") - 1)
# }
# 
# lapply(packages_used, 
#        require, 
#        character.only = TRUE)

#### Functions #####



#### summarize extractions ####

data_extractions_summary <-
  join_extractions_individuals() %>%
  join_lots() %>%
  # these were checked for conflicts and passed on to Eric Garcia to resolve
  rename(
    storage_solution_extraction = storage_solution.x,
    storage_solution_lot = storage_solution.y,
  ) %>%
  join_species() %>%
  rename(notes_lots = notes.x,
         notes_species = notes.y) %>%
  group_by(
    species_valid_name,
    species_code,
    collection_era,
    collection_period,
    collection_site_lot,
    collection_site_individuals
  ) %>%
  summarize(num_records = n()) %>%
  arrange(species_valid_name,
          collection_site_lot,
          collection_era)

data_extractions_summary %>%
  write_tsv("../output/summary-extractions.tsv")


#### generate files to resolve conflicts among database sheets ####

# storage_solution
data_extractions_summary %>% 
  filter(
    storage_solution_extraction != 
      storage_solution_lot
  ) %>% 
  select(
    lot_id, 
    extraction_id, 
    date_subsampling, 
    subsampler, 
    storage_solution_extraction,
    storage_solution_lot
  ) %>% 
  write_tsv("../output/conflict-storage_solution-extraction-vs-lot.tsv")

# collection_site
data_extractions_summary %>% 
  filter(
    collection_site_individuals != 
      collection_site_lot
  ) %>% 
  select(
    lot_id, 
    individual_id, 
    date_subsampling, 
    subsampler, 
    collection_site_individuals,
    collection_site_lot
  ) %>% view()
write_tsv("../output/conflict-collection_site-individuals-vs-lot.tsv")
