# test_vc.R
# Time-stamp: <25 Apr 2017 15:19:30 c:/x/rpack/lucid/tests/testthat/test_vc.R>

context("test_vc.R")

require(lucid)
data(Rail, package="nlme")

# ----------------------------------------------------------------------------

test_that("default", {
  expect_error(vc(1))
})

test_that("nlme", {
  require(nlme)
  m1n <- lme(travel~1, random=~1|Rail, data=Rail)
  expect_equal(
    vc(m1n),
      structure(list(effect = structure(1:2, .Label = c("(Intercept)", 
"Residual"), class = "factor"), variance = c(615.31111, 16.16667
), stddev = c(24.805465, 4.020779)), .Names = c("effect", "variance", 
"stddev"), row.names = c(NA, -2L), class = c("vc.lme", "data.frame"
))
)

  # print method
  print(vc(m1n))
})

# ----------------------------------------------------------------------------

test_that("lmer", {
  require("lme4")
  m1l <- lmer(travel~1 + (1|Rail), data=Rail)
  expect_equal(
    vc(m1l),
    structure(list(grp = c("Rail", "Residual"), var1 = c("(Intercept)", 
NA), var2 = c(NA_character_, NA_character_), vcov = c(615.311112033272, 
16.166666656695), sdcor = c(24.8054653661904, 4.02077935936493
)), .Names = c("grp", "var1", "var2", "vcov", "sdcor"), 
row.names = c(NA, -2L), class = c("vc.lmerMod", "data.frame")))
  
  # print method
  print(vc(m1l))
})

# ----------------------------------------------------------------------------

test_that("glmer", {
  require("lme4")
  m1g <- glmer(travel~1 + (1|Rail), data=Rail, family=gaussian(link="log"))
  expect_equal(
    vc(m1g),
    structure(list(grp = c("Rail", "Residual"), 
                   var1 = c("(Intercept)", NA), 
                   var2 = c(NA_character_, NA_character_), 
                   vcov = c(1.63790513395848, 11.1119267600161), 
                   sdcor = c(1.2798066783536, 3.33345567842383)), 
              .Names = c("grp", "var1", "var2", "vcov", "sdcor"), 
              row.names = c(NA, -2L), class = c("vc.lmerMod", "data.frame")))
  # print
  print(vc(m1g))
})

# ----------------------------------------------------------------------------


test_that("asreml", {
  if(require("asreml")){
    m1a <- asreml(travel~1, random=~Rail, data=Rail)
    expect_equal(
      vc(m1a),
      structure(list(effect = structure(1:2, .Label = c("Rail!Rail.var", 
"R!variance"), class = "factor"), component = c(615.311112137509, 
16.1666666936318), std.error = c(392.571310927633, 6.60001404567893
), z.ratio = c(1.56738685433622, 2.44948974074021), 
constraint = structure(c(1L, 
1L), .Names = c("Rail!Rail.var", "R!variance"), .Label = "Positive", 
class = "factor")), .Names = c("effect", 
"component", "std.error", "z.ratio", "constraint"), row.names = c(NA, 
-2L), class = c("vc.asreml", "data.frame"))
)
  # print method
  print(vc(m1a))
  }})
  
