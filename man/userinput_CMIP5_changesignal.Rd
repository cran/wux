\name{userinput_CMIP5_changesignal}
\alias{userinput_CMIP5_changesignal}
\docType{data}
\title{
Example userinput for models2wux
}
\description{
This example \code{userinput_CMIP5_changesignal} can be used to test the
\code{\link{models2wux}} functionality. A userinput is a list of
configurations used to read and process climate model data. In general,
you should store it as an own file somewhere on your system. It
calculates the climate change signal of 1971-2000 and 2071-2100 for
temperature over the Alpine region of 2 CMIP5 models "NorESM1-M" and
"CanESM2". It aggregates the monthly NetCDF model output to boreal
seasons, winter, spirng, summer and autumn. It also stores the output as
a csv-file in your "/tmp" directory.
}
\usage{data(userinput_CMIP5_changesignal)}

\details{
  See "Configfile userinput" section in \code{\link{models2wux}}.
}

\seealso{\code{\link{models2wux}}, \code{\link{userinput_CMIP5_timeseries}}}

\examples{
## thats what userinput_CMIP5_changesignal looks like:
## it contains a single list named user.input
## describing 2 CMIP5 models in the alpine region
data("userinput_CMIP5_changesignal")
is.list(userinput_CMIP5_changesignal)
str(userinput_CMIP5_changesignal)

data(modelinput_test)

## reading in these data and process them:
\dontrun{wux.test <- models2wux(userinput_CMIP5_changesignal,
                                modelinput = model.input)}
## if you had a file "/tmp/userinput_CMIP5_changesignal.R" which contains a
## list 'user.input with the same content as 'userinput_CMIP5_changesignal'
## you could read the data also like this:
\dontrun{wux.test <- models2wux("/tmp/userinput_CMIP5_changesignal.R",
                        modelinput = model.input)}

## the result is what the data.set would look like, if you ran the code
## above:
data(CMIP5_example_changesignal)
wux.test <- CMIP5_example_changesignal
wux.test

## example summary though the statistics not make much sense with 2 models
summaryWux(wux.test, parms = "delta.air_temperature")

}
\keyword{datasets}
