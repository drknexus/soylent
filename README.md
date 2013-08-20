# Soylent_R 1.0

_If you don't know what soylent is, visit [soylent.me](http://soylent.me)_

This is a DIY soylent recipe forked from [zda][https://github.com/zda/soylent], cf. the source [food blog](http://www.cookingfor20.com/2013/06/18/hacker-school-soylent-recipe/) for more details. **Also, see the Safety heading**.

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
* Create an annotated database that suits the need of this proejct and others.  I'm not familiar with JSON as a database format.  So, at first I will use .csv files to store nutritional data.  I will seek to allow the exporting of this data as JSON via the `rjson` package.  The R code requires [`repsych`][https://github.com/drknexus/repsych] not because it is actually required, but because I am used to having that framework available for me in the background.

## Safety

What I am writing almost certainly is not safe.  The source fork also has disclaimers... but this one is more serious.  I'm breaking the recipe down and doing stuff to it.  At any given point it almost certainly isn't particularly safe.

## Recipe
### R Packages

```r
library(repsych)
```

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

```r
glibrary(shiny)
```

```
## In repsych::glibrary: Attempting to load requested packages...
```

```
## Loading required package: shiny
```

```
## In repsych::glibrary: Success!
```

### Ingredients

* 120 g oat flour
* 85 g soy protein from Trader Joe's, unflavored (see blog post for substitutions)
* 85 g olive oil
* 75 g brown sugar
* 25 g ground flax
* 20 g cocoa powder
* 15 g lecithin
* up to 10 g potassium citrate or 20 g potassium gluconate, added gradually (1 g per batch)
* 2 g iodized salt
* 1 g Emergen-C
* 1 Vitamin D supplement

### Method

0. Combine all dry ingredients except Vitamin D. Mix well.
0. Measure olive oil into a separate container.
0. To prepare an individual meal, measure about a third of the dry mix and a third of the oil into a large drinking vessel.
0. Add 400-500 ml (14-16 oz) of water, and shake or stir well.
0. Chill for several hours if possible, to improve taste and texture. It may be healthier that way too (due to phytic acid deactivation).
0. Meanwhile, take your Vitamin D and/or get some sunshine.
0. Drink.

## Acknowledgements
* Thanks to Zda for proposing the idea of putting this all in a computational framework and making his source available on github.
* Thanks to anyone who has beta tested or otherwise given feedback on the original source recipe, including but not limited to [Eddie](http://github.com/Eddie-D) and [Darshan](http://github.com/Shak-eah). And to [Rob](http://github.com/engibeer) for coming up with this entire idea.

## Links
* [Soylent.me](http://soylent.me) (the mothership)
* [USDA nutrient database](http://ndb.nal.usda.gov/ndb/search/list)

## License

<a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/deed.en_US"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/3.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/deed.en_US">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>.

## References
* [Zda's Original blog post](http://www.cookingfor20.com/2013/06/18/hacker-school-soylent-recipe) with photos and more information

