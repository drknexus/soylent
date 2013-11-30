
## @knitr DRI
UTL <- list(
  kcal_kcal=2000,
  Water_g=3000, #keeping water reasonable
  `Fatty acids, total trans_g`= .1, #any intake is bad, but we hate divide by 0 errors
  #`Fatty acids, total saturated_g` = 20, #any intake is bad, but we hate divide by 0 errors
  #stearic acid has no effect on cholesterol levels.
  `Carbohydrate, by difference_g`= 200,
  Protein_g=350,
  `Cholesterol_mg`=1200, #this guideline isn't as important as sat fat etc, cannonical value is 300, I've relaxed that considerably to be the equivelant of 6 eggs
  `Vitamin A, IU_IU` = 10000, #that is if it is preformed... can be much higher if it is coming from beta carotene - so this is assumed to be in RAE IU
  `Vitamin B-6_mg`=100,
  `Calcium, Ca_mg`=2000,
  `Chromium_mcg`=171000,
  `Vitamin D (D2 + D3)_mcg` =100,
  `Vitamin D_IU`=4000, 
  `Folate, total_mcg`=1000,
  `Iron, Fe_mg`=45,
  `Manganese, Mn_mg`=11,
  `Magnesium, Mg_mg`=750,
  `Niacin_mg`=35,
  `Phosphorus, P_mg`=4000,
  `Zinc, Zn_mg`=40
  )
DRI <- list(
   #My limits
  #kcal_kcal=1200,
  Water_g=1800,
  #`Total lipid (fat)_g`=20,
  #`Carbohydrate, by difference_g`= 10,
  #Protein_g=100,
  `Fiber, total dietary_g`=38,
  `Vitamin A, IU_IU` = 3000, #IU more frequently provided in USDA data than RAE, although RAE is actually the more useful measure - IU assumed to be reported in RAE, if this is from beta carotene I might need much more because the USDA values tend to underestimate (according to them).
  #http://ods.od.nih.gov/factsheets/VitaminA-HealthProfessional/
  #1 IU retinol = 0.3 mcg RAE
  #1 IU beta-carotene from dietary supplements = 0.15 mcg RAE
  #1 IU beta-carotene from food = 0.05 mcg RAE
  #1 IU alpha-carotene or beta-cryptoxanthin = 0.025 mcg RAE
  #So, at most we want 36,000 IU, at least we want 3,000.  At the max, 36,000 IU we coudl really be taking in 10,800 which is 3.6 times the UTL.  In soylent I expect sources to be from food or dietary supplements.  To be conservative on the high end, we'll use an upper bound of 3,000mcg RAE from supplements alone and a lower bound of 3,00mcg from food alone. the beta-carotene conversion from supplements
  `Vitamin C, total ascorbic acid_mg` = 75,
  `Vitamin D_IU` = 2000,#pauling recommended supplement 
  `Vitamin D (D2 + D3)_mcg` = 50,
  `Vitamin E (alpha-tocopherol)_mg` = 15,
  `Vitamin K (phylloquinone)_mcg` = 100,
  Thiamin_mg = 1.2,
  Riboflavin_mg = 1.3,
  Niacin_mg = 16,
  `Vitamin B-6_mg` = 1.3,
  `Folate, total_mcg` = 400,
  `Vitamin B-12_mcg` = 2.4,
  `Pantothenic acid_mg` = 5,
  #Biotin 30mcg
  `Choline, total_mg` = 425, #Original was 550mg, some sites suggest that 550mg was from a study without reasonable lower doses of Choline, and suggests 300mg, here I split the difference
  `Calcium, Ca_mg` = 1000,
  `Chromium_mcg`=35,
  `Copper, Cu_mg`=.9,
  #`Fluoride, F_mcg` = 4000, #remving flouride until I get some baking powder or something
  #Iodine 150mcg
  `Iron, Fe_mg` = 18,
  `Magnesium, Mg_mg` = 420,
  `Manganese, Mn_mg`=2.3,
  `Phosphorus, P_mg`=700,
  `Selenium, Se_mcg`=55,
  `Zinc, Zn_mg`=11,
  `Potassium, K_mg`=4700,
  `Sodium, Na_mg`=1500
  #Chloride = 2300
  )
DRIchecker <- function(recipe,DRI) {
  deficient <- NULL
  totdef <- 0
  for (i in 1:length(DRI)) {
    nutname <- names(DRI[i])
    if (!recipe[nutname] > DRI[[i]]) {
      warning("Deficient in ", nutname," by ",round((DRI[[i]]-recipe[nutname])/DRI[[i]],2)*100,"%")
      totdef <- totdef+as.numeric(round((DRI[[i]]-recipe[nutname])/DRI[[i]],2)*100)
      deficient <- c(deficient,nutname)
    }
  }
  return(list(deficient,totdef))
}
  
  
UTLchecker <- function(recipe,UTL,interactive=TRUE) {
  surplus <- NULL
  totsup <- 0
  TooMuch <- vector("list",length(UTL))
  TooMuch <- lapply(TooMuch,function (x) {!is.null(x)}) #make all list items FALSE
    names(TooMuch) <- names(UTL)
  for (i in 1:length(UTL)) {
    nutname <- names(UTL[i])
    if (!recipe[nutname] < UTL[[i]]) {
      TooMuch[[nutname]] <- TRUE
      if (interactive) {
        warning("Surplus in ", nutname," by ",round((recipe[nutname]-UTL[[i]])/UTL[[i]],2)*100,"%")
        if (nutname == "Vitamin A, IU_IU") {
          print("Too much Vitamin A is not a problem if the source is beta-carotene.  Preformed Vitamin A may be a problem... printing all foods with vitamin A... and amounts of A in recipe.  Target is 3000 IU, UTL is 10000 IU")
        } else if (nutname == "Magnesium, Mg_mg") {
          print("Too much magnesium from food does not pose a health risk in healthy individuals because the kidneys eliminate excess amounts in the urine")
        }
      }
      if (nutname %!in% c("Vitamin A, IU_IU","Magnesium, Mg_mg")) {
        totsup <- totsup+as.numeric(round((recipe[nutname]-UTL[[i]])/UTL[[i]],2)*100)
        surpluss <- c(surplus,nutname)  
      }
    }
  } #end for loop
  return(list(surplus=surplus,totsup=totsup,TooMuch=TooMuch))
}

DRI2unit <- function(DRIpct,name) {(DRIpct/100)*DRI[[name]]}


## @knitr limitsFunction
.limits <- function (x,name,min,max) {
  if (!is.na(x[[name]])) {
    if(!is.na(min)) {if (x[[name]] < min) warning(paste(name,"too low by",round((x[[name]]-min)/min,2)*100,"%\n"))}
    if(!is.na(max)) {if (x[[name]] > max) warning(paste(name,"too high by",round((x[[name]]-max)/min,2)*100,"%\n"))}
  } else {
    print(paste("No ",name,"present!"))
  }
}


## @knitr Fiber
Fiber.limits <- function(x) {.limits(x,"Fiber, total dietary_g", 38,)}


## @knitr Thiamin
Thiamin_mg.limits <- function(x) {.limits(x,"Thiamin_mg", 1.2,200)}
dv2mg_Thiamin <- function(x) {x/100*1.5}


## @knitr Riboflavin
Riboflavin_mg.limits <- function(x) {.limits(x,"Thiamin_mg", 1.2,NA)}
dv2mg_Riboflavin <- function(x) {x/100*1.7}


## @knitr B6
B6_mg.limits <- function(x) {.limits(x,"Vitamin B-6_mg", 1.3,100)}
dv2mg_B6 <- function(x) {x/100*2}


## @knitr Calcium
dv2mg_Ca <- function(x) {x*10}
Ca_mg.limits <- function(x) {.limits(x,"Calcium, Ca_mg", 1000,2000)}


## @knitr Chromium
Chromium_mcg.limits <- function(x) {.limits(x,"Chromium_mcg",35,171000)}
dv2mcg_Chromium <- function(x) {x/100*35}


## @knitr VitaminD
UTL$`Vitamin D (D2 + D3)_mcg` =100
UTL$`Vitamin D_IU`=4000


## @knitr Folate
#Folate_mcg.limits <- function(x) {.limits(x,"Folate, total_mcg", 400,1000)}
#dv2mcg_Folate <- function(x) {x/100*400}
UTL$`Folate, total_mcg` <- 800
DRI$`Folate, total_mcg` <- 400


## @knitr Iron
dv2mg_Fe <- function(x) {x/100*18}
Fe_mg.limits <- function(x) {.limits(x,"Iron, Fe_mg",18,45)}


## @knitr Manganese
Mn_mg.limits <- function(x) {.limits(x,"Manganese, Mn_mg", 2.3,11)}
dv2mg_Manganese <- function(x) {x/100*2.3}


## @knitr Magnesium
Mg_mg.limits <- function(x) {.limits(x,"Magnesium, Mg_mg", 410,750)}
dv2mg_Magnesium <- function(x) {x/100*410}


## @knitr Phosphorus
P_mg.limits <- function(x) {.limits(x,"Phosphorus, P_mg", 700,4000)}
dv2mg_P <- function(x) {x/100*700}


## @knitr Potassium
K_mg.limits <- function(x) {.limits(x,"Potassium, K_mg", 420,NA)}


## @knitr Zync
Zn_mg.limits <- function(x) {.limits(x,"Zinc, Zn_mg", 15,40)}
dv2mg_Zn <- function(x) {x/100*15}


## @knitr KatchMcArdle
KatchMcArdle <- function(lbs) {370 + (21.6 * (lbs*.4536))}


