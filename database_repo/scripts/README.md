# Scripts

---

## `wrangleDataBase.R` 

reads in database files

---

## `joinDataBaseSheets.R`  

functions to join the database files

* Functions that join specific files together, must begin a pipeline
	* `join_extractions_individuals`
		* no arguments
		
* Functions that left_join a file in a pipeline, require data input
	* `join_extractions`
		* `data`
		* `join_by="individual_id"`
	* `join_individuals`
		* `data`
		* `join_by="individual_id"`
	* `join_lots`
		* `data`
		* `join_by="lot_id"`
	* `join_species`
		* `data`
		* `join_by="species_valid_name"`

---

## `summarizeExtractions.R`

Joins extractions, individuals, lots, & species and counts up the number of records per unique combination of species, era, site

Depends upon:

* `wrangleDataBase.R` 
* `joinDataBaseSheets.R` 

---

## `makeShipmentsOnlySheet.R`

This takes the database file `Shipment_sheet.xlsx` where rows are unique combinations of `shipment_id`, `item_type`, and `plate_id` and makes `output/shipments_only_sheet.xlsx` with just one row per shipment

The `Shipment_sheet.xlsx` should be deprecated and the `shipments_only_sheet.xlsx` should replace it, but that has not happened yet.  Once this does happen, this script will never be run again.