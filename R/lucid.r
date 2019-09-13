# lucid.R
# Time-stamp: <07 Aug 2017 16:16:05 c:/x/rpack/lucid/R/lucid.R>

# lucid is primarily a _formatting_ function similar to
# 'round' and 'signif', but output is always character.

# The returned values are printed with regular R methods.

# Note that R prints character vectors/matrices with quotes,
# but prints data.frames without quotes...use 'noquote'.

# We could define a new class for lucid output and define
# print methods for the class, but that seems like overkill...


#' Lucid printing
#' 
#' Format a column of numbers in a way to make it easy to understand.
#' 
#' Output from R is often in scientific notation, which makes it difficult to
#' quickly glance at numbers and gain an understanding of the relative values.
#' This function formats the numbers in a way that makes interpretation of the
#' numbers _immediately_ apparent.
#' 
#' The sequence of steps in formatting the output is: 
#' (1) zap to zero 
#' (2) use significant digits 
#' (3) drop trailing zeros after decimal 
#' (4) align decimals.
#' 
#' @param x Object to format.
#' 
#' @param dig Number of significant digits to use in printing.
#' 
#' @param na.value Character string to use instead of 'NA' for numeric missing
#' values. Default is NULL, which does nothing.
#' 
#' @param ... Additional arguments passed to the data.frame method.
#' 
#' @return Text, formatted in a human-readable way.  Standard R methods are
#' used to print the value.
#' @seealso \code{\link{signif}}
#' 
#' @examples
#' 
#' x0 <- c(123, 12.3, 1.23, .123456) # From Finney, page 352
#' print(x0)
#' lucid(x0, dig=2)
#' 
#' x1 <- c(123, NA, 1.23, NA)
#' lucid(x1, na.value="--")
#' 
#' signif(mtcars[15:20,])
#' lucid(mtcars[15:20,])
#' 
#' x2 <- c(1/3, 5/3, 1, 1.5, 2, 11/6, 5/6, 8.43215652105343e-17)
#' print(x2)
#' lucid(x2)
#' 
#' # Which coef is 0 ? How large is the intercept?
#' df1 <- data.frame(effect=c(-13.5, 4.5,  24.5, 6.927792e-14, -1.75,
#'                     16.5, 113.5000))
#' rownames(df1) <- c("A","B","C","C1","C2","D","(Intercept)")
#' print(df1)
#' lucid(df1)
#' 
# # Which are smallest/largest/significant variance components
#' df2 <- data.frame(effect=c("hyb","region","region:loc","hyb:region",
#'                            "yr","hyb:yr","region:yr","R!variance"),
#'                   component=c(10.9,277,493,1.30E-04,126,22.3,481,268),
#'                   std.error=c(4.40,166,26.1,1.58E-06,119,4.50,108,3.25),
#'                   z.ratio=c(2.471,1.669,18.899,82.242,
#'                   1.060,4.951,4.442,82.242),
#'                   constraint=c("pos","pos","pos","bnd",
#'                   "pos","pos","pos","pos"))
#' print(df2)
#' lucid(df2)
#' 
#' @rdname lucid
#' @export
lucid <- function(x, dig=3, na.value=NULL, ...) UseMethod("lucid")


#' @rdname lucid
#' @export
lucid.default <- function(x, dig=3, na.value=NULL, ...) {
  # By default, no change to formatting
  return(x)
}


#' @rdname lucid
#' @export
lucid.numeric <- function(x, dig=3, na.value=NULL, ...) {
  # This is the main function that formats a vector, but NO PRINTING

  # Use 3 significant digits, drop trailing zero, align decimals
  if(class(x)=="numeric" | class(x)=="integer") {
    xx <- format(format(signif(zapsmall(x), dig),
                        scientific=FALSE, drop0trailing=TRUE))

    # Maybe change NA to something else.  Note that formatting
    # above has changed NA to "NA"
    if(!is.null(na.value)) xx <- gsub("NA", na.value, xx)

  } else xx <- x

  return(xx)
}


#' @rdname lucid
#' @export
lucid.data.frame <- function(x, dig=3, na.value=NULL, ...){
  x[] <- lapply(x, lucid, dig, na.value)
  x
}


#' @rdname lucid
#' @export
lucid.matrix <- function(x, dig=3, na.value=NULL, ...){
  x[] <- apply(x, 2, lucid, dig, na.value)
  x
}


#' @rdname lucid 
#' @export
lucid.list <- function(x, dig=3, na.value=NULL, ...){
  x[] <- lapply(x, lucid, dig, na.value)
  x
}

#' @rdname lucid
#' @export
lucid.tbl_df <- function(x, dig=3, na.value=NULL, ...){
  # tibble tries to control formatting, which clashes with lucid,
  # so strip the tibble classes.
  class(x) <- "data.frame"
  x[] <- lapply(x, lucid, dig, na.value)
  x
}


# # ----- tests -----
# 
# if(FALSE){
# 
#   require(lucid)
#   
#   # Default
#   lucid(letters)
# 
#   # Vector
#   lvec <- runif(10)
#   lvec[5] <- NA
#   lucid(lvec)
#   lvec <- c(1.23, NA, 123, 123000)
#   lucid(lvec)
#   lucid(lvec, na.value="")
#   lucid(lvec, na.value="--")
# 
#   # data.frame
#   ldf <- mtcars[1:10,]
#   ldf[3,] <- NA
#   lucid(ldf)
#   lucid(ldf, na="")
#   lucid(ldf, na="--")
#   lucid(ldf, dig=2, na="--")
#   
#   # matrix
#   lmat <- as.matrix(mtcars[1:10,])
#   lmat[5,1] <- lmat[4,2] <- lmat[6,3] <- lmat[3,4] <- NA
#   lucid(lmat)
#   lucid(lmat, na="")
#   lucid(lmat, na=" -")
#   lucid(lmat, dig=2, na="-")
#   # To omit quotes from matrix output
#   noquote(lucid(lmat, dig=2, na="-"))
#   print(lucid(lmat, dig=2, na="-"), quote=FALSE)
# 
#   # list
#   ll <- list(lvec=lvec, ldf=ldf, lmat=lmat)
#   lucid(ll)
# 
# }
