# Soylent_R 1.0: Load USDA Database

This R markdown file runs with the purpose of loading the USDA database, saving each table as USDA.Rda and exporting each table as TableName.json.  Where possible, field names etc are the same as in the USDA data dictionary (contained in the downloadable .zip file).  This is version 1, errors are inevitable, please report them.

Also note that this takes a fair bit of memory (~3.5gb) and failing that may crash miserably.

## To Do
* Finish setting keys on the `data.table`s
## Data
The database sources are `http://www.ars.usda.gov/SP2UserFiles/Place/12354500/Data/SR25/dnload/sr25.zip` and `http://www.ars.usda.gov/SP2UserFiles/Place/12354500/Data/SR25/dnload/sr25abbr.zip` unpacked into the directory `./sr25`.  Rather than put strain on github or the USDA, it has been left to the compiling user to get them and put them in the right folder.

It will probable be found that ABBREV is suitable for most purposes, but the demands of the soylent project may require the details of the other tables.

## Packages and constants
* [`repsych`][https://github.com/drknexus/repsych] because drknexus is used to it 
* `data.table`, for speed and keying
* `RJSONIO` for speed and compatablity with `shiny`

```r
suppressMessages({
    library(repsych)
    glibrary(data.table, RJSONIO)
})
location <- "./sr25/"
```



## Names and Keys
### FOOD_DES
* Links to the Food Group Description file by the FdGrp_Cd field
* Links to the Nutrient Data file by the NDB_No field
* Links to the Weight file by the NDB_No field
* Links to the Footnote file by the NDB_No field
* Links to the LanguaL Factor file by the NDB_No field

```r
FOOD_DES.names <- c("NDB_No", "FdGrp_Cd", "Long_Desc", "Shrt_Desc", "ComName", 
    "ManufacName", "Survey", "Ref_desc", "Refuse", "SciName", "N_Factor", "Pro_Factor", 
    "Fat_Factor", "CHO_Factor")
```


### FD_GROUP
* Links to the Food Description file by FdGrp_Cd

```r
FD_GROUP.names <- c("FdGrp_Cd", "FdGrp_Desc")
```


### LANGUAL
* Links to the Food Description file by the NDB_No field
* Links to LanguaL Factors Description file by the Factor_Code field

```r
LANGUAL.names <- c("NDB_No", "Factor_Code")
```


### LANGDESC
* Links to the LanguaL Factor File by the Factor_Code field

```r
LANGDESC.names <- c("Factor_Code", "Description")
```


### NUT_DATA
* Links to the Food Description file by `NDB_No`.
* Links to the Food Description file by `Ref_NDB_No`.
* Links to the Weight file by `NDB_No`.
* Links to the Footnote file by `NDB_No` and when applicable, `Nutr_No`.
* Links to the Nutrient Definition file by `Nutr_No`.
* Links to the Source Code file by `Src_Cd` 
* Links to the Derivation Code file by `Deriv_Cd`

```r
NUT_DATA.names <- c("NDB_No", "Nutr_No", "Nutr_Val", "Num_Data_Pts", "Std_Error", 
    "Src_Cd", "Deriv_Cd", "Ref_NDB_No", "Add_Nutr_Mark", "Num_Studies", "Min", 
    "Max", "DF", "Low_EB", "Up_EB", "Stat_cmt", "AddMod_Date", "CC")
```

                    
### NUTR_DEF
* Links to the Nutrient Data file by `Nutr_No`.

```r
NUTR_DEF.names <- c("Nutr_No", "Units", "Tagname", "NutrDesc", "Num_Dec", "SR_Order")
```


### SRC_CD

```r
SRC_CD.names <- c("Src_Cd", "SrcCd_Desc")
```


### DERIV_CD

```r
DERIV_CD.names <- c("Deriv_Cd", "Deriv_Desc")
```


### WEIGHT
* Links to Food Description file by `NDB_No`.
* Links to Nutrient Data file by `NDB_No`.

```r
WEIGHT.names <- c("NDB_No", "Seq", "Amount", "Msre_Desc", "Gm_Wgt", "Num_Data_Pts", 
    "Std_Dev")
```


### FOOTNOTE
* Links to the Food Description file by `NDB_No`.
* Links to the Nutrient Data file by `NDB_No` and when applicable, `Nutr_No`.
* Links to the Nutrient Definition file by `Nutr_No`, when applicable.

```r
FOOTNOTE.names <- c("NDB_No", "Footnt_No", "Footnt_Typ", "Nutr_No", "Footnt_Txt")
```


### DATSRCLN
* Links to the Nutrient Data file by NDB No. and Nutr_No.
* Links to the Nutrient Definition file by Nutr_No
* Links to the Sources of Data file by DataSrc_ID.

```r
DATSRCLN.names <- c("NDB_No", "Nutr_No", "DataSrc_ID")
```


## DATA_SRC

```r
DATA_SRC.names <- c("DataSrc_ID", "Authors", "Title", "Year", "Journal", "Vol_City", 
    "Issue_State", "Start_page", "End_Page")
```


## ABBREV

```r
ABBREV.names <- c("NDB_No.", "Shrt_Desc", "Water", "Energ_Kcal", "Protein", 
    "Lipid_Tot", "Ash", "Carbohydrt", "Fiber_TD", "Sugar_Tot", "Calcium", "Iron", 
    "Magnesium", "Phosphorus", "Potassium", "Sodium", "Zinc", "Copper", "Manganese", 
    "Selenium", "Vit_C", "Thiamin", "Riboflavin", "Niacin", "Panto_acid", "Vit_B6", 
    "Folate_Tot", "Folic_acid", "Food_Folate", "Folate_DFE", "Choline_Tot", 
    "Vit_B12", "Vit_A_IU", "Vit_A_RAE", "Retinol", "Alpha_Carot", "Beta_Carot", 
    "Beta_Crypt", "Lycopene", "Lut+Zea", "Vit_E", "Vit_D_mcg", "Vit_D_IU", "Vit_K", 
    "FA_Sat", "FA_Mono", "FA_Poly", "Cholestrl", "GmWt_1", "GmWt_Desc1", "GmWt_2", 
    "GmWt_Desc2", "Refuse_Pct")
```


## File wise-load

```r
files <- list.files(location)
files <- files[grepl(".txt", files)]
database.name <- gsub(".txt", "", files)

for (f in seq_along(files)) {
    assign(database.name[f], as.data.table(read.csv(paste0(location, files[f]), 
        sep = "^", quote = "~", comment.char = "", header = FALSE)))
    setnames(get(database.name[f]), names(get(database.name[f])), get(paste0(database.name[f], 
        ".names")))
}
setkey(FOOD_DES, NDB_No)
setkey(FD_GROUP, FdGrp_Cd)
```


## Save results

```r
save(list = database.name, file = paste0(location, "USDA.Rda"))
for (f in seq_along(database.name)) {
    writeLines(toJSON(get(database.name[f]), pretty = TRUE), con = paste0(location, 
        database.name[f], ".json"))
}
```

## References
* U.S. Department of Agriculture, Agricultural Research Service. 2012. USDA National Nutrient Database for Standard Reference, Release 25. Nutrient Data Laboratory Home Page, http://www.ars.usda.gov/ba/bhnrc/ndl
