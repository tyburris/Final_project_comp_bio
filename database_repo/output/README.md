# Outputs

These files are outputs from the scripts querying the database files

---

## conflict resolutions between sheets

These files show descrepancies among sheets with the same columns

### `conflict-collection_site-individuals-vs-lot.tsv`

made by: `summarizeExtractions.R`

The individual and lots sheets were joined and rows were collection_site are not the same were output.  Lot probably takes precidence, but not sure - ceb.

### `conflict-storage_solution-extraction-vs-lot.tsv`

made by: `summarizeExtractions.R`

The extractiona and lots sheets were joined and rows where storage solution are not the same were output. Lot probably takes precidence, but not sure - ceb.

---

## Summary Sheets

The files distill the information in the database.  

### `summary-match_id-individuals-lots-species.tsv`

made by: `summarizeMatchIDSheet.R`

The extractions and species sheets were joined to the individual sheet, then the rows were collapsed by unique values of species, site, era, and match_id-individuals-lots-species

### `summary-extractions.tsv`

made by: `summarizeExtractions.R`

The sheet is made by joining lots, species,individuals, and extractions, then collapsing rows by site, era, species

---

## Make New DataBase Sheets 

these should have been the format of the data base sheet or should have been in the db to start with

### `shipments_only_sheet.xlsx`

made by: `makeShipmentsOnlySheet.R`

This sheet has one row per shipment. The original shipments sheet also contains unneccessary plate information.

To put this sheet into service, the extraction sheet would have to have the shipment id added.