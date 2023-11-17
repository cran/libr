## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

options(rmarkdown.html_vignette.check_title = FALSE)


## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  library(sassy)
#  
#  options("logr.autolog" = TRUE,
#          "logr.notes" = FALSE)
#  
#  # Get temp location for log and report output
#  tmp <- tempdir()
#  
#  # Open log
#  lf <- log_open(file.path(tmp, "example1.log"))
#  
#  
#  # Prepare Data ------------------------------------------------------------
#  
#  sep("Prepare Data")
#  
#  # Get path to sample data
#  pkg <- system.file("extdata", package = "libr")
#  
#  # Create libname for csv data
#  libname(sdtm, pkg, "csv", quiet = TRUE)
#  
#  
#  put("Join and prepare data")
#  
#  put("Join DM to VS and keep desired columns")
#  datastep(sdtm$DM, merge = sdtm$VS, merge_by = USUBJID,
#           keep = v(USUBJID, VSTESTCD, VISIT, VISITNUM, VSSTRESN, ARM, VSBLFL),
#           where = expression(VSTESTCD %in% c("PULSE", "RESP", "TEMP", "DIABP", "SYSBP") &
#                              !(VISIT == "SCREENING" & VSBLFL != "Y")), {}) -> dm_joined
#  
#  put("Sort by variables")
#  proc_sort(dm_joined, by = v(USUBJID, VSTESTCD, VISITNUM)) -> dm_sorted
#  
#  put("Differentiate baseline from treated vital signs")
#  datastep(dm_sorted, by = v(USUBJID, VSTESTCD),
#           retain = list(BSTRESN = 0), {
#  
#    # Combine treatment groups
#    # And distinguish baseline time points
#    if (ARM == "ARM A") {
#      if (VSBLFL %eq% "Y") {
#        GRP <- "A_BASE"
#      } else {
#        GRP <- "A_TRT"
#      }
#    } else {
#      if (VSBLFL %eq% "Y") {
#        GRP <- "O_BASE"
#      } else {
#        GRP <- "O_TRT"
#      }
#    }
#  
#    # Populate baseline value
#    if (first.)
#      BSTRESN = VSSTRESN
#  
#  }) -> prep
#  
#  
#  put("Get population counts")
#  pop_A <- subset(prep, GRP == "A_BASE", v(USUBJID, GRP)) |>
#    proc_sort(options = nodupkey) |>
#    proc_freq(tables = GRP,
#              options = v(nocum, nonobs, nopercent),
#              output = long) |>
#    subset(select = "A_BASE", drop = TRUE)
#  
#  pop_O <- subset(prep, GRP == "O_BASE", v(USUBJID, GRP)) |>
#    proc_sort(options = nodupkey) |>
#    proc_freq(tables = GRP,
#              options = v(nocum, nonobs, nopercent),
#              output = long) |>
#    subset(select = "O_BASE", drop = TRUE)
#  
#  
#  # Prepare formats ---------------------------------------------------------
#  
#  sep("Prepare formats")
#  
#  
#  
#  put("Vital sign lookup format")
#  vs_fmt <- c(PULSE = "Pulse",
#              TEMP = "Temperature °C",
#              RESP = "Respirations/min",
#              SYSBP = "Systolic Blood Pressure",
#              DIABP = "Diastolic Blood Pressure") |> put()
#  
#  put("Statistics lookup format")
#  stat_fmt <- c(MEANSTD = "Mean (SD)",
#                MEDIAN = "Median",
#                Q1Q3 = "Q1 - Q3",
#                MINMAX = "Min - Max") |> put()
#  
#  
#  put("Create format catalog")
#  fc <- fcat(MEAN = "%.1f",
#             STD = "(%.2f)",
#             MEDIAN = "%.1f",
#             Q1 = "%.1f",
#             Q3 = "%.1f",
#             MIN = "%.1f",
#             MAX = "%.1f")
#  
#  # Prepare final data frame ------------------------------------------------
#  
#  sep("Prepare final data")
#  
#  put("Calculate statistics and prepare final data frame")
#  proc_means(prep, var = VSSTRESN, class = VSTESTCD, by = GRP,
#             stats = v(mean, std, median, q1, q3, min, max),
#             options = v(notype, nofreq, nway)) |>
#    datastep(format = fc,
#             drop = v(MEAN, STD, Q1, Q3, MIN, MAX, VAR),
#             rename = c("CLASS" = "VAR"),
#             {
#               MEANSTD <- fapply2(MEAN, STD)
#               Q1Q3 <- fapply2(Q1, Q3, sep = " - ")
#               MINMAX <- fapply2(MIN, MAX, sep = " - ")
#             }) |>
#    proc_transpose(id = BY, var = v(MEANSTD, MEDIAN, Q1Q3, MINMAX),
#                   by = VAR, name = "LABEL") -> final
#  
#  put("Prepare factor for sorting")
#  final$VAR <- factor(final$VAR, names(vs_fmt))
#  
#  
#  put("Final sort")
#  proc_sort(final, by = VAR) -> final
#  
#  
#  # Create Report -----------------------------------------------------------
#  sep("Create Report")
#  
#  
#  # Define table object
#  tbl <- create_table(final) |>
#    spanning_header(A_BASE, A_TRT, "Placebo", n = pop_A) |>
#    spanning_header(O_BASE, O_TRT, "Treated", n = pop_O) |>
#    column_defaults(width = 1.25, align = "center") |>
#    stub(c(VAR, LABEL), width = 2.5) |>
#    define(VAR, "Vital Sign", format = vs_fmt,
#           blank_after = TRUE, dedupe = TRUE, label_row = TRUE) |>
#    define(LABEL, indent = .25, format = stat_fmt) |>
#    define(A_BASE, "Baseline") |>
#    define(A_TRT, "After Treatment") |>
#    define(O_BASE, "Baseline") |>
#    define(O_TRT, "After Treatment")
#  
#  
#  # Define report object
#  rpt <- create_report(file.path(tmp, "./output/example2.rtf"), output_type = "RTF",
#                       font = "Times", font_size = 12) |>
#    page_header("Sponsor: Company", "Study: ABC") |>
#    titles("Table 4.0", "Selected Vital Signs", bold = TRUE) |>
#    add_content(tbl, align = "center") |>
#    page_footer(Sys.time(), "CONFIDENTIAL", "Page [pg] of [tpg]")
#  
#  # Write report to file system
#  res <- write_report(rpt)
#  
#  
#  # Clean Up ----------------------------------------------------------------
#  sep("Clean Up")
#  
#  # Close log
#  log_close()
#  
#  # View report
#  # file.show(res$file_path)
#  
#  # View log
#  # file.show(lf)
#  
#  

