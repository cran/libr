#' @title Libnames, Data Dictionaries and Data Steps
#'
#' @description 
#' The \strong{libr} package brings the concepts of data libraries, data 
#' dictionaries, and data steps to R.  A data library is an object used to define 
#' and manage
#' an entire directory of data files.  A data dictionary is a data frame full
#' of information about a data library, data frame, or tibble.  And a data step
#' allows row-by-row processing of data.
#' 
#' The functions contained in the \strong{libr} package are as follows:
#' \itemize{
#'   \item{\code{\link{libname}}: Creates a data library}
#'   \item{\code{\link{dictionary}}: Creates a data dictionary}
#'   \item{\code{\link{datastep}}: Perform row-by-row processing of data}
#'   \item{\code{\link{lib_load}}: Loads a library into the workspace}
#'   \item{\code{\link{lib_unload}}: Unloads a library from the workspace}
#'   \item{\code{\link{lib_sync}}: Synchronizes the workspace with the library 
#'   list}
#'   \item{\code{\link{lib_write}}: Writes library data to the file system}
#'   \item{\code{\link{lib_add}}: Adds data to a library}
#'   \item{\code{\link{lib_replace}}: Replaces data in a library}
#'   \item{\code{\link{lib_remove}}: Removes data from a library}
#'   \item{\code{\link{lib_copy}}: Copies a data library}
#'   \item{\code{\link{lib_delete}}: Deletes a data library}
#'   \item{\code{\link{lib_info}}: Returns a data frame of information about the 
#'   library}
#'   \item{\code{\link{lib_path}}: Returns the path of a data library}
#'   \item{\code{\link{lib_size}}: Returns the size of the data library in bytes}
#'   \item{\code{\link{import_spec}}: Defines an import spec for a specific file}
#'   \item{\code{\link{specs}}: Contains all the import specs for a library}
#' }
#' Note that the \strong{libr} package is intended to be used with small and 
#' medium-sized data sets.  It is not recommended for big data, as big data
#' requires very careful control over which data is or is not loaded into memory.
#' The \strong{libr} package, on the other hand, tends to load all data into memory 
#' indiscriminately.
#' @import common
#' @aliases libr-package
#' @keywords internal
#' @name libr
"_PACKAGE"
