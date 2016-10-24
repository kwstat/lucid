# test_vc.R
# Time-stamp: <24 Oct 2016 13:10:27 c:/x/rpack/lucid/tests/testthat/test_vc.r>

test_that("nlme", {
  require(nlme)
  data(Rail)
  m1n <- lme(travel~1, random=~1|Rail, data=Rail)
  expect_equal(
    vc(m1n),
      structure(list(effect = structure(1:2, .Label = c("(Intercept)", 
"Residual"), class = "factor"), variance = c(615.31111, 16.16667
), stddev = c(24.805465, 4.020779)), .Names = c("effect", "variance", 
"stddev"), row.names = c(NA, -2L), class = c("vc.lme", "data.frame"
))
)
  })

# ----------------------------------------------------------------------------

test_that("lme4", {
  require("lme4")
  m1l <- lmer(travel~1 + (1|Rail), data=Rail)
  expect_equal(
    vc(m1l),
    structure(list(grp = c("Rail", "Residual"), var1 = c("(Intercept)", 
NA), var2 = c(NA_character_, NA_character_), vcov = c(615.311112033272, 
16.166666656695), sdcor = c(24.8054653661904, 4.02077935936493
)), .Names = c("grp", "var1", "var2", "vcov", "sdcor"), row.names = c(NA, 
-2L), class = c("vc.lmerMod", "data.frame"))
)})

# ----------------------------------------------------------------------------


test_that("asreml", {
  if(require("asreml")){
    m1a <- asreml(travel~1, random=~Rail, data=Rail)
    expect_equal(
      vc(m1a),
      structure(list(effect = structure(1:2, .Label = c("Rail!Rail.var", 
"R!variance"), class = "factor"), component = c(615.311112137509, 
16.1666666936318), std.error = c(392.571310927633, 6.60001404567893
), z.ratio = c(1.56738685433622, 2.44948974074021), constraint = structure(c(1L, 
1L), .Names = c("Rail!Rail.var", "R!variance"), .Label = "Positive", class = "factor")), .Names = c("effect", 
"component", "std.error", "z.ratio", "constraint"), row.names = c(NA, 
-2L), class = c("vc.asreml", "data.frame"))
)}})
  
