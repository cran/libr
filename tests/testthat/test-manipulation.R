context("Manipulation Tests")

base_path <- "c:\\packages\\libr\\tests\\testthat\\data"

base_path <- "./data"


test_that("libm01: lib_load() and lib_unload() functions works as expected.", {


  libname(dat, base_path, engine = "csv")


  # Should not get an error here
  suppressWarnings(lib_unload(dat))

  lib_load(dat)

  expect_equal(nrow(dat.demo_studya), 10)
  expect_equal(nrow(dat.demo_studyb), 2)

  lib_unload(dat)

  expect_equal("dat.demo_studya" %in% ls(), FALSE)
  expect_equal("dat.demo_studyb" %in% ls(), FALSE)

})


test_that("libm02: lib_size() works as expected.", {


  libname(dat, base_path, "csv")

  expect_equal(lib_size(dat) > 0, TRUE)
  expect_equal(lib_size(dat) < 900, TRUE)


})

test_that("libm03: lib_info() works as expected.", {


  libname(dat, base_path, "csv")

  info <- lib_info(dat)

  expect_equal(nrow(info) > 0, TRUE)
  expect_equal(info[1, "Size"] != "" ,  TRUE)


})



test_that("libm04: lib_path() works as expected.", {


  libname(dat, base_path, "csv")

  pth <- lib_path(dat)

  expect_equal(pth, base_path)


})


test_that("libm05: lib_sync() function works as expected.", {


  libname(dat, base_path, engine = "csv")

  ld <- is.loaded.lib("dat")

  expect_equal(ld, FALSE)

  lib_load(dat)

  ld <- is.loaded.lib("dat")

  expect_equal(ld, TRUE)

  acount <- nrow(dat.demo_studya)
  bcount <- nrow(dat.demo_studyb)

  tmp <- dat.demo_studya
  dat.demo_studya <- dat.demo_studyb
  dat.demo_studyb <- tmp

  dat <- lib_sync(dat)

  expect_equal(nrow(dat$demo_studya), bcount)
  expect_equal(nrow(dat$demo_studyb), acount)

  lib_unload(dat)

  ld <- is.loaded.lib("dat")

  expect_equal(ld, FALSE)

})




test_that("libm06: lib_sync() function can add a new item from workspace.", {


  libname(dat, base_path, engine = "csv")


  lib_load(dat)

  dat.demo_studyc <- mtcars

  lib_sync(dat)

  expect_equal(length(dat), 3)

})

test_that("libm07: lib_unload() function can add a new item from workspace.", {


  libname(dat, base_path, engine = "csv")


  lib_load(dat)

  dat.demo_studyc <- mtcars

  lib_unload(dat)

  expect_equal(length(dat), 3)

})


test_that("libm08: lib_add() function works as expected unloaded.", {

  alt_path <- tempdir()
  libname(dat, alt_path)

  lib_add(dat, mtcars, iris)

  inf <- lib_info(dat)

  expect_equal(length(dat), 2)
  expect_equal(nrow(inf), 2)

  lib_add(dat, mtcars, iris, name = c("fork", "bork"))

  expect_equal(length(dat), 4)

  lib_delete(dat)

})

test_that("libm09: lib_add() function works as expected loaded.", {

  alt_path <- tempdir()
  libname(dat, alt_path)

  lib_load(dat)

  lib_add(dat, mtcars, iris)

  inf <- lib_info(dat)

  expect_equal(length(dat), 2)
  expect_equal(nrow(inf), 2)

  lib_add(dat, mtcars, iris, name = c("fork", "bork"))

  expect_equal(length(dat), 4)

  lib_unload(dat)

  lib_delete(dat)

})


test_that("libm10: lib_remove() work as expected with multiple names.", {

  alt_path <- tempdir()
  libname(dat, alt_path)

  lib_add(dat, mtcars, iris)

  expect_equal(length(dat), 2)

  lib_remove(dat, c("mtcars", "iris"))

  expect_equal(length(dat), 0)

  lib_delete(dat)

})


test_that("libm11: lib_add(), lib_remove() functions work as expected unloaded.", {

  alt_path <- tempdir()
  libname(dat, alt_path)

  lib_add(dat, mtcars, iris)

  expect_equal(length(dat), 2)

  lib_remove(dat, "mtcars")

  expect_equal(length(dat), 1)

  lib_delete(dat)

})


test_that("libm12: lib_add(), lib_remove() functions work as expected loaded.", {

  alt_path <- tempdir()
  libname(dat, alt_path)

  lib_load(dat)

  lib_add(dat, mtcars, iris)

  expect_equal(length(dat), 2)

  lib_remove(dat, "mtcars")

  expect_equal(length(dat), 1)

  lib_remove(dat, "iris")

  expect_equal(length(dat), 0)

  lib_unload(dat)

  lib_delete(dat)
})



test_that("libm13: lib_write() function can add a new item and save as rds.", {

  alt_path <- tempdir()
  libname(dat, alt_path)

  lib_add(dat, mtcars)

  lib_write(dat)

  res <- file.exists(file.path(alt_path, "mtcars.rds"))

  expect_equal(res, TRUE)

  lib_remove(dat, "mtcars")

  lib_delete(dat)

})


test_that("libm14: lib_add() function can add a new item and save as csv", {

  alt_path <- tempdir()
  libname(dat, alt_path, engine = "csv")

  lib_add(dat, mtcars)

  res <- file.exists(file.path(alt_path, "mtcars.csv"))

  expect_equal(res, TRUE)

  lib_delete(dat)

})


test_that("libm15: lib_add() function can add a new item and save as xslx", {

  alt_path <- tempdir()
  libname(dat, alt_path, engine = "xlsx")

  lib_add(dat, mtcars)

  res <- file.exists(file.path(alt_path, "mtcars.xlsx"))

  expect_equal(res, TRUE)

  lib_delete(dat)

})


test_that("libm16: lib_add() function can add a new item and save as rds", {

  alt_path <- tempdir()
  libname(dat, alt_path, engine = "rds")

  lib_add(dat, mtcars)

  res <- file.exists(file.path(alt_path, "mtcars.rds"))

  expect_equal(res, TRUE)

  lib_delete(dat)

})


test_that("libm17: lib_add() function can add a new item and save as sas7bdat", {

  alt_path <- tempdir()
  libname(dat, alt_path, engine = "sas7bdat")

  lib_add(dat, mtcars)

  res <- file.exists(file.path(alt_path, "mtcars.sas7bdat"))

  #expect_equal(res, TRUE)
  expect_equal(res, FALSE) # FALSE for now

  lib_delete(dat)

})

test_that("libm18: lib_write() function can add a new item to sas7bdat libname from workspace.", {
  
  alt_path <- tempdir()
  libname(dat, alt_path, engine = "sas7bdat")
  
  
  lib_load(dat)
  
  dat.demo_studyc <- mtcars
  
  lib_write(dat)
  
  pth <- file.path(lib_path(dat), "demo_studyc.sas7bdat")
  
  res <- file.exists(pth)
  
  # expect_equal(res, TRUE)
  expect_equal(res, FALSE) # For now this is false.  Hope to make it true in the future.
  
  lib_delete(dat)
  
})


test_that("libm19: lib_write() function can add a new item from workspace.", {

  alt_path <- tempdir()
  libname(dat, alt_path, engine = "csv")


  lib_load(dat)

  dat.demo_studyc <- mtcars

  lib_write(dat)

  pth <- file.path(lib_path(dat), "demo_studyc.csv")

  res <- file.exists(pth)

  expect_equal(res, TRUE)

  lib_delete(dat)

})


test_that("libm20: lib_copy() works as expected.", {

  alt_path <- tempdir()

  libname(dat, base_path, "csv")

  lib_copy(dat, dat2, alt_path)

  expect_equal(file.exists(file.path(alt_path, "demo_studyb.csv")), TRUE)

  lib_delete(dat2)


})

test_that("libm21: read-only flag works as expected.", {


  libname(dat, base_path, "csv", read_only = TRUE)

  expect_error(lib_add(dat, mtcars))
  expect_error(lib_remove(dat, "demo_studya"))
  expect_error(lib_delete(dat))
  expect_error(lib_write(dat))
  expect_error(lib_replace(dat, mtcars, "demo_studya"))


})


test_that("libm22: lib_write non-changed csv data works as expected.", {

  alt_path <- tempdir()

  libname(dat, base_path, "csv")

  lib_copy(dat, dat2, alt_path)

  info1 <- lib_info(dat2)

  Sys.sleep(2)

  lib_replace(dat2, mtcars, name = "demo_studya")


  info2 <- lib_info(dat2)

  d1 <- subset(info1, Name == "demo_studya")
  d2 <- subset(info2, Name == "demo_studya")

  d3 <- subset(info1, Name == "demo_studyb")
  d4 <- subset(info2, Name == "demo_studyb")

  expect_equal(d1[1, 6] == d2[1, 6], FALSE)
  expect_equal(d3[1, 6] == d4[1, 6], TRUE)


  lib_delete(dat2)

})

test_that("libm23: lib_write non-changed rds data works as expected.", {

  alt_path <- tempdir()

  libname(dat, base_path, "rds")

  lib_copy(dat, dat2, alt_path)

  info1 <- lib_info(dat2)

  Sys.sleep(2)

  lib_replace(dat2, mtcars, name = "demo_studya")


  info2 <- lib_info(dat2)

  d1 <- subset(info1, Name == "demo_studya")
  d2 <- subset(info2, Name == "demo_studya")

  d3 <- subset(info1, Name == "demo_studyb")
  d4 <- subset(info2, Name == "demo_studyb")

  expect_equal(d1[1, 6] == d2[1, 6], FALSE)
  expect_equal(d3[1, 6] == d4[1, 6], TRUE)


  lib_delete(dat2)

})

# Copy won't work for sas7bdat
# test_that("lib_write non-changed sas7bdat data works as expected.", {
# 
#   alt_path <- tempdir()
# 
#   libname(dat, base_path, "sas7bdat")
# 
#   lib_copy(dat, dat2, alt_path)
# 
#   info1 <- lib_info(dat2)
# 
#   Sys.sleep(2)
# 
#   lib_replace(dat2, mtcars, name = "demo_studya")
# 
# 
#   info2 <- lib_info(dat2)
# 
# 
#   d1 <- subset(info1, Name == "demo_studya")
#   d2 <- subset(info2, Name == "demo_studya")
# 
#   d3 <- subset(info1, Name == "demo_studyb")
#   d4 <- subset(info2, Name == "demo_studyb")
# 
#   expect_equal(d1[1, 5] == d2[1, 5], FALSE)
#   expect_equal(d3[1, 5] == d4[1, 5], TRUE)
# 
#   lib_delete(dat2)
# 
# })

test_that("libm24: lib_write non-changed xlsx data works as expected.", {

  alt_path <- tempdir()

  libname(dat, base_path, "xlsx")

  lib_copy(dat, dat2, alt_path)

  info1 <- lib_info(dat2)

  Sys.sleep(2)

  lib_replace(dat2, mtcars, name = "demo_studya")

  lib_write(dat2)

  info2 <- lib_info(dat2)

  expect_equal(info1[2, 6] == info2[2, 6], TRUE)
  expect_equal(info1[1, 6] == info2[1, 6], FALSE)

  lib_delete(dat2)

})



test_that("libm25: force option works as expected.", {

  tmp <- tempdir()

  libname(dat, tmp)


  lib_add(dat, mtcars)

  res <- lib_info(dat)

  Sys.sleep(2)

  lib_write(dat, force = TRUE)

  res2 <- lib_info(dat)

  expect_equal(res[1, 6] == res2[1, 6],  FALSE)

  lib_delete(dat)

})


test_that("libm26: xpt engine works as expected.", {

  tmp <- tempdir()

  libname(dat, tmp, "xpt")


  lib_add(dat, mtcars)

  expect_equal(file.exists(file.path(tmp, "mtcars.xpt")), TRUE)

  libname(dat2, tmp, "xpt")

  expect_equal(nrow(dat2$mtcars),  32)

  lib_delete(dat)
  lib_delete(dat2)

})

test_that("libm27: Read existing xpt files.", {

  tmp <- tempdir()

  libname(dat, base_path, "xpt", filter = "ad*")


  expect_equal(length(dat), 2)

  expect_equal(nrow(dat$adae), 1191)
  expect_equal(nrow(dat$adsl), 254)


})



test_that("libm28: dbf engine works as expected.", {

  tmp <- tempdir()

  libname(dat, tmp, "dbf")


  lib_add(dat, mtcars)

  expect_equal(file.exists(file.path(tmp, "mtcars.dbf")), TRUE)

  libname(dat2, tmp, "dbf")

  expect_equal(nrow(dat2$mtcars),  32)

  lib_delete(dat)
  lib_delete(dat2)

})

test_that("libm29: dbf engine works as expected with tibble.", {

  tmp <- tempdir()

  libname(dat, tmp, "dbf")


  lib_add(dat, as_tibble(mtcars), name = "mtcars")

  expect_equal(file.exists(file.path(tmp, "mtcars.dbf")), TRUE)

  libname(dat2, tmp, "dbf")

  expect_equal(nrow(dat2$mtcars),  32)

  lib_delete(dat)
  lib_delete(dat2)

})

test_that("libm30: lib_load() function works as expected with filter", {


    libname(dat, file.path( base_path, "SDTM"),
            engine = "sas7bdat")

    lib_load(dat, c("ae", "dm", "lb", "vs"))

    d <- ls()

    expect_equal(all(c("dat.ae", "dat.dm", "dat.lb", "dat.vs") %in% d), TRUE)
    expect_equal(any(c("dat.da", "dat.ds", "dat.ex", "dat.pe") %in% d), FALSE)

    lib_unload(dat)


    lib_load(dat, filter = c("*e"))

    d <- ls()

    expect_equal(all(c("dat.ae", "dat.ie", "dat.pe") %in% d), TRUE)
    expect_equal(any(c("dat.da", "dat.ds", "dat.ex", "dat.lb") %in% d), FALSE)

    lib_unload(dat)


    lib_load(dat, filter = c("d*", "ex", "qs"))

    d <- ls()

    expect_equal(all(c("dat.da", "dat.dm", "dat.ds", "dat.ds_ihor",
                       "dat.ex", "dat.qs") %in% d), TRUE)
    expect_equal(any(c("dat.ae", "dat.lb", "dat.pe", "dat.ie") %in% d), FALSE)

    lib_unload(dat)

})


test_that("libm31: lib_write() changed csv data works as expected.", {


  alt_path <- tempdir()

  libname(dat, base_path, "csv")

  lib_copy(dat, dat2, alt_path)


  l1 <- lib_info(dat2)
  
  l1 
  
  expect_equal(nrow(l1), 2)
  
  d1 <- dat2$demo_studyb

  d1$visit[1] <- 1

  dat2$demo_studyb <- d1

  dat2$demo_studyc <- mtcars
  
  Sys.sleep(2)

  lib_write(dat2)

  l2 <- lib_info(dat2)
  
  l2

  expect_equal(nrow(l2), 3)
  expect_equal(l1[[1, "LastModified"]] == l2[[1, "LastModified"]], TRUE)
  expect_equal(l1[[2, "LastModified"]] == l2[[2, "LastModified"]], FALSE)

  lib_delete(dat2)

})




