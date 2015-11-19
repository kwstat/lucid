# vc.r
# Time-stamp: <01 Sep 2015 17:18:03 c:/x/rpack/lucid/R/vc.r>

# The 'vc' function extracts the variance components from
# a fitted model.
# The print methods use 'lucid' to format the output.

# Beware!  print() methods must return the object via invisible()
# Without invisible(), devtools::run_examples was giving me weird
# error messages from replay() on NULL objects



#' Extract variance components from mixed models
#' 
#' Extract the variance components from a fitted model.  Currently supports
#' \code{asreml}, \code{lme4}, \code{nlme} and \code{mcmc.list} objects.
#' 
#' The extracted variance components are stored in a data frame with an
#' additional 'vc.xxx' class that has an associated print method.
#' 
#' 
#' @param object A fitted model object
#' @param ... Not used. Extra arguments.
#' @return A data frame or other object.
#' @examples
#' 
#' \dontrun{
#' 
#' require("nlme")
#' data(Rail)
#' m3 <- lme(travel~1, random=~1|Rail, data=Rail)
#' vc(m3)
#' ##       effect variance stddev
#' ##  (Intercept)   615.3  24.81
#' ##     Residual    16.17  4.021
#' 
#' require("lme4")
#' m4 <- lmer(travel~1 + (1|Rail), data=Rail)
#' vc(m4)
#' ##      grp        var1 var2   vcov  sdcor
#' ##     Rail (Intercept) <NA> 615.3  24.81
#' ## Residual        <NA> <NA>  16.17  4.021 
#' 
#' require("asreml")
#' ma <- asreml(travel~1, random=~Rail, data=Rail)
#' vc(ma)
#' ##         effect component std.error z.ratio constr
#' ##  Rail!Rail.var    615.3      392.6     1.6    pos
#' ##     R!variance     16.17       6.6     2.4    pos
#' 
#' # See vignette for rjags example
#' 
#' # To change the number of digits, use the print function.
#' print(vc(m3), dig=5)
#' 
#' }
#' 
#' @rdname vc
#' @export
vc <- function(object, ...) UseMethod("vc")


# ----- default -----

#' @rdname vc
#' @export
vc.default <- function(object, ...) {
  stop("No default method exists for 'vc'.")
}


# ----- asreml -----


#' @param gamma If gamma=FALSE, then the 'gamma' column is omitted from the
#' results from asreml
#' @rdname vc
#' @export
vc.asreml <- function (object, gamma=FALSE, ...) {

  vv <- summary(object)$varcomp
  if(gamma==FALSE)
    vv$gamma <- NULL

  nm <- rownames(vv)
  nm <- factor(nm, levels=nm) # prevent alphanum sorting
  vv <- cbind(effect=nm, vv)
  rownames(vv) <- NULL

  class(vv) <- c("vc.asreml", class(vv))
  return(vv)
}

#' @export
print.vc.asreml  <- function(x, dig=4, ...){

  class(x) <- class(x)[-1] # remove vc.asreml

  # Use 2 signif decimals for z.ratio
  x$z.ratio <- signif(x$z.ratio, 2)

  x[] <- lapply(x, lucid, dig)

  # Rename for printing.
  cn <- colnames(x)
  cn[cn=="constraint"] <- "constr"
  colnames(x) <- cn

  # Shorten constraint to 3-letter code
  levels(x$constr)[levels(x$constr)=="Fixed"] <- "fix"
  levels(x$constr)[levels(x$constr)=="Boundary"] <- "bnd "
  levels(x$constr)[levels(x$constr)=="Positive"] <- "pos"
  levels(x$constr)[levels(x$constr)=="Unconstrained"] <- "unc"

  print(x, row.names=FALSE) # Do not print row numbers
  invisible(x)
}

# ----- lme -----

#' @rdname vc
#' @importFrom nlme VarCorr
#' @export
vc.lme <- function(object, ...) {

  vv <- VarCorr(object)
  vv <- as.matrix(vv)

  # Convert from text to numeric matrix, then to data.frame
  # In the agridat::yates.oats examples, we had row names like this:
  # "block =" "(Intercept)" "gen =" "(Intercept)" "Residual"
  # So we use make.unique to prevent a warning about duplicated levels
  nm <- make.unique(rownames(vv))
  nm <- factor(nm, levels=nm) # prevent alphanum sorting later

  v2 <- apply(vv, 2, function(x) suppressWarnings(as.numeric(x)))
  v2 <- as.data.frame(v2)
  v2 <- cbind(effect=nm, v2)
  rownames(v2) <- NULL

  names(v2) <- tolower(names(v2))

  class(v2) <- c("vc.lme", class(v2))
  return(v2)
}

#' @export
print.vc.lme <- function(x, dig=4, ...) {
  class(x) <- class(x)[-1] # remove vc.lme
  x[] <- lapply(x, lucid, dig, ...)
  print(x, quote=FALSE, row.names=FALSE)
  invisible(x)
}

# ----- lme4 -----

#' @rdname vc
#' @importFrom nlme VarCorr
#' @export
vc.glmerMod <- function(object, ...) {
  dd <- as.data.frame(VarCorr(object))
  class(dd) <- c("vc.lmerMod", class(dd))
  return(dd)

}

#' @rdname vc
#' @importFrom nlme VarCorr
#' @export
vc.lmerMod <- function(object, ...) {
  dd <- as.data.frame(VarCorr(object))
  # Remove <NA>
  class(dd) <- c("vc.lmerMod", class(dd))
  return(dd)
}

#' @export
print.vc.lmerMod <- function(x, dig=4, ...){
  class(x) <- class(x)[-1] # remove vc.lmerMod
  x[] <- lapply(x, lucid, dig, ...)

  # Replace NA_character_ with ""

  # x[] <- lapply(x, function(xx) { gsub("<NA>", "", xx) })
  # x[] <- lapply(x, function(xx) { xx[is.na(xx)] <- "" })

  print(x, row.names=FALSE)
  invisible(x)
}

# ----- mcmc.list -----

#' @rdname vc
#' @param quantiles The quantiles to use for printing mcmc.list objects
#' @export
vc.mcmc.list <- function(object, quantiles=c(0.025, 0.5, 0.975), ...) {
  s <- summary(object, quantiles=quantiles)
  if(is.matrix(s$statistics)) {
    dd <- cbind(as.data.frame(s$statistics[,c("Mean","SD")]),
                s$quantiles[,1],
                s$quantiles[,2],
                s$quantiles[,3])
  } else { # only 1 row (which is not a matrix)

    dd <- cbind(as.data.frame(t(s$statistics[c("Mean","SD")])),
                s$quantiles[1],
                s$quantiles[2],
                s$quantiles[3])
    rownames(dd) <- "" # variable name is not available !
  }
  colnames(dd) <- c('Mean','SD','2.5%','Median','97.5%')
  class(dd) <- c("vc.mcmc.list", class(dd))
  return(dd)       
}

#' @export
print.vc.mcmc.list <- function(x, dig=4, ...){
  class(x) <- class(x)[-1] # remove vc.mcmc.list
  x[] <- lapply(x, lucid, dig, ...)
  print(x)
  invisible()
}


# ----- tests -----

if(FALSE) {

  require("nlme")
  #data(Rail)
  m1n <- lme(travel~1, random=~1|Rail, data=Rail)
  vc(m1n)

  require("lme4")
  m1l <- lmer(travel~1 + (1|Rail), data=Rail)
  vc(m1l)

  require("asreml")
  m1a <- asreml(travel~1, random=~Rail, data=Rail)
  vc(m1a)
  
}
