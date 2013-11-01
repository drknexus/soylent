# Soylent_R 1.1

_If you don't know what soylent is, visit [soylent.me](http://soylent.me)_

My exposure to the idea of doing a DIY soylent recipe came from [zda][https://github.com/zda/soylent], cf. the source [food blog](http://www.cookingfor20.com/2013/06/18/hacker-school-soylent-recipe/) for more details. **Also, see the Safety heading**.

Please submit bug reports and if you are interested I welcome co-developers and forks.

## Purpose
* Follow through on idea of setting the development of soylent into a computational/programming framework with source control.  This should eliminate the need for a proliferation of forks for specific needs.
* Allow for flexable/specific needs.
** Gender specific needs, e.g. For example, techbelle has [a fork][https://github.com/techbelle/soylent] that has a 'girlysoylent'.  
** Allergy specific needs
** Regional ingredient/brand availablity
** Monetary restrictions
** GMO etc restrictions
** Prep/time # of ingredient restrictions
* Make it safe(r); this involves collecting feedback from users and tracking users over time... for now this can be handled through github's issue tracker
* Create a [`shiny`][http://www.rstudio.com/shiny/] interface to accomplish it all.
* Create an annotated database that suits the need of this proejct and others.  I'm not familiar with JSON as a database format.  So, at first I will use .csv files to store nutritional data.  I will seek to allow the exporting of this data as JSON via the `rjson` package.  

## Safety

What I am writing almost certainly is not safe.  The source fork also has disclaimers... but this one is more serious.  I'm breaking the recipe down and doing stuff to it.  At any given point it almost certainly isn't particularly safe.

## Build notes
### Pre-requsites
* Have a working version of the USDA database.  The attempt to do this is currently included in 'loadUSDADatabase.Rmd' which produces `USDA.Rda` (long format) and `USDAwide.Rda` (wide format).  Zipped JSON entries for each of these will also be made available in ./sr25/ but will be updated infrequently due to the file size.  If building from scratch, the short version is that thedatabase source documents are `http://www.ars.usda.gov/SP2UserFiles/Place/12354500/Data/SR25/dnload/sr25.zip` and `http://www.ars.usda.gov/SP2UserFiles/Place/12354500/Data/SR25/dnload/sr25abbr.zip` unpacked into the directory `./sr25`.

### R Packages
* Required:  [`repsych`][https://github.com/drknexus/repsych]. Not because it is actually required, but because drknexus is accustomed to having that framework available in the background.
* It requires `shiny` in anticipation in anticipation of making use of shiny as an interface.
* `data.table` because it handles big data better than data.frames and makes for prettier code

```
## Loading required package: e1071
```

```
## Loading required package: class
```

```
## Loading required package: MASS
```

```
## Loading required package: reshape2
```

```
## Loading required package: foreach
```

```
## Loading required package: xtable
```

```
## Loading required package: plyr
```

```
## Loading required package: ez
```

```
## Loading required package: car
```

```
## Loading required package: nnet
```

```
## Loading required package: ggplot2
```

```
## Loading required package: lme4
```

```
## Loading required package: Matrix
```

```
## Loading required package: lattice
```

```
## Attaching package: 'lme4'
```

```
## The following object is masked from 'package:stats':
## 
## AIC, BIC
```

```
## Loading required package: mgcv
```

```
## This is mgcv 1.7-24. For overview type 'help("mgcv-package")'.
```

```
## Loading required package: memoise
```

```
## Loading required package: scales
```

```
## Loading required package: stringr
```

```
## Starting: russmisc Version: 1.0.0.1 Package Date: 2013-07-28
```

```
## In repsych::glibrary: Attempting to load requested packages...
```

```
## Loading required package: shiny
```

```
## Loading required package: data.table
```

```
## In repsych::glibrary: Success!
```

### Load USDA Database in Wide Format
See loadUSDAdatabase.md for annotated code, loadUSDAdatabase for pre-purled code, and USDAwide.Rda for the database that much of the rest of this rests on.

```r
purl("loadUSDAdatabase.Rmd")
```

```
## 
## 
## processing file: loadUSDAdatabase.Rmd
```

```
##   |                                                                         |                                                                 |   0%  |                                                                         |..                                                               |   2%  |                                                                         |...                                                              |   5%  |                                                                         |.....                                                            |   7%  |                                                                         |......                                                           |  10%  |                                                                         |........                                                         |  12%  |                                                                         |..........                                                       |  15%  |                                                                         |...........                                                      |  17%  |                                                                         |.............                                                    |  20%  |                                                                         |..............                                                   |  22%  |                                                                         |................                                                 |  24%  |                                                                         |.................                                                |  27%  |                                                                         |...................                                              |  29%  |                                                                         |.....................                                            |  32%  |                                                                         |......................                                           |  34%  |                                                                         |........................                                         |  37%  |                                                                         |.........................                                        |  39%  |                                                                         |...........................                                      |  41%  |                                                                         |.............................                                    |  44%  |                                                                         |..............................                                   |  46%  |                                                                         |................................                                 |  49%  |                                                                         |.................................                                |  51%  |                                                                         |...................................                              |  54%  |                                                                         |....................................                             |  56%  |                                                                         |......................................                           |  59%  |                                                                         |........................................                         |  61%  |                                                                         |.........................................                        |  63%  |                                                                         |...........................................                      |  66%  |                                                                         |............................................                     |  68%  |                                                                         |..............................................                   |  71%  |                                                                         |................................................                 |  73%  |                                                                         |.................................................                |  76%  |                                                                         |...................................................              |  78%  |                                                                         |....................................................             |  80%  |                                                                         |......................................................           |  83%  |                                                                         |.......................................................          |  85%  |                                                                         |.........................................................        |  88%  |                                                                         |...........................................................      |  90%  |                                                                         |............................................................     |  93%  |                                                                         |..............................................................   |  95%  |                                                                         |...............................................................  |  98%  |                                                                         |.................................................................| 100%
```

```
## output file: loadUSDAdatabase.R
```

```
## [1] "loadUSDAdatabase.R"
```

```r
source("loadUSDAdatabase.R")
```


## Links
* [Soylent.me](http://soylent.me) (the mothership)
* [USDA nutrient database](http://ndb.nal.usda.gov/ndb/search/list)

## License

<a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/deed.en_US"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/3.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/deed.en_US">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>.

## Acknowledgements
* Thanks to Zda for proposing the idea of putting this all in a computational framework and making his source available on github.
* Thanks to anyone who has beta tested or otherwise given feedback on the original source recipe, including but not limited to [Eddie](http://github.com/Eddie-D) and [Darshan](http://github.com/Shak-eah). And to [Rob](http://github.com/engibeer) for coming up with this entire idea.

## References
* [Zda's Original blog post](http://www.cookingfor20.com/2013/06/18/hacker-school-soylent-recipe) with photos and more information
* U.S. Department of Agriculture, Agricultural Research Service. 2012. USDA National Nutrient Database for Standard Reference, Release 25. Nutrient Data Laboratory Home Page, http://www.ars.usda.gov/ba/bhnrc/ndl
