# pillar.R
# Time-stamp: <16 Sep 2017 10:51:20 c:/x/rpack/lucid/old/pillar.R>

# https://github.com/hadley/pillar

# 9.13.17 the 'pillar' package is doing nearly the same thing as lucid,
# but using color as well. Use RStudio.
# ESS sort-of works...negative numbers are red, but zeros are not gray

The crayon package in R uses ANSI color codes sent to the terminal. The regular color codes are 30-37. For example, 31 is red, which you can see like this:
R> red("this is red")
[1] "\033[31mthis is red\033[39m"

The pillar package is using silver (really gray, but called silver to avoid a name clash) to print place-holding zeros that are not really of interest.  But silver/gray is not part of the 8 ANSI base colors stored in ansi-color-names-vector.  Instead, silver() uses code 90, which is a part of the ANSI high-intensity colors.
R> silver("silver")
[1] "\033[90msilver\033[39m"

But the high-intensity colors are not supported by ansi-color.el, at least by default.  Someone has created a fix for this by extending the colors.  See https://oleksandrmanzyuk.wordpress.com/2011/11/24/better-emacs-shell-part-ii/

I have not tried this to see if it works.


library(crayon)
options(crayon.colors=TRUE)
options(crayon.enabled=TRUE)
example(green)

cat(blue("Hello", "world!\n"))
cat(green('I am a green line ' %+%
 blue$underline$bold('with a blue substring') %+%
 ' that becomes green again!\n'
))

cat(black("black") %+% red(" red") %+% green(" green") %+% yellow(" yellow") %+%
      blue(" blue") %+% magenta(" magenta") %+% cyan(" cyan") %+% white(" white") %+%
      silver(" silver") %+% "\n")

pink <- make_style("pink")
cat(pink("pink color\n"))

library(lucid)
# devtools::install_github("hadley/pillar")
library(pillar)

x0 <- c(123, 12.3, 1.23, .123456) # From Finney, page 352
print(x0)
lucid(x0, dig=2)
pillar(x0)

x1 <- c(123, NA, 1.23, NA)
lucid(x1, na.value="--")
pillar(x1)

signif(mtcars[15:20,])
lucid(mtcars[15:20,])
colonnade(mtcars[15:20,]) # no row names

x2 <- c(-1/3, 5/3, 1, 1.5, 2, 11/6, 5/6, 8.43215652105343e-17)
print(x2)
lucid(x2)
pillar(x2)

# Which coef is 0 ? How large is the intercept?
df1 <- data.frame(effect=c(-13.5, 4.5,  24.5, 6.927792e-14, -1.75,
                    16.5, 113.5000))
rownames(df1) <- c("A","B","C","C1","C2","D","(Intercept)")
print(df1)
lucid(df1)
colonnade(df1)

# Which are smallest/largest/significant variance components
df2 <- data.frame(effect=c("hyb","region","region:loc","hyb:region",
                           "yr","hyb:yr","region:yr","R!variance"),
                  component=c(10.9,277,493,1.30E-04,126,22.3,481,268),
                  std.error=c(4.40,166,26.1,1.58E-06,119,4.50,108,3.25),
                  z.ratio=c(2.471,1.669,18.899,82.242,1.060,4.951,4.442,82.242),
constraint=c("pos","pos","pos","bnd","pos","pos","pos","pos"))
print(df2)
lucid(df2)
colonnade(df2)

require(dplyr)
require(broom)
Orange %>% group_by(Tree) %>% do(tidy(lm(circumference ~ age, data=.)))

Orange %>% group_by(Tree) %>% do(tidy(lm(circumference ~ age, data=.))) %>% colonnade

Orange %>% group_by(Tree) %>% do(tidy(lm(circumference ~ age, data=.))) %>% lucid
