# lucid 1.8

Add rmarkdown to Suggests (request of CRAN)

## test environments

* local R 4.0. on Windows 10
* win-builder devel
* rhub

## RCMD check results

No warnings or errors.


# lucid 1.7

Minor update to fix testthat case broken by lme4 update.

## test environments

* local R 3.5.2 on Windows 7
* win-builder release 3.5.2
* win-builder devel (2018-08-22 r75177)

## R CMD check results

There was 1 NOTE:

Found the following (possibly) invalid URLs:
  URL: https://doi.org/10.2307/2344922
    From: inst/doc/lucid_examples.html
    Status: 403
    Message: Forbidden
    
This URL works fine in my browser, which "sometimes happens" according to https://cran.r-project.org/web/packages/URL_checks.html
Please let me know if I should do something differently.

# lucid 1.6

## test environments

* local R 3.5.1 on Windows 7
* win-builder release 3.5.1
* win-builder devel (2018-08-22 r75177)

## R CMD check results

There were no ERRORs or WARNINGs.  One note about a correctly-spelled abbreviation:
```
Possibly mis-spelled words in DESCRIPTION:
  JSM (12:17)
```

## Downstream dependencies

No ERRORs or WARNINGs found :)


# lucid 1.4

## test environments

* local R 3.3.1 on Windows 7
* win-builder release 3.3.1
* win-builder devel 3.4.0

## R CMD check results

There were no ERRORs, or WARNINGs or NOTEs.
