# Extract variance components from mixed models

Extract the variance components from a fitted model. Currently supports
`asreml`, `lme4`, `mmer`, `nlme` and `mcmc.list` objects.

## Usage

``` r
vc(object, ...)

# Default S3 method
vc(object, ...)

# S3 method for class 'asreml'
vc(object, gamma = FALSE, ...)

# S3 method for class 'lme'
vc(object, ...)

# S3 method for class 'glmerMod'
vc(object, ...)

# S3 method for class 'lmerMod'
vc(object, ...)

# S3 method for class 'mcmc.list'
vc(object, quantiles = c(0.025, 0.5, 0.975), ...)

# S3 method for class 'mmer'
vc(object, ...)
```

## Arguments

- object:

  A fitted model object

- ...:

  Not used. Extra arguments.

- gamma:

  If gamma=FALSE, then the 'gamma' column is omitted from the results
  from asreml

- quantiles:

  The quantiles to use for printing mcmc.list objects

## Value

A data frame or other object.

## Details

The extracted variance components are stored in a data frame with an
additional 'vc.xxx' class that has an associated print method.

## Examples

``` r
if (FALSE) { # \dontrun{

require("nlme")
data(Rail)
m3 <- lme(travel~1, random=~1|Rail, data=Rail)
vc(m3)
##       effect variance stddev
##  (Intercept)   615.3  24.81
##     Residual    16.17  4.021

require("lme4")
m4 <- lmer(travel~1 + (1|Rail), data=Rail)
vc(m4)
##      grp        var1 var2   vcov  sdcor
##     Rail (Intercept) <NA> 615.3  24.81
## Residual        <NA> <NA>  16.17  4.021 

require("asreml")
ma <- asreml(travel~1, random=~Rail, data=Rail)
vc(ma)
##         effect component std.error z.ratio constr
##  Rail!Rail.var    615.3      392.6     1.6    pos
##     R!variance     16.17       6.6     2.4    pos

# See vignette for rjags example

# To change the number of digits, use the print function.
print(vc(m3), dig=5)

} # }
```
