## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  library(libr)
#  
#  # Comparing of NULLs and NA
#  NULL %eq% NULL        # TRUE
#  NULL %eq% NA          # FALSE
#  NA %eq% NA            # TRUE
#  1 %eq% NULL           # FALSE
#  1 %eq% NA             # FALSE
#  
#  # Comparing of atomic values
#  1 %eq% 1              # TRUE
#  "one" %eq% "one"      # TRUE
#  1 %eq% "one"          # FALSE
#  1 %eq% Sys.Date()     # FALSE
#  
#  # Comparing of vectors
#  v1 <- c("A", "B", "C")
#  v2 <- c("A", "B", "C", "D")
#  v1 %eq% v1            # TRUE
#  v1 %eq% v2            # FALSE
#  
#  # Comparing of data frames
#  mtcars %eq% mtcars    # TRUE
#  mtcars %eq% iris      # FALSE
#  iris %eq% iris[1:50,] # FALSE
#  
#  # Mixing it up
#  mtcars %eq% NULL      # FALSE
#  v1 %eq% NA            # FALSE
#  1 %eq% v1             # FALSE

