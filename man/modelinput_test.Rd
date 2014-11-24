\name{modelinput_test}
\alias{modelinput_test}
\docType{data}
\title{
Example model specification file for models2wux
}
\description{
  This is an example model specification for WUX, giving information on
   two example NetCDF files from the CMIP5 project. The
  datatype is a list. For specification details see the "Configfile
  modelinput" section in \code{\link{models2wux}}. 
}

\usage{data(modelinput_test)}

\details{ The two CMIP5 simulations "NorESM1-M" and "CanESM2" (either
  having historical run and RCP 8.5 forcing) are assumed to be stored in
  the home directory "~/tmp/CMIP5". You can download them using
  \code{\link{CMIP5fromESGF}}. See the example for a typical workflow.
}

\seealso{\code{\link{models2wux}}, \code{\link{CMIP5fromESGF}}}

\examples{
\dontrun{
## Here is how to use the climate model specification file
## "modelinput_test" for models2wux.

## I) DOWNLOAD EXEMPLARY DATA
## download temperature fields of two example GCMs (NorESM1-M and
## CanESM2) with the  RCP 8.5 and the historical run
## into your temporary directory. This command will create a folder
## "CMIP5" in "~/tmp" with two subfolders for each model again with
## two subfolders for each experiment.
CMIP5fromESGF(save.to = "~/tmp/CMIP5/",
              models = c("NorESM1-M", "CanESM2"),
              variables = c("tas"),
              experiments= c("historical", "rcp85"))

## II) INTERFACE FOR THE DATA (type list)
## This is the information for models2wux to read in the data. Usually
## you have to create such a file for yourself, or add it to an existing
## one. This file assumes you have downloaded the two GCMs into ~/tmp/CMIP5 by
## CMIP5fromESGF, as shown above.
data(modelinput_test)

## III) CONTROL FILE FOR models2wux (type list)
## What climate data you want to read in (here it is the two example
## simluations mentioned above)? What subregion to analysze? What is you
## reference and what your scenario period? Aggregate to specific
## seasons? 
data(userinput_CMIP5_timeseries)

## IV) CONVERT CLIMATE SIMULATIONS TO A data.frame
wux.test <- models2wux(userinput_CMIP5_timeseries, modelinput_test)

## V) ANALYZE data.frame
require(lattice)
wux.test$year <- as.integer(as.character(wux.test$year))
xyplot(air_temperature ~ year|season,
       groups=acronym,
       data = wux.test,
       type = c("l", "g"),
       main = "NorESM1-M and CanESM2 simulations over Alpine Region\n
       historical and RCP 8.5 forcing")
}

}
\keyword{datasets}
