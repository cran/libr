% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/datastep.R
\name{datastep}
\alias{datastep}
\title{Step through data row-by-row}
\usage{
datastep(
  data,
  steps,
  keep = NULL,
  drop = NULL,
  rename = NULL,
  by = NULL,
  calculate = NULL,
  retain = NULL,
  attrib = NULL,
  arrays = NULL,
  sort_check = TRUE,
  format = NULL,
  label = NULL,
  where = NULL,
  set = NULL,
  merge = NULL,
  merge_by = NULL,
  merge_in = NULL,
  log = TRUE,
  subset = NULL
)
}
\arguments{
\item{data}{The data to step through.  This parameter is required. Valid
values are a data frame or a NULL. In the case of a NULL, you must include
at least one \code{output()} function in the steps.}

\item{steps}{The operations to perform on the data.  This parameter is 
specified as a set of R statements contained within 
curly braces. If no steps are desired, pass empty curly braces.}

\item{keep}{A vector of quoted variable names to keep in the output
data set. By default, all variables are kept.}

\item{drop}{A vector of quoted variable names to drop from the output
data set. By default, no variables are dropped.}

\item{rename}{A named vector of quoted variables to rename.  The current
variable name should be on the left hand side of the name/value pair,
and the new variable name should be on the right.  The rename operation
is performed after the data step, the keep, and the drop.  Therefore, 
the data steps should use the input variable name.  By default, all variables
retain their original names.}

\item{by}{A vector of quoted variable names to use for by-group processing.
This parameter will activate the \code{first.} and \code{last.} automatic
variables, that indicate the first or last rows in a group.  These 
automatic variables are useful for conditional processing on groups.
The function will also create first and last automatic variables for each
variable specified in the by group.}

\item{calculate}{Steps to set up calculated variables.
Calculated variables are commonly generated with summary functions such as
\code{mean}, \code{median}, \code{min}, \code{max}, etc.  It is more 
efficient to set up calculated variables with the calculate parameter and then 
use those variables in the data step, rather than perform the summary
function inside the data step.  The calculate block will be executed 
immediately before the data step.}

\item{retain}{A list of variable names and initial values 
to retain.  Retained variables will begin the data step with the initial
value.  Then for each iteration of the data step, the variable will
be populated with the ending value from the previous step.  The retain
functionality allows you to perform cumulative operations or decisions
based on the value of the previous iteration of the data step.  Initial 
values should be of the expected data type for the column.  For example, 
for a numeric column set the initial value to a zero, and for a
character column, set the initial value to an empty string, i.e.
\code{retain = list(col1 = 0, col2 = "")}.  There is no default initial 
value for a variable.  You must supply an initial value for each retained
variable.}

\item{attrib}{A named list of attributes.  The list can be either
\code{\link{dsattr}} objects or single default values.  The \code{dsattr}
object allows you to set more attributes on each column.  The 
single default value is convenient if you simply want to create a variable.
By default, variables will be created on the fly with no attributes.}

\item{arrays}{A named list of \code{\link{dsarray}} objects. The 
\code{dsarray} is a list of columns which you can 
iterate over inside the data step.  You can iterate over a \code{dsarray}
either with a \code{for} loop, or with a vectorized function. 
The default value of the \code{arrays} parameter is NULL, meaning
no arrays are defined.}

\item{sort_check}{Checks to see if the input data is sorted according to
the \code{by} variable parameter.  The sort check will give an error
if the input data is not sorted according to the \code{by} variable.
The check is turned on if the value of 
\code{sort_check} is TRUE, and turned off if FALSE.  The default value
is TRUE.  Turn the sort check off if you want to perform by-group 
processing on unsorted data, or data that is not sorted according
to the by-group.}

\item{format}{A named list of formats to assign to the data
frame.  Formats will be assigned both before and after the datastep.}

\item{label}{A named list of labels to assign to the output data frame.}

\item{where}{An expression to filter the output dataset.  The where
clause will be applied prior to any drop, keep, or rename statement.
Use the \code{expression} function to assign the where clause.}

\item{set}{A dataset or list of datasets to append to the input 
data frame.  The set operation will occur at the beginning of the datastep,
prior to the execution of any steps.  The columns in the set datasets
do not have to match.  Where there are no matching columns, the missing
values will be filled with NA.}

\item{merge}{A dataset or list of datasets to merge with the input
data.  The merge operation will occur at the beginning of the datastep,
prior to the execution of any steps.  When the \code{merge} operation is 
requested, the \code{merge_by} parameter will be used to indicate which variable(s)
to merge by. If no \code{merge_by} is specified, the merge dataset columns will 
simply be appended to the right of the input dataset.}

\item{merge_by}{If the \code{merge} parameter is set, the \code{merge_by} 
parameter will be used to identify the variable(s) to merge by. If merge 
variables are the same on both datasets, the names may be passed as a simple 
quoted vector. If the variable names are different, pass the variables 
to merge on as a named vector.  For example, \code{c("ITEMID" = "ITEMCODE")}
would specify that the join should occur on the "ITEMID" from the 
dataset specified in the \code{data} parameter, and the "ITEMCODE"
variable from the dataset specified on the \code{merge} parameter.}

\item{merge_in}{A vector of column names to be used to hold the merge flags.
The number of names should correspond to the number of 
datasets being merged. The
merge flags will be populated with 0 or 1 values to indicate whether the record
came from the corresponding table. Use the \code{where} parameter, 
\code{delete} function, or \code{output} function to filter desired results.}

\item{log}{Whether or not to log the datastep.  Default is TRUE.  This 
parameter is used internally.}

\item{subset}{The \code{subset} parameter accepts an \code{expression} object
that will be used to subset the data.  The \code{subset} expression will be 
executed \strong{before} the datastep executes.  In this regard, the 
\code{subset} parameter on the R datastep is similar to the \code{where} clause
on the SAS datastep.}
}
\value{
The processed data frame, tibble, or data table.
}
\description{
The \code{datastep} function allows you to perform
row-wise conditional processing on a data frame, data table, or tibble. 
The function
contains parameters to drop, keep, or rename variables, perform
by-group processing, and perform row-wise or column-wise calculations.
}
\details{
Two parameters on the \code{datastep} function are required: 
\strong{data} and \strong{steps}.  The \strong{data} parameter is
the input data to the data step.  The \strong{steps} parameter contains
the code statements you want to apply to the data. The \strong{steps}
should be wrapped in curly braces.  When running, the data step
will loop through the input data row-by-row, and execute the steps for 
each row.  Variables inside the data step can be accessed using 
non-standard evaluation (meaning they  do not have to be quoted).

Note that the data step is pipe-friendly.  It can be used within 
a \strong{dplyr} pipeline.  The data step allows you to perform
deeply nested and complex conditionals within the pipeline.  The data
step is also very readable compared to other pipeline conditionals.
}
\section{Automatic Variables}{

The \code{datastep} function provides five automatic variables. These 
variables are generated for every data step, and can 
be accessed at any point within the data step: 
\itemize{
  \item{\strong{data}: Represents the entire input data frame.}
  \item{\strong{rw}: Represents the current row.}
  \item{\strong{n.}: Contains the row number.}
  \item{\strong{first.}: Indicates the beginning of a by-group.}
  \item{\strong{last.}: Indicates the end of a by-group.}
}
Automatic variables will be dropped from the data frame at the end
of the data step.  If you wish to keep the automatic variable values,
assign the automatic variable to a new variable and keep that variable.

If there are multiple by group variables, the \code{first.} and \code{last.} 
automatic variables indicates a either/or combination of all by variables.  
In addition,
\code{first.X} and \code{last.X} automatic variables will be created for 
each variable, where "X" represents the name of the specified variable.
As always, these names are case-sensitive.
}

\section{Column Attributes}{

To set attributes for a column on your data, use the \code{attrib}
parameter.  Example attributes include 'label', 'description', 
and 'format'.  These types of attributes are set using a named list and a 
\code{\link{dsattr}} object. The name of the list item
is the column name you want to set attributes on. 
The value of the list item is the \code{dsattr} object.
For a complete list of available attributes, 
see the \code{\link{dsattr}} documentation.

It should be mentioned  that the \code{dsattr} object is not required.  
You can also set attributes with a name and a default value.  
The default value can be any valid data value, such as a number or string.

The label and format attributes may also be set with the 'label' and 
'format' parameters. These parameters accept a named list with the 
labels or formats, and will be assigned to the output data frame.
}

\section{Optional Parameters}{

Optional parameters on the \code{datastep} allow you to shape 
the output dataset or enhance the operation of the \code{datastep}.  Some
parameters are classified as input parameters, and others as output 
parameters.  Input parameters modify the data before the data step
operations takes place.  Output parameters operate on the data
after the data step.

The \code{keep}, \code{drop}, and \code{rename} parameters
are output parameters.  These parameters will be applied after the
data step statements are executed.  Therefore, within the data step, 
refer to variables using the input variable name. New variables may 
be created on the fly, just by assigning a value to the new
variable name.

The \code{keep}, \code{drop}, and \code{rename} parameters require 
quoted variable names, as the variables may not yet exist at the 
time they are passed into the function.  Within a data step or 
calculate block, however, 
variable names do not need to be quoted. 

The \code{calculate} parameter is used to perform vectorized functions
on the data prior to executing the data step.  For example, you 
may want to determine a mean for a variable in the \code{calculate}
block, and then make decisions on that mean in the data step block. 

The \code{retain} parameter allows you to access the prior row value.
At the start of the data step, the retained variable is seeded with the 
initial value. For each subsequent step, the variable is seeded with the
value of the prior step/row.  This functionality allows you to increment 
values or perform cumulative operations.

\code{calculate} and \code{retain} are both input parameters.

The \code{subset} and \code{where} parameters can both be used to filter
the datastep data.  The difference is that \code{subset} is an input
parameter, and \code{where} is an output parameter.
}

\section{Set and Merge Operations}{

The \code{datastep} function allows you to join one or more input datasets 
into a single output dataset.  There are two operations in this regard:
"set" and "merge".  A set operation stacks the datasets vertically, one
on top of another. The merge operation joins the datasets horizontally,
left and right.  

The \code{datastep} set and merge operations are unusually flexible compared
to other join functions in R. The set operation does not require the same 
number of columns in each dataset.  Likewise, the merge operation does
not require the same number of rows.  In both cases, where there is no
corresponding column or row, the function will fill in with NA values.

The merge operation can perform both inner and outer joins.  By default, 
the merge performs a full outer join.  If you wish to limit the operation
to an inner join, use the "merge_in" parameter to set up variables with 
which you can filter the desired rows.  The "merge_in" variables will
be populated with 1 or 0 values, which indicate whether or not the 
dataset contained that row.  Once these variables are populated, you
can easily limit the results using a \code{where} expression, or the 
\code{delete} or \code{output} functions from inside the datastep.
}

\section{Data Step Arrays}{

There are times you may want to iterate over columns in your data step.  Such 
iteration is particularly useful when you have a wide dataset,
and wish to perform the same operation on several columns.
For instance, you may want to calculate the mean for 10 different
variables on your dataset.

The \code{arrays} parameter allows you to iterate across columns.  
This parameter accepts a named list of 
\code{\link{dsarray}} objects.  The \code{dsarray} is essentially
a list of columns.  You can use a \code{for} loop to iterate over the
\code{dsarray}, and also send it into a vectorized function.  Data 
step arrays allow to you to perform row-wise calculations. 
For instance, you can calculate 
a sum or mean by row for the variables in your array.
}

\section{Output Column Order}{

By default, the data step will retain the column order of any variables that
already exist on the input data set. New variables created 
in a data step will be appended to the right of existing variables.  
Yet these new variables can sometimes appear in an order that is 
unexpected or undesirable.  

There are two ways to control the order of output columns:
the \code{keep} parameter and the \code{attrib} parameter.

Columns names included on the 
\code{keep} parameter will appear in the order indicated on the keep
vector.  This ordering mechanism is appropriate when you have a small
number of columns and can easily pass the entire keep list.

To control the order of new variables only, use the \code{attrib} parameter.
New variables for which attributes are defined will appear in the 
order indicated on the \code{attrib} list.  The \code{attrib} list
is useful when you are adding a relatively small number of columns to 
an existing data set, and don't want to pass all the column names. 

Remember
that you can supply an attribute list with default values only,
such as \code{attrib = list(column1 = 0, column2 = "")}.  This style of 
attribute definition is convenient if you are only trying to control
the order of columns.

If the above two mechanisms to control column order are not sufficient,
use the data frame subset operators or column ordering functions 
provided by other packages.
}

\section{Datastep Performance}{

The \code{datastep} is intended to be used on small and medium-sized 
datasets.  It is not recommended for large datasets.
If your dataset is greater than one million rows, you should consider
other techniques for processing your data.  While there is no 
built-in restriction on the number of rows, performance of the
\code{datastep} can become unacceptable with a large number of rows.
}

\examples{
# Example #1: Simple Data Step
df <- datastep(mtcars[1:10,], 
               keep = c("mpg", "cyl", "disp", "mpgcat", "recdt", "is8cyl"), {
                 
  if (mpg >= 20) 
    mpgcat <- "High"
  else 
    mpgcat <- "Low"
                 
  recdt <- as.Date("1974-06-10")
                 
  if (cyl == 8)
    is8cyl <- TRUE
  else 
    is8cyl <- FALSE
                 
})

df
#                    mpg cyl  disp mpgcat      recdt
# Mazda RX4         21.0   6 160.0   High 1974-06-10
# Mazda RX4 Wag     21.0   6 160.0   High 1974-06-10
# Datsun 710        22.8   4 108.0   High 1974-06-10
# Hornet 4 Drive    21.4   6 258.0   High 1974-06-10
# Hornet Sportabout 18.7   8 360.0    Low 1974-06-10
# Valiant           18.1   6 225.0    Low 1974-06-10
# Duster 360        14.3   8 360.0    Low 1974-06-10
# Merc 240D         24.4   4 146.7   High 1974-06-10
# Merc 230          22.8   4 140.8   High 1974-06-10
# Merc 280          19.2   6 167.6    Low 1974-06-10

# Example #2: By-group Processing
df <- datastep(mtcars[1:10,], 
               keep = c("mpg", "cyl", "gear", "grp"), 
               by = c("gear"), sort_check = FALSE, {
                 
  if (first.)
    grp <- "Start"
  else if (last.)
    grp <- "End"
  else 
    grp <- "-"
                 
})

df
#                    mpg cyl gear   grp
# Mazda RX4         21.0   6    4 Start
# Mazda RX4 Wag     21.0   6    4     -
# Datsun 710        22.8   4    4   End
# Hornet 4 Drive    21.4   6    3 Start
# Hornet Sportabout 18.7   8    3     -
# Valiant           18.1   6    3     -
# Duster 360        14.3   8    3   End
# Merc 240D         24.4   4    4 Start
# Merc 230          22.8   4    4     -
# Merc 280          19.2   6    4   End 

# Example #3: Calculate Block
df <- datastep(mtcars, 
               keep = c("mpg", "cyl", "mean_mpg", "mpgcat"), 
               calculate = { mean_mpg = mean(mpg) }, {
                 
  if (mpg >= mean_mpg)
    mpgcat <- "High"
  else 
    mpgcat <- "Low"
                 
})

df[1:10,]
#                    mpg cyl mean_mpg mpgcat
# Mazda RX4         21.0   6 20.09062   High
# Mazda RX4 Wag     21.0   6 20.09062   High
# Datsun 710        22.8   4 20.09062   High
# Hornet 4 Drive    21.4   6 20.09062   High
# Hornet Sportabout 18.7   8 20.09062    Low
# Valiant           18.1   6 20.09062    Low
# Duster 360        14.3   8 20.09062    Low
# Merc 240D         24.4   4 20.09062   High
# Merc 230          22.8   4 20.09062   High
# Merc 280          19.2   6 20.09062    Low

# Example #4: Data pipeline
library(dplyr)
library(magrittr)

# Add datastep to dplyr pipeline
df <- mtcars \%>\% 
  select(mpg, cyl, gear) \%>\% 
  mutate(mean_mpg = mean(mpg)) \%>\% 
  datastep({
    
    if (mpg >= mean_mpg)
      mpgcat <- "High"
    else 
      mpgcat <- "Low"
    
  }) \%>\% 
  filter(row_number() <= 10)

df
#     mpg cyl gear mean_mpg mpgcat
# 1  21.0   6    4 20.09062   High
# 2  21.0   6    4 20.09062   High
# 3  22.8   4    4 20.09062   High
# 4  21.4   6    3 20.09062   High
# 5  18.7   8    3 20.09062    Low
# 6  18.1   6    3 20.09062    Low
# 7  14.3   8    3 20.09062    Low
# 8  24.4   4    4 20.09062   High
# 9  22.8   4    4 20.09062   High
# 10 19.2   6    4 20.09062    Low

# Example #5: Drop, Retain and Rename
df <- datastep(mtcars[1:10, ], 
               drop = c("disp", "hp", "drat", "qsec", 
                        "vs", "am", "gear", "carb"), 
               retain = list(cumwt = 0 ),
               rename = c(mpg = "MPG", cyl = "Cylinders", wt = "Wgt", 
                          cumwt = "Cumulative Wgt"), {
                 
  cumwt <- cumwt + wt
                 
})

df
#                    MPG Cylinders   Wgt Cumulative Wgt
# Mazda RX4         21.0         6 2.620          2.620
# Mazda RX4 Wag     21.0         6 2.875          5.495
# Datsun 710        22.8         4 2.320          7.815
# Hornet 4 Drive    21.4         6 3.215         11.030
# Hornet Sportabout 18.7         8 3.440         14.470
# Valiant           18.1         6 3.460         17.930
# Duster 360        14.3         8 3.570         21.500
# Merc 240D         24.4         4 3.190         24.690
# Merc 230          22.8         4 3.150         27.840
# Merc 280          19.2         6 3.440         31.280

# Example #6: Attributes and Arrays

# Create sample data
dat <- read.table(header = TRUE, text = '
   Year  Q1   Q2  Q3  Q4
   2000 125  137 152 140
   2001 132  145 138  87
   2002 101  104 115 121')
 
# Use attrib list to control column order and add labels
# Use array to calculate row sums and means, and get best quarter
df <- datastep(dat,
               attrib = list(Tot = dsattr(0, label = "Year Total"),
                             Avg = dsattr(0, label = "Year Average"),
                             Best = dsattr(0, label = "Best Quarter")),
               arrays = list(qtrs = dsarray("Q1", "Q2", "Q3", "Q4")),
               drop = "q",
               steps = {
               
                 # Empty brackets return all array values
                 Tot <- sum(qtrs[])
                 Avg <- mean(qtrs[])
                 
                 # Iterate to find best quarter
                 for (q in qtrs) {
                   if (qtrs[q] == max(qtrs[]))
                     Best <- q
                 }
               })
               
df
#   Year  Q1  Q2  Q3  Q4 Tot    Avg Best
# 1 2000 125 137 152 140 554 138.50   Q3
# 2 2001 132 145 138  87 502 125.50   Q2
# 3 2002 101 104 115 121 441 110.25   Q4

dictionary(df)
#   A tibble: 8 x 10
#   Name  Column Class     Label        Description Format Width Justify  Rows   NAs
#   <chr> <chr>  <chr>     <chr>        <chr>       <lgl>  <int> <chr>   <int> <int>
# 1 df    Year   integer   NA           NA          NA        NA NA          3     0
# 2 df    Q1     integer   NA           NA          NA        NA NA          3     0
# 3 df    Q2     integer   NA           NA          NA        NA NA          3     0
# 4 df    Q3     integer   NA           NA          NA        NA NA          3     0
# 5 df    Q4     integer   NA           NA          NA        NA NA          3     0
# 6 df    Tot    integer   Year Total   NA          NA        NA NA          3     0
# 7 df    Avg    numeric   Year Average NA          NA        NA NA          3     0
# 8 df    Best   character Best Quarter NA          NA         2 NA          3     0

# Example #7: Set and Merge Operations

# Create sample data
grp1 <- read.table(header = TRUE, text = '
  GROUP  NAME
  G01  Group1
  G02  Group2
', stringsAsFactors = FALSE)

grp2 <- read.table(header = TRUE, text = '
  GROUP  NAME
  G03  Group3
  G04  Group4
', stringsAsFactors = FALSE)
  
dat <- read.table(header = TRUE, text = '
  ID AGE SEX GROUP
  A01 58 F    G01
  A02 20 M    G02
  A03 47 F    G05
  A04 11 M    G03
  A05 23 F    G01
', stringsAsFactors = FALSE)

# Set operation
grps <- datastep(grp1, set = grp2, {})
grps
#   GROUP   NAME
# 1   G01 Group1
# 2   G02 Group2
# 3   G03 Group3
# 4   G04 Group4

# Merge operation - Outer Join
res <- datastep(dat, merge = grps, 
                merge_by = "GROUP", 
                merge_in = c("inA", "inB"), {})
                
# View results
res
#     ID AGE  SEX GROUP   NAME inA inB
# 1  A01  58    F   G01 Group1   1   1
# 2  A05  23    F   G01 Group1   1   1
# 3  A02  20    M   G02 Group2   1   1
# 4  A04  11    M   G03 Group3   1   1
# 5  A03  47    F   G05   <NA>   1   0
# 6 <NA>  NA <NA>   G04 Group4   0   1

# Merge operation - Inner Join
res <- datastep(dat, merge = grps, 
                merge_by = "GROUP", 
                merge_in = c("inA", "inB"), 
                where = expression(inA & inB), {})
                
# View results
res
#     ID AGE  SEX GROUP   NAME inA inB
# 1  A01  58    F   G01 Group1   1   1
# 2  A05  23    F   G01 Group1   1   1
# 3  A02  20    M   G02 Group2   1   1
# 4  A04  11    M   G03 Group3   1   1

# Example #8: Data NULL

# Create new dataset using output() functions.
res <- datastep(NULL, 
                {
                  ID <- 10
                  Item <- "Pencil"
                  output()

                  ID <- 20
                  Item <- "Scissors"
                  output()
                })
 
# View results
res
#    ID     Item
# 1  10   Pencil
# 2  20 Scissors
}
\seealso{
\code{\link{libname}} function to create a data library, and
the \code{\link{dictionary}} function to create a data dictionary.

Other datastep: 
\code{\link{[.dsarray}()},
\code{\link{delete}()},
\code{\link{dsarray}()},
\code{\link{dsattr}()},
\code{\link{length.dsarray}()},
\code{\link{output}()}
}
\concept{datastep}
