# lucid 1.9  unpublished

* Switch to MIT license.


todo. matrix is printed with quotes, but tibble does NOT.  But tibbles
are only printing 6 rows. Maybe the "pillar" package could help?

as.matrix(mtcars) %>% lucid
as.matrix(mtcars) %>% as_tibble


# lucid 1.8 (2021-04-01)

* Add method for `sommer::mmer` objects.


# lucid 1.7 (2019-02-06)

* Fix test case to accommodate changes in `lme4` output.


# lucid 1.6 (2018-08-24)

* `lucid()` now converts tibbles to data.frames before formatting.


# lucid 1.4 (2016-10-25)

* Added logo, JSM poster & paper to github.

* Changed vignette from Rnw to Rmd.

* Switched to `roxygen2` documentation.

* Now using `testthat` and `covr` packages.


# lucid 1.3 (2015-07-03)

* Namespace changes due to R devel changes.


# lucid 1.2 (2015-04-14)

* Added `vc.mcmc.list()` for prettier summaries from JAGS.


# lucid 1.1 (2015-02-11)

* Re-worked code.  Primary objective is formatting, not printing.

* Added `na.replace` option.


# lucid 1.0 (2014-11-26)

* First release to CRAN, Nov 2014.


# lucid 0.0 (2010-03-01)

* Development begins

