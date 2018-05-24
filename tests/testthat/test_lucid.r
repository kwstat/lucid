# test_lucid.R
# Time-stamp: <25 Apr 2017 15:00:22 c:/x/rpack/lucid/tests/testthat/test_lucid.R>

context("test_lucid.R")

test_that("default", {
  expect_equal(lucid(letters),
               letters)
})

test_that("vector", {
  set.seed(456)
  lvec <- runif(10)
  expect_equal(lucid(lvec), 
               c("0.0896", "0.211 ", "0.733 ", "0.852 ", "0.788 ", "0.332 ", 
                 "0.0824", "0.286 ", "0.238 ", "0.385 "))

  lvec[5] <- NA
  expect_equal(lucid(lvec),
               c("0.0896", "0.211 ", "0.733 ", "0.852 ", "    NA", "0.332 ", 
                 "0.0824", "0.286 ", "0.238 ", "0.385 ")
               )

  lvec <- c(1.23, NA, 123, 123000)
  expect_equal(lucid(lvec),
               c("     1.23", "       NA", "   123   ", "123000   "))

  expect_equal(lucid(lvec, na.value=""),
               c("     1.23", "       ", "   123   ", "123000   "))

  expect_equal(
    lucid(lvec, na.value="--"),
    c("     1.23", "       --", "   123   ", "123000   ")
  )
})

test_that("data.frame", {
  
  ldf <- iris[1:3,3:5]
  expect_equal(
    lucid(ldf),
    structure(list(Petal.Length = c("1.4", "1.4", "1.3"), 
                   Petal.Width = c("0.2", 
"0.2", "0.2"), Species = structure(c(1L, 1L, 1L), .Label = c("setosa", 
"versicolor", "virginica"), class = "factor")), .Names = c("Petal.Length", 
"Petal.Width", "Species"), row.names = c(NA, 3L), class = "data.frame")
)
  
  ldf[2,] <- NA
  expect_equal(
    lucid(ldf),
    structure(list(Petal.Length = c("1.4", " NA", "1.3"), 
                   Petal.Width = c("0.2", 
" NA", "0.2"), Species = structure(c(1L, NA, 1L), .Label = c("setosa", 
"versicolor", "virginica"), class = "factor")), .Names = c("Petal.Length", 
"Petal.Width", "Species"), row.names = c(NA, 3L), class = "data.frame")
)
  
  expect_equal(
    lucid(ldf, na=""),
    structure(list(Petal.Length = c("1.4", " ", "1.3"), Petal.Width = c("0.2", 
" ", "0.2"), Species = structure(c(1L, NA, 1L), .Label = c("setosa", 
"versicolor", "virginica"), class = "factor")), .Names = c("Petal.Length", 
"Petal.Width", "Species"), row.names = c(NA, 3L), class = "data.frame")
)

  expect_equal(
    lucid(ldf, na="--"),
    structure(list(Petal.Length = c("1.4", " --", "1.3"), 
                   Petal.Width = c("0.2", 
" --", "0.2"), Species = structure(c(1L, NA, 1L), .Label = c("setosa", 
"versicolor", "virginica"), class = "factor")), .Names = c("Petal.Length", 
"Petal.Width", "Species"), row.names = c(NA, 3L), class = "data.frame")
)
  
expect_equal(
  lucid(ldf, dig=2, na="--"),
  structure(list(Petal.Length = c("1.4", " --", "1.3"), Petal.Width = c("0.2", 
" --", "0.2"), Species = structure(c(1L, NA, 1L), .Label = c("setosa", 
"versicolor", "virginica"), class = "factor")), .Names = c("Petal.Length", 
"Petal.Width", "Species"), row.names = c(NA, 3L), class = "data.frame")
)

})

test_that("matrix", {
    
  lmat <- as.matrix(mtcars[1:3,1:3])
  lmat[1,1] <- lmat[2,2] <- lmat[3,3] <- NA
  expect_equal(
    lucid(lmat),
    structure(c("  NA", "21  ", "22.8", " 6", "NA", " 4", "160", 
"160", " NA"), .Dim = c(3L, 3L), .Dimnames = list(c("Mazda RX4", 
"Mazda RX4 Wag", "Datsun 710"), c("mpg", "cyl", "disp")))
)

  expect_equal(
    lucid(lmat, na=""),
    structure(c("  ", "21  ", "22.8", " 6", "", " 4", "160", "160", 
" "), .Dim = c(3L, 3L), .Dimnames = list(c("Mazda RX4", "Mazda RX4 Wag", 
"Datsun 710"), c("mpg", "cyl", "disp")))
)

  expect_equal(
    lucid(lmat, na=" -"),
    structure(c("   -", "21  ", "22.8", " 6", " -", " 4", "160", 
"160", "  -"), .Dim = c(3L, 3L), .Dimnames = list(c("Mazda RX4", 
"Mazda RX4 Wag", "Datsun 710"), c("mpg", "cyl", "disp")))
)
  
  expect_equal(
    lucid(lmat, dig=2, na="-"),
    structure(c("-", "21", "23", " 6", "-", " 4", "160", "160", " -"
), .Dim = c(3L, 3L), .Dimnames = list(c("Mazda RX4", "Mazda RX4 Wag", 
"Datsun 710"), c("mpg", "cyl", "disp")))
)
  
  # To omit quotes from matrix output
  expect_equal(
    noquote(lucid(lmat, dig=2, na="-")),
    structure(c("-", "21", "23", " 6", "-", " 4", "160", "160", " -"
), .Dim = c(3L, 3L), .Dimnames = list(c("Mazda RX4", "Mazda RX4 Wag", 
"Datsun 710"), c("mpg", "cyl", "disp")), class = "noquote")
)
  
  #print(lucid(lmat, dig=2, na="-"), quote=FALSE)
})

test_that("list", {

  set.seed(456)
  ll <- list(lvec=runif(10),ldf=iris[1:3,3:5],lmat=as.matrix(mtcars[1:3,1:3]))
  expect_equal(
    lucid(ll),
structure(list(lvec = c("0.0896", "0.211 ", "0.733 ", "0.852 ", 
"0.788 ", "0.332 ", "0.0824", "0.286 ", "0.238 ", "0.385 "), 
    ldf = structure(list(Petal.Length = c("1.4", "1.4", "1.3"
    ), Petal.Width = c("0.2", "0.2", "0.2"), Species = structure(c(1L, 
    1L, 1L), .Label = c("setosa", "versicolor", "virginica"), 
    class = "factor")), .Names = c("Petal.Length", 
    "Petal.Width", "Species"), row.names = c(NA, 3L), class = "data.frame"), 
    lmat = structure(c("21  ", "21  ", "22.8", "6", "6", "4", 
    "160", "160", "108"), .Dim = c(3L, 3L), .Dimnames = list(
        c("Mazda RX4", "Mazda RX4 Wag", "Datsun 710"), c("mpg", 
        "cyl", "disp")))), .Names = c("lvec", "ldf", "lmat"))

)
  
})


test_that("tibble", {
  # when a tibble is printed:
  #   strings with spaces are printed with quotes
  #   strings without spaces have no quotes
  # since lucid uses spaces to align columns of strings, print.tbl_df would
  # strip some quotes, but not others; making lucid results look weird
  prob <- structure(list(id = c("A", "B", "C"), 
                         P0 = c(" a","b","c "),
                         P1 = c(-1, 0, 1), 
                         P2 = c(3.3175e-140, 1.0637e-165, 1.1279e-157)),
                    .Names = c("id","P1", "P2","P3"), 
                    row.names = c(NA, -3L), 
                    class = c("tbl_df", "tbl", "data.frame"))
  
  print(prob)
  
  print(lucid(prob))
  
})
