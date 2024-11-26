#### Setup stuff ####
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#### User Defined Variables ####
path_shipments = "../database_data_sheets/Shipment_sheet.xlsx"
out_path = "../output/shipments_only_sheet.xlsx"

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

#### READ IN DATA ####

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

#### WRITE OUTPUT ####

write_xlsx(data_shipments_only,
           out_path)

#### Remove Tibble ####

rm(data_shipments_only)