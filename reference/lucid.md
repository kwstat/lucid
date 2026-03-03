# Lucid printing

Format a column of numbers in a way to make it easy to understand.

## Usage

``` r
lucid(x, dig = 3, na.value = NULL, ...)

# Default S3 method
lucid(x, dig = 3, na.value = NULL, ...)

# S3 method for class 'numeric'
lucid(x, dig = 3, na.value = NULL, ...)

# S3 method for class 'data.frame'
lucid(x, dig = 3, na.value = NULL, ...)

# S3 method for class 'matrix'
lucid(x, dig = 3, na.value = NULL, ...)

# S3 method for class 'list'
lucid(x, dig = 3, na.value = NULL, ...)

# S3 method for class 'tbl_df'
lucid(x, dig = 3, na.value = NULL, ...)
```

## Arguments

- x:

  Object to format.

- dig:

  Number of significant digits to use in printing.

- na.value:

  Character string to use instead of 'NA' for numeric missing values.
  Default is NULL, which does nothing.

- ...:

  Additional arguments passed to the data.frame method.

## Value

Text, formatted in a human-readable way. Standard R methods are used to
print the value.

## Details

Output from R is often in scientific notation, which makes it difficult
to quickly glance at numbers and gain an understanding of the relative
values. This function formats the numbers in a way that makes
interpretation of the numbers \_immediately\_ apparent.

The sequence of steps in formatting the output is: (1) zap to zero (2)
use significant digits (3) drop trailing zeros after decimal (4) align
decimals.

## See also

[`signif`](https://rdrr.io/r/base/Round.html)

## Examples

``` r
x0 <- c(123, 12.3, 1.23, .123456) # From Finney, page 352
print(x0)
#> [1] 123.000000  12.300000   1.230000   0.123456
lucid(x0, dig=2)
#> [1] "120   " " 12   " "  1.2 " "  0.12"

x1 <- c(123, NA, 1.23, NA)
lucid(x1, na.value="--")
#> [1] "123   " "    --" "  1.23" "    --"

signif(mtcars[15:20,])
#>                      mpg cyl  disp  hp drat    wt  qsec vs am gear carb
#> Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
#> Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
#> Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
#> Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
#> Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
#> Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
lucid(mtcars[15:20,])
#>                      mpg cyl  disp  hp drat   wt qsec vs am gear carb
#> Cadillac Fleetwood  10.4   8 472   205 2.93 5.25 18    0  0    3    4
#> Lincoln Continental 10.4   8 460   215 3    5.42 17.8  0  0    3    4
#> Chrysler Imperial   14.7   8 440   230 3.23 5.34 17.4  0  0    3    4
#> Fiat 128            32.4   4  78.7  66 4.08 2.2  19.5  1  1    4    1
#> Honda Civic         30.4   4  75.7  52 4.93 1.62 18.5  1  1    4    2
#> Toyota Corolla      33.9   4  71.1  65 4.22 1.84 19.9  1  1    4    1

x2 <- c(1/3, 5/3, 1, 1.5, 2, 11/6, 5/6, 8.43215652105343e-17)
print(x2)
#> [1] 3.333333e-01 1.666667e+00 1.000000e+00 1.500000e+00 2.000000e+00
#> [6] 1.833333e+00 8.333333e-01 8.432157e-17
lucid(x2)
#> [1] "0.333" "1.67 " "1    " "1.5  " "2    " "1.83 " "0.833" "0    "

# Which coef is 0 ? How large is the intercept?
df1 <- data.frame(effect=c(-13.5, 4.5,  24.5, 6.927792e-14, -1.75,
                    16.5, 113.5000))
rownames(df1) <- c("A","B","C","C1","C2","D","(Intercept)")
print(df1)
#>                    effect
#> A           -1.350000e+01
#> B            4.500000e+00
#> C            2.450000e+01
#> C1           6.927792e-14
#> C2          -1.750000e+00
#> D            1.650000e+01
#> (Intercept)  1.135000e+02
lucid(df1)
#>             effect
#> A           -13.5 
#> B             4.5 
#> C            24.5 
#> C1            0   
#> C2           -1.75
#> D            16.5 
#> (Intercept) 114   

df2 <- data.frame(effect=c("hyb","region","region:loc","hyb:region",
                           "yr","hyb:yr","region:yr","R!variance"),
                  component=c(10.9,277,493,1.30E-04,126,22.3,481,268),
                  std.error=c(4.40,166,26.1,1.58E-06,119,4.50,108,3.25),
                  z.ratio=c(2.471,1.669,18.899,82.242,
                  1.060,4.951,4.442,82.242),
                  constraint=c("pos","pos","pos","bnd",
                  "pos","pos","pos","pos"))
print(df2)
#>       effect component std.error z.ratio constraint
#> 1        hyb  1.09e+01  4.40e+00   2.471        pos
#> 2     region  2.77e+02  1.66e+02   1.669        pos
#> 3 region:loc  4.93e+02  2.61e+01  18.899        pos
#> 4 hyb:region  1.30e-04  1.58e-06  82.242        bnd
#> 5         yr  1.26e+02  1.19e+02   1.060        pos
#> 6     hyb:yr  2.23e+01  4.50e+00   4.951        pos
#> 7  region:yr  4.81e+02  1.08e+02   4.442        pos
#> 8 R!variance  2.68e+02  3.25e+00  82.242        pos
lucid(df2)
#>       effect component std.error z.ratio constraint
#> 1        hyb   10.9         4.4     2.47        pos
#> 2     region  277         166       1.67        pos
#> 3 region:loc  493          26.1    18.9         pos
#> 4 hyb:region    0.0001      0      82.2         bnd
#> 5         yr  126         119       1.06        pos
#> 6     hyb:yr   22.3         4.5     4.95        pos
#> 7  region:yr  481         108       4.44        pos
#> 8 R!variance  268           3.25   82.2         pos
```
