# Functions for Joining Data Base Files Together

#### PACKAGES ####
packages_used <-
  c("tidyverse",
    "janitor",
    "readxl")

packages_to_install <-
  packages_used[!packages_used %in% installed.packages()[,1]]

if (length(packages_to_install) > 0) {
  install.packages(packages_to_install,
                   Ncpus = Sys.getenv("NUMBER_OF_PROCESSORS") - 1)
}

lapply(packages_used,
       require,
       character.only = TRUE)

#### Functions That Join Specific Sheets Together #####

# these must be at the beginning of a pipeline

join_extractions_individuals <-
  function(){
    data_extractions %>%
      left_join(data_individuals,
                by = "individual_id") %>%
      rename(notes_extractions = notes.x,
             notes_individuals = notes.y) %>%
      select(-starts_with("x"))
  }


####

join_extractions <-
  function(data,
           join_by = "individual_id"){
    data %>%
      left_join(data_extractions,
                by = join_by) %>%
      # rename(notes_extractions = notes.x,
      #        notes_individuals = notes.y) %>%
      select(-starts_with("x"))
  }

join_individuals <-
  function(data,
           join_by = "individual_id"){
    data %>%
      left_join(data_individuals,
                by = "individual_id") %>%
      # rename(notes_extractions = notes.x,
      #        notes_individuals = notes.y) %>%
      select(-starts_with("x"))
  }

join_lots <-
  function(data,
           join_by = "lot_id"){
    data %>%
      left_join(data_lots,
                by = c(
                  "lot_id"
                )) %>%
      # these were checked for conflicts and passed on to Eric Garcia to resolve
      rename(
        collection_site_individuals = collection_site.x,
        collection_site_lot = collection_site.y
      ) 
  }

join_species <-
  function(data,
           join_by = "species_valid_name"){
    data %>%
      left_join(data_species,
                by = "species_valid_name") 
  }

join_shipping <-
  function(data,
           join_by = "species_valid_name"){
    data %>%
      left_join(data_species,
                by = "species_valid_name") 
  }

