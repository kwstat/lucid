# Effectiveness of 3 antibiotics against 16 bacterial species.

Effectiveness of 3 antibiotics against 16 bacterial species.

## Format

A data frame with 16 observations on the following 5 variables.

- `bacteria`:

  bacterial species, 16 levels

- `penicillin`:

  MIC for penicillin

- `streptomycin`:

  MIC for streptomycin

- `neomycin`:

  MIC for neomycin

- `gramstain`:

  Gram staining (positive or negative)

## Source

Will Burtin (1951). *Scope*. Fall, 1951.

## Details

The values reported are the minimum inhibitory concentration (MIC) in
micrograms/milliliter, which represents the concentration of antibiotic
required to prevent growth in vitro.

## References

Wainer, H. (2009). A Centenary Celebration for Will Burtin: A Pioneer of
Scientific Visualization. *Chance*, 22(1), 51-55.
https://chance.amstat.org/2009/02/visrev221/

Wainer, H. (2009). Visual Revelations: Pictures at an Exhibition.
*Chance*, 22(2), 46–54. https://chance.amstat.org/2009/04/visrev222/

Wainer, H. (2014). Medical Illuminations: Using Evidence, Visualization
and Statistical Thinking to Improve Healthcare.

## Examples

``` r
data(antibiotic)
lucid(antibiotic)
#>                      bacteria penicillin streptomycin neomycin gramstain
#> 1        Aerobacter aerogenes    870             1       1.6         neg
#> 2            Brucella abortus      1             2       0.02        neg
#> 3            Escherichia coli    100             0.4     0.1         neg
#> 4       Klebsiella pneumoniae    850             1.2     1           neg
#> 5  Mycobacterium tuberculosis    800             5       2           neg
#> 6            Proteus vulgaris      3             0.1     0.1         neg
#> 7      Pseudomonas aeruginosa    850             2       0.4         neg
#> 8          Salmonella typhosa      1             0.4     0.008       neg
#> 9   Salmonella schottmuelleri     10             0.8     0.09        neg
#> 10         Bacillis anthracis      0.001         0.01    0.007       pos
#> 11     Diplococcus pneumoniae      0.005        11      10           pos
#> 12       Staphylococcus albus      0.007         0.1     0.001       pos
#> 13      Staphylococcus aureus      0.03          0.03    0.001       pos
#> 14      Streptococcus fecalis      1             1       0.1         pos
#> 15  Streptococcus hemolyticus      0.001        14      10           pos
#> 16     Streptococcus viridans      0.005        10      40           pos

if (FALSE) { # \dontrun{
# Plot the data similar to Fig 2.14 of Wainer's book, "Medical Illuminations"

require(lattice)
require(reshape2)

# Use log10 transform
dat <- transform(antibiotic,
                 penicillin=log10(penicillin),
                 streptomycin=log10(streptomycin),
                 neomycin=log10(neomycin))
dat <- transform(dat, sgn = ifelse(dat$gramstain=="neg", "-", "+"))
dat <- transform(dat,
                 bacteria = paste(bacteria, sgn))
dat <- transform(dat, bacteria=reorder(bacteria, -penicillin))

dat <- melt(dat)

op <- tpg <- trellis.par.get()
tpg$superpose.symbol$pch <- toupper(substring(levels(dat$variable),1,1))
tpg$superpose.symbol$col <- c("darkgreen","purple","orange")
trellis.par.set(tpg)
dotplot(bacteria ~ value, data=dat, group=variable,
        cex=2,
        scales=list(x=list(at= -3:3,
                      labels=c('.001', '.01', '.1', '1', '10', '100', '1000'))),
        main="Bacterial response to Neomycin, Streptomycin, and Penicillin",
        xlab="Minimum Inhibitory Concentration (mg/L)")

trellis.par.set(op)

} # }

```
