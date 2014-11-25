# lucid.r
# Time-stamp: <24 Nov 2014 17:09:27 c:/x/rpack/lucid/R/lucid.r>

lucid <- function(x, dig=3, ...) UseMethod("lucid")


lucid.default <- function(x, dig=3, ...) { x } # do nothing for non-numeric


lucid.numeric <- function(x, dig=3, ...) {
  # This is the workhorse that does the formatting, but NO PRINTING
  # Use 4 significant digits, drop trailing zero, align decimals
  if(class(x)=="numeric" | class(x)=="integer")
    format(format(signif(zapsmall(x), dig), scientific=FALSE,
                  drop0trailing=TRUE))
  else x
}


lucid.data.frame <- function(x, dig=3, quote=FALSE, ...){
  x[] <- lapply(x, lucid, dig)
  print(x, quote=quote)
  invisible(x)
}


lucid.matrix <- function(x, dig=3, quote=FALSE, ...){
  x[] <- apply(x, 2, lucid, dig)
  print(x, quote=quote)
  invisible(x)
}


lucid.list <- function(x, dig=3, quote=FALSE, ...){
  #x[] <- apply(x, 2, lucid, dig)
  for(ii in 1:length(x)){
    cat(names(x)[ii], ":\n")
    lucid(x[[ii]], dig=dig)
  }
}
