

# Dictionary Definition ---------------------------------------------------



#' @title Create a Data Dictionary
#' @param x The input library, data frame, or tibble.
#' @description A function to create a data dictionary for a data frame,
#' a tibble, or a data library.  The function will generate a tibble of 
#' information about the data.  The tibble will contain the following columns:
#' \itemize{
#'   \item{\strong{Name:} The name of the data object.}
#'   \item{\strong{Column:} The name of the column.}
#'   \item{\strong{Class:} The class of the column.}
#'   \item{\strong{Label:} The value of the label attribute.}
#'   \item{\strong{Description:} A description applied to this column.}
#'   \item{\strong{Format:} The value of the format attribute.}
#'   \item{\strong{Width:} The value of the width attribute if any have been
#'   assigned.}
#'   \item{\strong{Justify:} The justification or alignment attribute value.}
#'   \item{\strong{Rows:} The number of data rows.}
#'   \item{\strong{NAs:} The number of NA values in this column.}
#'   \item{\strong{MaxChar:} The maximum character length of the
#'    values in this column with no padding.}
#' }
#' @import tibble
#' @seealso \code{\link{libname}} to create a data library.  Also 
#' see the \code{\link{dsattr}} function to set attributes for your 
#' dataset from within a \code{\link{datastep}}.  To render attributes, 
#' see the \strong{fmtr} package.
#' @examples 
#' # Create temp directory
#' tmp <- tempdir()
#' 
#' # Create library
#' libname(dat, tmp)
#' 
#' # Add data to the library
#' lib_add(dat, beaver1)
#' lib_add(dat, iris)
#' 
#' # Examine the dictionary for the library
#' dictionary(dat)
#' # A tibble: 9 x 10
#' #   Name    Column       Class   Label Description Format Width Justify  Rows   NAs MaxChar
#' #   <chr>   <chr>        <chr>   <lgl> <lgl>       <lgl>  <lgl> <lgl>   <int> <int>   <int>
#' # 1 beaver1 day          numeric NA    NA          NA     NA    NA        114     0       3
#' # 2 beaver1 time         numeric NA    NA          NA     NA    NA        114     0       4
#' # 3 beaver1 temp         numeric NA    NA          NA     NA    NA        114     0       5
#' # 4 beaver1 activ        numeric NA    NA          NA     NA    NA        114     0       1
#' # 5 iris    Sepal.Length numeric NA    NA          NA     NA    NA        150     0       3
#' # 6 iris    Sepal.Width  numeric NA    NA          NA     NA    NA        150     0       3
#' # 7 iris    Petal.Length numeric NA    NA          NA     NA    NA        150     0       3
#' # 8 iris    Petal.Width  numeric NA    NA          NA     NA    NA        150     0       3
#' # 9 iris    Species      factor  NA    NA          NA     NA    NA        150     0      10
#' 
#' # Clean up
#' lib_delete(dat)
#' @export
dictionary <- function(x) {
  

  
  if (all(class(x) == "character")) {
    lbnm <- x
    x <- get(lbnm, envir = e$env)
    
  } else {
    
    # Get safe variable name
    lbnm  <- paste(deparse(substitute(x, env = environment())), collapse = "")
  }
  
  if (!any(class(x) == "lib") & !any(class(x) == "data.frame"))
    stop("Input object must be a library or data frame.")
   
  ret <- NULL
  if (any(class(x) == "lib")) {
      
    
    for (nm in names(x)) {
      
      
      if (is.null(ret))
        ret <- getDictionary(x[[nm]], nm)
      else 
        ret <- rbind(ret, getDictionary(x[[nm]], nm))
      
      
    }
    
  } else {
    
    ret <- getDictionary(x, lbnm)
    
  }
  
  ret <- as_tibble(ret)
  
  return(ret)
}


# Utilities ---------------------------------------------------------------


#' @noRd
getDictionary <- function(x, dsnm) {
  
  ret <- NULL
  rw <- NULL
  usr_wdth <- c()
  str_wdth <- c()
  cntr <- 0
  
  for (nm in names(x)) {
    
    cntr <- cntr + 1
    
    lbl <- attr(x[[nm]], "label")
    desc <- attr(x[[nm]], "description")
    fmt <- paste(as.character(attr(x[[nm]], "format")), collapse = "\n")
    jst <- attr(x[[nm]], "justify")
    wdth <- attr(x[[nm]], "width")
    
    if (fmt == "")
      fmt <- NA
    
    if (length(x[[nm]]) > 0) {
      if (typeof(x[[nm]]) == "character")
        str_wdth[cntr] <-  suppressWarnings(max(nchar(x[[nm]]), na.rm = TRUE))
      else 
        str_wdth[cntr] <-  suppressWarnings(max(nchar(as.character(x[[nm]])), 
                                                na.rm = TRUE))
      
      if (is.na(str_wdth[cntr]) | str_wdth[cntr] == -Inf)
        str_wdth[cntr] <- 0
        
    } else {
      str_wdth[cntr] <- NA
    }
    
    rw <- data.frame(Name = dsnm,
                     Column = nm,
                     Class = paste0(class(x[[nm]]), collapse = " "),
                     Label = ifelse(!is.null(lbl), lbl, as.character(NA)),
                     Description = ifelse(!is.null(desc), desc, as.character(NA)),
                     Format = ifelse(!is.null(fmt), fmt, NA),
                     Width = ifelse(!is.null(wdth), wdth, NA),
                     Justify = ifelse(!is.null(jst), jst, as.character(NA)),
                     Rows = nrow(x),
                     NAs = sum(is.na(x[[nm]])),
                     MaxChar = str_wdth[cntr])
                    
    if (is.null(ret))
      ret <- rw
    else 
      ret <- rbind(ret, rw)
    
  }
  
  
  return(ret)
  
}



