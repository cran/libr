## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  library(libr)
#  
#  # Create temp directory
#  tmp <- tempdir()
#  
#  # Save some data to temp directory
#  # for illustration purposes
#  saveRDS(trees, file.path(tmp, "trees.rds"))
#  saveRDS(rock, file.path(tmp, "rocks.rds"))
#  
#  # Create library
#  libname(dat, tmp)
#  # library 'dat': 2 items
#  # - attributes: not loaded
#  # - path: C:\Users\User\AppData\Local\Temp\RtmpCSJ6Gc
#  # - items:
#  #    Name Extension Rows Cols   Size        LastModified
#  # 1 rocks       rds   48    4 3.1 Kb 2020-11-05 23:25:34
#  # 2 trees       rds   31    3 2.4 Kb 2020-11-05 23:25:34
#  
#  # Examine data dictionary for library
#  dictionary(dat)
#  # A tibble: 7 x 9
#  #   Name  Column Class   Label Description Format Width  Rows   NAs
#  #   <chr> <chr>  <chr>   <lgl> <lgl>       <lgl>  <lgl> <int> <int>
#  # 1 rocks area   integer NA    NA          NA     NA       48     0
#  # 2 rocks peri   numeric NA    NA          NA     NA       48     0
#  # 3 rocks shape  numeric NA    NA          NA     NA       48     0
#  # 4 rocks perm   numeric NA    NA          NA     NA       48     0
#  # 5 trees Girth  numeric NA    NA          NA     NA       31     0
#  # 6 trees Height numeric NA    NA          NA     NA       31     0
#  # 7 trees Volume numeric NA    NA          NA     NA       31     0
#  
#  # Load library
#  lib_load(dat)
#  
#  # Examine workspace
#  ls()
#  # [1] "dat" "dat.rocks" "dat.trees" "tmp"
#  
#  # Use data from the library
#  summary(dat.rocks)
#  #      area            peri            shape              perm
#  # Min.   : 1016   Min.   : 308.6   Min.   :0.09033   Min.   :   6.30
#  # 1st Qu.: 5305   1st Qu.:1414.9   1st Qu.:0.16226   1st Qu.:  76.45
#  # Median : 7487   Median :2536.2   Median :0.19886   Median : 130.50
#  # Mean   : 7188   Mean   :2682.2   Mean   :0.21811   Mean   : 415.45
#  # 3rd Qu.: 8870   3rd Qu.:3989.5   3rd Qu.:0.26267   3rd Qu.: 777.50
#  # Max.   :12212   Max.   :4864.2   Max.   :0.46413   Max.   :1300.00
#  
#  # Add data to the library
#  dat.trees_subset <- subset(dat.trees, Girth > 11)
#  
#  # Add more data to the library
#  dat.cars <- mtcars
#  
#  # Unload the library from memory
#  lib_unload(dat)
#  
#  # Examine workspace again
#  ls()
#  # [1] "dat" "tmp"
#  
#  # Write the library to disk
#  lib_write(dat)
#  # library 'dat': 4 items
#  # - attributes: not loaded
#  # - path: C:\Users\User\AppData\Local\Temp\RtmpCSJ6Gc
#  # - items:
#  #           Name Extension Rows Cols   Size        LastModified
#  # 1        rocks       rds   48    4 3.1 Kb 2020-11-05 23:37:45
#  # 2        trees       rds   31    3 2.4 Kb 2020-11-05 23:37:45
#  # 3         cars       rds   32   11 7.3 Kb 2020-11-05 23:37:45
#  # 4 trees_subset       rds   23    3 1.8 Kb 2020-11-05 23:37:45
#  
#  # Clean up
#  lib_delete(dat)
#  
#  # Examine workspace again
#  ls()
#  # [1] "tmp"

