\name{lucid}
\alias{lucid}
\alias{lucid.data.frame}
\alias{lucid.default}
\alias{lucid.list}
\alias{lucid.matrix}
\alias{lucid.numeric}
\title{Lucid printing}
\usage{
lucid(x, dig = 3, ...)

\method{lucid}{default}(x, dig = 3, ...)

\method{lucid}{numeric}(x, dig = 3, ...)

\method{lucid}{data.frame}(x, dig = 3, quote = FALSE, ...)

\method{lucid}{matrix}(x, dig = 3, quote = FALSE, ...)

\method{lucid}{list}(x, dig = 3, quote = FALSE, ...)
}

\arguments{
\item{x}{Vector or data.frame}

\item{dig}{Number of significant digits to use in printing.}

\item{...}{Additional arguments passed to the data.frame method.}

\item{quote}{Use quote marks?}
}

\value{
Text, formatted in a human-readable way.
}

\description{
Format a column of numbers in a way to make it clearer to understand.
}

\details{
Output from R is often in scientific notation, which makes it difficult to
quickly glance at numbers and gain an understanding of the relative values.
This function formats the numbers in a way that makes
interpretation of the numbers _immediately_ apparent.

The sequence of steps in formatting the output is:
(1) zap to zero (2) use significant digits
(3) drop trailing zeros after decimal
(4) align decimals.
}

\examples{
x0 <- c(123, 12.3, 1.23, .123456) # From Finney, page 352
print(x0)
lucid(x0,2)

signif(mtcars[15:20,])
lucid(mtcars[15:20,])

x1 <- c(1/3, 5/3, 1, 1.5, 2, 11/6, 5/6, 8.43215652105343e-17)
print(x1)
lucid(x1)

# Which coef is 0 ? How large is the intercept?
df1 <- data.frame(effect=c(-13.5, 4.5,  24.5, 6.927792e-14, -1.75,
                    16.5, 113.5000))
rownames(df1) <- c("A","B","C","C1","C2","D","(Intercept)")
print(df1)
lucid(df1)

# Which are smallest/largest/significant variance components
df2 <- data.frame(effect=c("hyb","region","region:loc","hyb:region",
                           "yr","hyb:yr","region:yr","R!variance"),
                  component=c(10.9,277,493,1.30E-04,126,22.3,481,268),
                  std.error=c(4.40,166,26.1,1.58E-06,119,4.50,108,3.25),
                  z.ratio=c(2.471,1.669,18.899,82.242,1.060,4.951,4.442,82.242),
constraint=c("Pos","Pos","Pos","Bound","Pos","Pos","Pos","Pos"))
print(df2)
lucid(df2)
}

\seealso{
\code{\link{signif}}
}

