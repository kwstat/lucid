# lucid.r
# Time-stamp: <15 Dec 2014 17:09:51 c:/x/rpack/lucid/R/lucid.r>

# lucid is primarily a _formatting_ function similar to
# 'round' and 'signif', but output is always character.

# The returned values are printed with regular R methods.

# Note that R prints character vectors/matrices with quotes,
# but prints data.frames without quotes.

# We could define a new class for lucid output and define
# print methods for the class, but that seems like overkill...


lucid <- function(x, dig=3, na.replace=NULL, ...) UseMethod("lucid")


lucid.default <- function(x, dig=3, na.replace=NULL, ...) {
  # By default, no change to formatting
  return(x)
}


lucid.numeric <- function(x, dig=3, na.replace=NULL, ...) {
  # This is the main function that formats a vector, but NO PRINTING

  # Use 4 significant digits, drop trailing zero, align decimals
  if(class(x)=="numeric" | class(x)=="integer") {
    xx <- format(format(signif(zapsmall(x), dig),
                        scientific=FALSE, drop0trailing=TRUE))

    # Maybe change "NA" to something else
    if(!is.null(na.replace)) xx <- gsub("NA", na.replace, xx)

  } else xx <- x

  return(xx)
}

lucid.data.frame <- function(x, dig=3, na.replace=NULL, ...){
  x[] <- lapply(x, lucid, dig, na.replace)
  x
}


lucid.matrix <- function(x, dig=3, na.replace=NULL, ...){
  x[] <- apply(x, 2, lucid, dig, na.replace)
  x
}


lucid.list <- function(x, dig=3, na.replace=NULL, ...){
  #  for(ii in 1:length(x)){
  #    cat(names(x)[ii], ":\n")
  #    lucid(x[[ii]], dig=dig, na.replace=na.replace)
  #  }
  x[] <- lapply(x, lucid, dig, na.replace)
  x
}

# ----- tests -----

if(FALSE){

  # Default
  lucid(letters)

  # Vector
  lvec <- runif(10)
  lvec[5] <- NA
  lucid(lvec)
  lvec <- c(1.23, NA, 123, 123000)
  lucid(lvec)
  lucid(lvec, na.replace="")
  lucid(lvec, na.replace="-")

  # data.frame
  ldf <- mtcars[1:10,]
  ldf[3,] <- NA
  lucid(ldf)
  lucid(ldf, na="")
  lucid(ldf, na="-")
  lucid(ldf, dig=2, na="-")

  # matrix
  lmat <- as.matrix(mtcars[1:10,])
  lmat[5,1] <- lmat[4,2] <- lmat[6,3] <- lmat[3,4] <- NA
  lucid(lmat)
  lucid(lmat, na="")
  lucid(lmat, na=" -")
  lucid(lmat, dig=2, na="-")

  # list
  ll <- list(lvec=lvec, ldf=ldf, lmat=lmat)
  lucid(ll)

}
