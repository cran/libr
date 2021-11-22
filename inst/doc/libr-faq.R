## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

options(rmarkdown.html_vignette.check_title = FALSE)


## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  libname(mylib, "c:/mypath/mydata", "csv")
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  lib_load(mylib)

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  summary(mylib.dat1$var1)

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  lib_write(mylib)

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  lib_unload(mylib)

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  libname(mylib, "c:/mypath/mydata", "csv", filter = "a*")
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  libname(mylib, "c:/mypath/mydata", "csv", filter = c("a*", "b*"))
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  # Create libname
#  libname(mylib, "c:/mypath/mydata", "csv")
#  
#  # Get dictionary
#  d <- dictionary(mylib)
#  
#  # View dictionary
#  # View(d)

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  libname(libA, "c:/mypath/mydata1", "sas7bdat")
#  libname(libB, "c:/mypath/mydata2", "csv")
#  
#  lib_add(libB, libA$dat1, name = "dat1")
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  # Create libname
#  libname(lib1, "c:/mypath/mydata1", "csv")
#  
#  # Copy to a new location
#  lib_copy(lib1, lib2, "c:/mypath/mydata2")

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  library(dplyr)
#  library(libr)
#  
#  # Define data library
#  libname(dat, "./data", "csv")
#  
#  # Loads data into workspace
#  lib_load(dat)
#  
#  # Prepare data
#  dm_mod <- dat.DM %>%
#    select(USUBJID, SEX, AGE, ARM) %>%
#    filter(ARM != "SCREEN FAILURE") %>%
#    datastep({
#  
#      if (AGE >= 18 & AGE <= 24)
#        AGECAT = "18 to 24"
#      else if (AGE >= 25 & AGE <= 44)
#        AGECAT = "25 to 44"
#      else if (AGE >= 45 & AGE <= 64)
#        AGECAT <- "45 to 64"
#      else if (AGE >= 65)
#        AGECAT <- ">= 65"
#  
#    })
#  
#  lib_unload(dat)

