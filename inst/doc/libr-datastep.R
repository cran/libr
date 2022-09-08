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

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  library(libr)
#  
#  # Assign label attributes to all columns
#  df <- datastep(mtcars[1:10, ],
#                 keep = c("mpg", "cyl", "mpgcat"),
#                 calculate = { mean_mpg = mean(mpg) },
#                 attrib = list(mpg = dsattr(label = "Miles Per Gallon"),
#                               cyl = dsattr(label = "Cylinders"),
#                               mpgcat = dsattr(label = "Mileage Category")), {
#  
#      if (mpg >= mean_mpg)
#        mpgcat <- "High"
#      else
#        mpgcat <- "Low"
#  
#    })
#  
#  # View attributes in dictionary
#  dictionary(df)
#  # # A tibble: 3 x 10
#  #   Name  Column Class     Label            Description Format Width Justify  Rows   NAs
#  #   <chr> <chr>  <chr>     <chr>            <chr>       <lgl>  <int> <chr>   <int> <int>
#  # 1 df    mpg    numeric   Miles Per Gallon NA          NA        NA NA         10     0
#  # 2 df    cyl    numeric   Cylinders        NA          NA        NA NA         10     0
#  # 3 df    mpgcat character Mileage Category NA          NA         4 NA         10     0
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  AirPassengers
#  #      Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
#  # 1949 112 118 132 129 121 135 148 148 136 119 104 118
#  # 1950 115 126 141 135 125 149 170 170 158 133 114 140
#  # 1951 145 150 178 163 172 178 199 199 184 162 146 166
#  # 1952 171 180 193 181 183 218 230 242 209 191 172 194
#  # 1953 196 196 236 235 229 243 264 272 237 211 180 201
#  # 1954 204 188 235 227 234 264 302 293 259 229 203 229
#  # 1955 242 233 267 269 270 315 364 347 312 274 237 278
#  # 1956 284 277 317 313 318 374 413 405 355 306 271 306
#  # 1957 315 301 356 348 355 422 465 467 404 347 305 336
#  # 1958 340 318 362 348 363 435 491 505 404 359 310 337
#  # 1959 360 342 406 396 420 472 548 559 463 407 362 405
#  # 1960 417 391 419 461 472 535 622 606 508 461 390 432
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  library(libr)
#  
#  # Create AirPassengers Data Frame
#  df <- as.data.frame(t(matrix(AirPassengers, 12,
#                      dimnames = list(month.abb, seq(1949, 1960)))),
#                      stringsAsFactors = FALSE)
#  
#  # Use datastep array to get year tot, mean, and top month
#  dat <- datastep(df,
#                  arrays = list(months = dsarray(names(df))),
#                  attrib = list(Tot = 0, Mean = 0, Top = ""),
#                  drop = "mth",
#                  {
#  
#                    Tot <- sum(months[])
#                    Mean <- mean(months[])
#  
#                    for (mth in months) {
#                      if (months[mth] == max(months[])) {
#                        Top <- mth
#                      }
#                    }
#                  })
#  
#  
#  dat
#  #      Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec  Tot     Mean Top
#  # 1949 112 118 132 129 121 135 148 148 136 119 104 118 1520 126.6667 Aug
#  # 1950 115 126 141 135 125 149 170 170 158 133 114 140 1676 139.6667 Aug
#  # 1951 145 150 178 163 172 178 199 199 184 162 146 166 2042 170.1667 Aug
#  # 1952 171 180 193 181 183 218 230 242 209 191 172 194 2364 197.0000 Aug
#  # 1953 196 196 236 235 229 243 264 272 237 211 180 201 2700 225.0000 Aug
#  # 1954 204 188 235 227 234 264 302 293 259 229 203 229 2867 238.9167 Jul
#  # 1955 242 233 267 269 270 315 364 347 312 274 237 278 3408 284.0000 Jul
#  # 1956 284 277 317 313 318 374 413 405 355 306 271 306 3939 328.2500 Jul
#  # 1957 315 301 356 348 355 422 465 467 404 347 305 336 4421 368.4167 Aug
#  # 1958 340 318 362 348 363 435 491 505 404 359 310 337 4572 381.0000 Aug
#  # 1959 360 342 406 396 420 472 548 559 463 407 362 405 5140 428.3333 Aug
#  # 1960 417 391 419 461 472 535 622 606 508 461 390 432 5714 476.1667 Jul
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  # Prepare sample data
#  dat <- as.data.frame(HairEyeColor)
#  
#  # Filter for black hair and blue eyes
#  res <- datastep(dat,
#                  where = expression(Hair == "Black" & Eye == "Blue"),
#                  {})
#  
#  res
#  #    Hair  Eye    Sex Freq
#  # 1 Black Blue   Male   11
#  # 2 Black Blue Female    9
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  # Delete rows with frequencies less than 25
#  res1 <- datastep(dat, {
#  
#           if (Freq < 25)
#             delete()
#  
#         })
#  res1
#  #     Hair   Eye    Sex Freq
#  # 1  Black Brown   Male   32
#  # 2  Brown Brown   Male   53
#  # 3  Brown  Blue   Male   50
#  # 4  Blond  Blue   Male   30
#  # 5  Brown Hazel   Male   25
#  # 6  Black Brown Female   36
#  # 7  Brown Brown Female   66
#  # 8  Brown  Blue Female   34
#  # 9  Blond  Blue Female   64
#  # 10 Brown Hazel Female   29
#  
#  # Only output rows for brown-eyes and frequencies over 25
#  res2 <- datastep(dat, {
#  
#            if (Eye == "Brown") {
#              if (Freq >= 25) {
#  
#                output()
#  
#              }
#            }
#  
#          })
#  
#  res2
#  #    Hair   Eye    Sex Freq
#  # 1 Black Brown   Male   32
#  # 2 Brown Brown   Male   53
#  # 3 Black Brown Female   36
#  # 4 Brown Brown Female   66
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  # Create metadata
#  res3 <- datastep(data.frame(), {
#  
#  
#            name <- "mtcars"
#            rows <- nrow(mtcars)
#            cols <- ncol(mtcars)
#            output()
#  
#            name <- "iris"
#            rows <- nrow(iris)
#            cols <- ncol(iris)
#            output()
#  
#  
#            name <- "beaver1"
#            rows <- nrow(beaver1)
#            cols <- ncol(beaver1)
#            output()
#  
#  
#          })
#  
#  res3
#  #      name rows cols
#  # 1  mtcars   32   11
#  # 2    iris  150    5
#  # 3 beaver1  114    4
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  # Create sample data
#  region <- read.table(header = TRUE, text = '
#    REGION   NAME
#    R01      East
#    R02      West
#    R03      North
#    R04      South
#  ', stringsAsFactors = FALSE)
#  
#  # First stores dataset
#  stores1 <- read.table(header = TRUE, text = '
#    ID  NAME             SIZE REGION FRANCHISE
#    A01 "Eastern Lumber"    L    R01        T
#    A02 "Tri-City Hardwood" M    R02        F
#    A05 "Reliable Hardware" S    R01        T
#  ', stringsAsFactors = FALSE)
#  
#  # Extra column on this one
#  stores2 <- read.table(header = TRUE, text = '
#    ID  NAME             SIZE REGION
#    A03 "AAA Mills"         S    R05
#    A04 "Home and Yard"     L    R03
#  ', stringsAsFactors = FALSE)

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  # Set operation
#  allstores <- datastep(stores1, set = stores2, {})
#  
#  # Extra values filled with NA
#  allstores
#  #    ID              NAME SIZE REGION FRANCHISE
#  # 1 A01    Eastern Lumber    L    R01      TRUE
#  # 2 A02 Tri-City Hardwood    M    R02     FALSE
#  # 3 A05 Reliable Hardware    S    R01      TRUE
#  # 4 A03         AAA Mills    S    R05        NA
#  # 5 A04     Home and Yard    L    R03        NA

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  # Create small dataset of missing FRANCHISE values
#  franchises <- data.frame(FRANCHISE = c(F, F), stringsAsFactors = FALSE)
#  franchises
#  #   FRANCHISE
#  # 1     FALSE
#  # 2     FALSE

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  # Merge in missing FRANCHISE column
#  stores2mod <- datastep(stores2, merge = franchises, {})
#  stores2mod
#  #    ID          NAME SIZE REGION FRANCHISE
#  # 1 A03     AAA Mills    S    R05     FALSE
#  # 2 A04 Home and Yard    L    R03     FALSE
#  
#  # Set again
#  allstores <- datastep(stores1, set = stores2mod, {})
#  
#  # Now everything is aligned
#  allstores
#  #    ID              NAME SIZE REGION FRANCHISE
#  # 1 A01    Eastern Lumber    L    R01      TRUE
#  # 2 A02 Tri-City Hardwood    M    R02     FALSE
#  # 3 A05 Reliable Hardware    S    R01      TRUE
#  # 4 A03         AAA Mills    S    R05     FALSE
#  # 5 A04     Home and Yard    L    R03     FALSE
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  
#  # Merge operation - Outer Join
#  res <- datastep(allstores, merge = region,
#                  merge_by = "REGION",
#                  merge_in = c("inA", "inB"), {})
#  
#  # View results
#  res
#  #     ID            NAME.1 SIZE REGION FRANCHISE NAME.2 inA inB
#  # 1  A01    Eastern Lumber    L    R01      TRUE   East   1   1
#  # 2  A05 Reliable Hardware    S    R01      TRUE   East   1   1
#  # 3  A02 Tri-City Hardwood    M    R02     FALSE   West   1   1
#  # 4  A04     Home and Yard    L    R03     FALSE  North   1   1
#  # 5  A03         AAA Mills    S    R05     FALSE   <NA>   1   0
#  # 6 <NA>              <NA> <NA>    R04        NA  South   0   1

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  
#  # Merge operation - Left join and clean up
#  res <- datastep(allstores, merge = region,
#                  merge_by = "REGION",
#                  merge_in = c("inA", "inB"),
#                  rename = c(NAME.1 = "STORE_NAME", NAME.2 = "REGION_NAME"),
#                  where = expression(inA == TRUE),
#                  drop = c("inA", "inB"),
#                  {
#                    if (REGION == "R05") {
#                      REGION <- "R04"
#                      NAME.2 <- "South"
#  
#                    }
#  
#                  })
#  #'
#  # View results
#  res
#  #    ID        STORE_NAME SIZE REGION FRANCHISE REGION_NAME
#  # 1 A01    Eastern Lumber    L    R01      TRUE        East
#  # 2 A05 Reliable Hardware    S    R01      TRUE        East
#  # 3 A02 Tri-City Hardwood    M    R02     FALSE        West
#  # 4 A04     Home and Yard    L    R03     FALSE       North
#  # 5 A03         AAA Mills    S    R04     FALSE       South

