#### Setup stuff ####
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#### User Defined Variables ####
out_path_tsv = "../output/summary-match_id-individuals-lots-species.tsv"
out_path_xlsx = "../output/summary-match_id-individuals-lots-species.xlsx"
source("wrangleDataBase.R")
source("joinDataBaseSheets.R")

#### PACKAGES ####
packages_used <- 
  c("tidyverse",
    "janitor",
    "readxl",
    "writexl")

packages_to_install <- 
  packages_used[!packages_used %in% installed.packages()[,1]]

if (length(packages_to_install) > 0) {
  install.packages(packages_to_install, 
                   Ncpus = Sys.getenv("NUMBER_OF_PROCESSORS") - 1)
}

lapply(packages_used, 
       require, 
       character.only = TRUE)

#### Functions #####



#### summarize extractions ####

data_match_id_summary <-
  data_individuals %>%
  join_lots() %>%
  # these were checked for conflicts and passed on to Eric Garcia to resolve
  rename(
    notes_individuals = notes.x,
    notes_lots = notes.y
  ) %>%
  join_species() %>%
  rename(notes_species = notes) %>%
  group_by(
    species_valid_name,
    species_code,
    collection_period,
    collection_era,
    collection_site_individuals,
    collection_site_lot,
    site_id,
    match_id
  ) %>%
  summarize(num_records = n()) %>%
  arrange(match_id,
          species_valid_name,
          species_code,
          site_id,
          collection_era)

data_match_id_summary %>%
  write_tsv(out_path_tsv)

data_match_id_summary %>%
  write_xlsx(out_path_xlsx)


