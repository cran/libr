## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  library(libr)
#  
#  # Get path to sample data
#  pkg <- system.file("extdata", package = "libr")
#  
#  # Define data library
#  libname(sdtm, pkg, "csv")
#  
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  # View a dataset
#  sdtm$DM
#  # # A tibble: 87 × 24
#  #    STUDYID DOMAIN USUBJID SUBJID RFSTDTC    RFENDTC RFXSTDTC RFXENDTC RFICDTC    RFPENDTC
#  #    <chr>   <chr>  <chr>   <chr>  <date>     <date>  <lgl>    <lgl>    <date>     <date>
#  #  1 ABC     DM     ABC-01… 049    2006-11-07 NA      NA       NA       2006-10-25 NA
#  #  2 ABC     DM     ABC-01… 050    2006-11-02 NA      NA       NA       2006-10-25 NA
#  #  3 ABC     DM     ABC-01… 051    2006-11-02 NA      NA       NA       2006-10-25 NA
#  #  4 ABC     DM     ABC-01… 052    2006-11-06 NA      NA       NA       2006-10-31 NA
#  #  5 ABC     DM     ABC-01… 053    2006-11-08 NA      NA       NA       2006-11-01 NA
#  #  6 ABC     DM     ABC-01… 054    2006-11-16 NA      NA       NA       2006-11-07 NA
#  #  7 ABC     DM     ABC-01… 055    2006-12-06 NA      NA       NA       2006-10-31 NA
#  #  8 ABC     DM     ABC-01… 056    2006-11-28 NA      NA       NA       2006-11-21 NA
#  #  9 ABC     DM     ABC-01… 113    2006-12-05 NA      NA       NA       2006-11-28 NA
#  # 10 ABC     DM     ABC-01… 114    2006-12-14 NA      NA       NA       2006-12-01 NA
#  # #  77 more rows
#  # #  14 more variables: DTHDTC <lgl>, DTHFL <lgl>, SITEID <chr>, BRTHDTC <date>, AGE <dbl>,
#  # #   AGEU <chr>, SEX <chr>, RACE <chr>, ETHNIC <chr>, ARMCD <chr>, ARM <chr>, ACTARMCD <lgl>,
#  # #   ACTARM <lgl>, COUNTRY <lgl>
#  # #  Use `print(n = ...)` to see more rows
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  
#  lib_load(sdtm)
#  # # library 'sdtm': 8 items
#  # - attributes: csv loaded
#  # - path: C:/packages/libr/inst/extdata
#  # - items:
#  #   Name Extension Rows Cols     Size        LastModified
#  # 1   AE       csv  150   27  88.1 Kb 2020-09-18 14:30:23
#  # 2   DA       csv 3587   18 527.8 Kb 2020-09-18 14:30:23
#  # 3   DM       csv   87   24  45.1 Kb 2020-09-18 14:30:23
#  # 4   DS       csv  174    9  33.7 Kb 2020-09-18 14:30:23
#  # 5   EX       csv   84   11    26 Kb 2020-09-18 14:30:23
#  # 6   IE       csv    2   14    13 Kb 2020-09-18 14:30:23
#  # 7   SV       csv  685   10  69.9 Kb 2020-09-18 14:30:24
#  # 8   VS       csv 3358   17   467 Kb 2020-09-18 14:30:24
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  # Get total number of records
#  nrow(sdtm.DM)
#  # [1] 87
#  
#  # Get frequency counts for each arm
#  table(sdtm.DM$ARM)
#  # ARM A          ARM B          ARM C          ARM D SCREEN FAILURE
#  # 20             21             21             23              2

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  dictionary(sdtm)
#  # # A tibble: 130 x 10
#  #    Name  Column  Class     Label Description Format Width Justify  Rows   NAs
#  #    <chr> <chr>   <chr>     <chr> <chr>       <lgl>  <int> <chr>   <int> <int>
#  #  1 AE    STUDYID character NA    NA          NA         3 NA        150     0
#  #  2 AE    DOMAIN  character NA    NA          NA         2 NA        150     0
#  #  3 AE    USUBJID character NA    NA          NA        10 NA        150     0
#  #  4 AE    AESEQ   numeric   NA    NA          NA        NA NA        150     0
#  #  5 AE    AETERM  character NA    NA          NA        72 NA        150     0
#  #  6 AE    AELLT   logical   NA    NA          NA        NA NA        150   150
#  #  7 AE    AELLTCD logical   NA    NA          NA        NA NA        150   150
#  #  8 AE    AEDECOD character NA    NA          NA        43 NA        150     0
#  #  9 AE    AEPTCD  numeric   NA    NA          NA        NA NA        150     0
#  # 10 AE    AEHLT   character NA    NA          NA        63 NA        150     0
#  # # ... with 120 more rows
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  age_groups <- datastep(sdtm.DM,
#                         keep = c("USUBJID", "AGE", "AGEG"), {
#  
#                           if (AGE >= 18 & AGE <= 29)
#                             AGEG <- "18 to 29"
#                           else if (AGE >= 30 & AGE <= 44)
#                             AGEG <- "30 to 44"
#                           else if (AGE >= 45 & AGE <= 59)
#                             AGEG <- "45 to 59"
#                           else
#                             AGEG <- "60+"
#  
#                         })
#  age_groups
#  # # A tibble: 87 x 3
#  #    USUBJID      AGE AGEG
#  #    <chr>      <dbl> <chr>
#  #  1 ABC-01-049    39 30 to 44
#  #  2 ABC-01-050    47 45 to 59
#  #  3 ABC-01-051    34 30 to 44
#  #  4 ABC-01-052    45 45 to 59
#  #  5 ABC-01-053    26 18 to 29
#  #  6 ABC-01-054    44 30 to 44
#  #  7 ABC-01-055    47 45 to 59
#  #  8 ABC-01-056    31 30 to 44
#  #  9 ABC-01-113    74 60+
#  # 10 ABC-01-114    72 60+
#  # # ... with 77 more rows

