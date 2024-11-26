#### Setup stuff ####
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#### User Defined Variables ####
path_extractions = "../database_data_sheets/Extractions_sheet.xlsx"
path_invididuals = "../database_data_sheets/Individual_sheet.xlsx"
path_lots = "../database_data_sheets/Lot_sheet.xlsx"
path_shipments = "../database_data_sheets/Shipment_sheet.xlsx"
path_sites = "../database_data_sheets/Site_sheet.xlsx"
path_species = "../database_data_sheets/Species_sheet.xlsx"
path_site = "../database_data_sheets/Site_sheet.xlsx"

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

#### READ IN DATA ####

data_species <-
  read_excel(path_species) %>%
  clean_names()  %>%
  # rename(general_fishing_pressure = general_fishing_pressure_acc_to_jem_unfished_l_m_caught_but_less_commonly_encountered_m_caught_but_not_at_high_volumes_h_high_volume_nsap_national_stock_assessment_program_of_bureau_of_fisheries_in_the_ph) %>%
  select(-starts_with("x"))

data_lots <-
  read_excel(path_lots) %>%
  clean_names()  %>%
  select(-starts_with("x"),
         -contains("do_not_add_any"))

data_individuals <-
  read_excel(path_invididuals,
             col_types = "text") %>%
  clean_names()  %>%
  # mutate(new_usnm = as.numeric(new_usnm)) %>%
  select(-starts_with("x"))

data_extractions <-
  read_excel(path_extractions) %>%
  clean_names()  %>%
  select(-starts_with("x"))

data_shipments <-
  read_excel(path_shipments,
             na = c(""
                    # "NA"
                    )) %>%
  clean_names()  %>%
  select(-starts_with("x")) 

data_shipments_plates <-
  read_excel(path_shipments,
             na = c("", 
                    "NA")) %>%
  clean_names()  %>%
  select(-starts_with("x")) %>%
  pivot_longer(cols = starts_with("plate_id"),
               names_to = "plate_rep",
               values_to = "plate_id") %>%
  filter(!is.na(plate_id))

data_shipments_only <-
  read_excel(path_shipments,
             na = c("", 
                    "NA")) %>%
  clean_names()  %>%
  select(-starts_with("x")) %>%
  mutate_all(
    list(
      ~ifelse(is.na(.), 
              "NA", 
              .))) %>%
  aggregate(item_type ~ date_shipped_by_odu + shipment_id + carrier + tracking_number + date_received_tamucc, 
            function(x) paste(unique(x), 
                              collapse = ", "),
            na.action = "na.pass")

data_sites <-
  read_excel(path_sites) %>%
  clean_names()  %>%
  select(-starts_with("x"))
