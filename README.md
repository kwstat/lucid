# lucid <img src="figure/lucid_logo_150.png" align="right" />

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/lucid)](https://cran.r-project.org/package=lucid)
[![CRAN_Downloads](https://cranlogs.r-pkg.org/badges/lucid)](https://cranlogs.r-pkg.org/badges/lucid)


The 'lucid' package provides a simple function to improve the format of floating-point numbers for humans.
The 'lucid()' function is primarily a _formatting_ function similar to 'round' and 'signif', but output is always character.

Key features:

* Simple to use.

* Makes floating-point numbers easier to read.

## Installation

```R
# Install the released version from CRAN:
install.packages("lucid")

# Install the development version from GitHub:
install.packages("devtools")
devtools::install_github("kwstat/lucid")
```

## Vignettes
 
[Lucid printing of floating-point vectors](https://rawgit.com/kwstat/lucid/master/vignettes/lucid_examples.html)

## Usage

In the short example below, a separate regression line is fit to each of five trees' circumference versus age.  The default output is difficult to interpret quickly.  The `lucid` function makes the results much cleaner by reducing visual clutter and aligning decimals.

```R
require(lucid)
require(dplyr)
require(broom)

# Fit a separate regression line to each tree.
Orange %>% group_by(Tree) %>% do(tidy(lm(circumference ~ age, data=.)))

Source: local data frame [10 x 6]
Groups: Tree [5]

    Tree        term    estimate    std.error statistic      p.value
   <ord>       <chr>       <dbl>        <dbl>     <dbl>        <dbl>
1      3 (Intercept) 19.20353638  5.863410215  3.275148 2.207255e-02
2      3         age  0.08111158  0.005628105 14.411881 2.901046e-05
3      1 (Intercept) 24.43784664  6.543311039  3.734783 1.350409e-02
4      1         age  0.08147716  0.006280721 12.972581 4.851902e-05
5      5 (Intercept)  8.75834459  8.176436207  1.071169 3.330518e-01
6      5         age  0.11102891  0.007848307 14.146861 3.177093e-05
7      2 (Intercept) 19.96090337  9.352361105  2.134317 8.593318e-02
8      2         age  0.12506176  0.008977041 13.931291 3.425041e-05
9      4 (Intercept) 14.63762022 11.233762751  1.303002 2.493507e-01
10     4         age  0.13517222  0.010782940 12.535748 5.733090e-05

# Now extend the pipe to include 'lucid'
Orange %>% group_by(Tree) %>% do(tidy(lm(circumference ~ age, data=.))) %>% lucid

Source: local data frame [10 x 6]
Groups: Tree [5]

    Tree        term estimate std.error statistic   p.value
   <ord>       <chr>    <chr>     <chr>     <chr>     <chr>
1      3 (Intercept)  19.2      5.86         3.28 0.0221   
2      3         age   0.0811   0.00563     14.4  0.000029 
3      1 (Intercept)  24.4      6.54         3.73 0.0135   
4      1         age   0.0815   0.00628     13    0.0000485
5      5 (Intercept)   8.76     8.18         1.07 0.333    
6      5         age   0.111    0.00785     14.1  0.0000318
7      2 (Intercept)  20        9.35         2.13 0.0859   
8      2         age   0.125    0.00898     13.9  0.0000343
9      4 (Intercept)  14.6     11.2          1.3  0.249    
10     4         age   0.135    0.0108      12.5  0.0000573
```

