## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  library(libr)
#  
#  # Add some columns to mtcars using data step logic
#  df <- datastep(mtcars[1:10, 1:3], {
#  
#      if (mpg >= 20)
#        mpgcat <- "High"
#      else
#        mpgcat <- "Low"
#  
#      recdt <- as.Date("1974-06-10")
#  
#      if (cyl == 8)
#        is8cyl <- TRUE
#  
#    })
#  
#  # View results
#  df
#  #                    mpg cyl  disp      recdt mpgcat is8cyl
#  # Mazda RX4         21.0   6 160.0 1974-06-10   High     NA
#  # Mazda RX4 Wag     21.0   6 160.0 1974-06-10   High     NA
#  # Datsun 710        22.8   4 108.0 1974-06-10   High     NA
#  # Hornet 4 Drive    21.4   6 258.0 1974-06-10   High     NA
#  # Hornet Sportabout 18.7   8 360.0 1974-06-10    Low   TRUE
#  # Valiant           18.1   6 225.0 1974-06-10    Low     NA
#  # Duster 360        14.3   8 360.0 1974-06-10    Low   TRUE
#  # Merc 240D         24.4   4 146.7 1974-06-10   High     NA
#  # Merc 230          22.8   4 140.8 1974-06-10   High     NA
#  # Merc 280          19.2   6 167.6 1974-06-10    Low     NA
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  library(libr)
#  
#  # Keep and order output columns
#  df <- datastep(mtcars[1:10,],
#    keep = c("mpg", "cyl", "disp", "mpgcat", "recdt"), {
#  
#      if (mpg >= 20)
#        mpgcat <- "High"
#      else
#        mpgcat <- "Low"
#  
#      recdt <- as.Date("1974-06-10")
#  
#      if (cyl == 8)
#        is8cyl <- TRUE
#  
#    })
#  
#  df
#  #                    mpg cyl  disp mpgcat      recdt
#  # Mazda RX4         21.0   6 160.0   High 1974-06-10
#  # Mazda RX4 Wag     21.0   6 160.0   High 1974-06-10
#  # Datsun 710        22.8   4 108.0   High 1974-06-10
#  # Hornet 4 Drive    21.4   6 258.0   High 1974-06-10
#  # Hornet Sportabout 18.7   8 360.0    Low 1974-06-10
#  # Valiant           18.1   6 225.0    Low 1974-06-10
#  # Duster 360        14.3   8 360.0    Low 1974-06-10
#  # Merc 240D         24.4   4 146.7   High 1974-06-10
#  # Merc 230          22.8   4 140.8   High 1974-06-10
#  # Merc 280          19.2   6 167.6    Low 1974-06-10
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  library(libr)
#  
#  df <- datastep(mtcars[1:10, ],
#                 drop = c("disp", "hp", "drat", "qsec",
#                          "vs", "am", "gear", "carb"),
#                 retain = list(cumwt = 0 ),
#                 rename = c(mpg = "MPG", cyl = "Cylinders", wt = "Wgt",
#                            cumwt = "Cumulative Wgt"), {
#  
#    cumwt <- cumwt + wt
#  
#   })
#  
#  df
#  #                    MPG Cylinders   Wgt Cumulative Wgt
#  # Mazda RX4         21.0         6 2.620          2.620
#  # Mazda RX4 Wag     21.0         6 2.875          5.495
#  # Datsun 710        22.8         4 2.320          7.815
#  # Hornet 4 Drive    21.4         6 3.215         11.030
#  # Hornet Sportabout 18.7         8 3.440         14.470
#  # Valiant           18.1         6 3.460         17.930
#  # Duster 360        14.3         8 3.570         21.500
#  # Merc 240D         24.4         4 3.190         24.690
#  # Merc 230          22.8         4 3.150         27.840
#  # Merc 280          19.2         6 3.440         31.280
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  library(libr)
#  
#  # Identify start and end of by-groups
#  df <- datastep(mtcars[1:10,],
#    keep = c("mpg", "cyl", "gear", "grp"),
#    by = c("gear"), sort_check = FALSE, {
#  
#      if (first. & last.)
#        grp <- "Start - End"
#      else if (first.)
#        grp <- "Start"
#      else if (last.)
#        grp <- "End"
#      else
#        grp <- "-"
#  
#    })
#  
#  df
#  #                    mpg cyl gear   grp
#  # Mazda RX4         21.0   6    4 Start
#  # Mazda RX4 Wag     21.0   6    4     -
#  # Datsun 710        22.8   4    4   End
#  # Hornet 4 Drive    21.4   6    3 Start
#  # Hornet Sportabout 18.7   8    3     -
#  # Valiant           18.1   6    3     -
#  # Duster 360        14.3   8    3   End
#  # Merc 240D         24.4   4    4 Start
#  # Merc 230          22.8   4    4     -
#  # Merc 280          19.2   6    4   End
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  library(libr)
#  
#  # Categorize mpg as above or below the mean
#  df <- datastep(mtcars,
#    keep = c("mpg", "cyl", "mean_mpg", "mpgcat"),
#    calculate = { mean_mpg = mean(mpg) },
#    {
#  
#      if (mpg >= mean_mpg)
#        mpgcat <- "High"
#      else
#        mpgcat <- "Low"
#  
#    })
#  
#  df[1:10,]
#  #                    mpg cyl mean_mpg mpgcat
#  # Mazda RX4         21.0   6 20.09062   High
#  # Mazda RX4 Wag     21.0   6 20.09062   High
#  # Datsun 710        22.8   4 20.09062   High
#  # Hornet 4 Drive    21.4   6 20.09062   High
#  # Hornet Sportabout 18.7   8 20.09062    Low
#  # Valiant           18.1   6 20.09062    Low
#  # Duster 360        14.3   8 20.09062    Low
#  # Merc 240D         24.4   4 20.09062   High
#  # Merc 230          22.8   4 20.09062   High
#  # Merc 280          19.2   6 20.09062    Low
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  library(libr)
#  library(dplyr)
#  library(magrittr)
#  
#  # Add datastep to dplyr pipeline
#  df <- mtcars %>%
#    select(mpg, cyl, gear) %>%
#    mutate(mean_mpg = mean(mpg)) %>%
#    datastep({
#  
#      if (mpg >= mean_mpg)
#        mpgcat <- "High"
#      else
#        mpgcat <- "Low"
#  
#    }) %>%
#    filter(row_number() <= 10)
#  
#  df
#  #     mpg cyl gear mean_mpg mpgcat
#  # 1  21.0   6    4 20.09062   High
#  # 2  21.0   6    4 20.09062   High
#  # 3  22.8   4    4 20.09062   High
#  # 4  21.4   6    3 20.09062   High
#  # 5  18.7   8    3 20.09062    Low
#  # 6  18.1   6    3 20.09062    Low
#  # 7  14.3   8    3 20.09062    Low
#  # 8  24.4   4    4 20.09062   High
#  # 9  22.8   4    4 20.09062   High
#  # 10 19.2   6    4 20.09062    Low
#  

