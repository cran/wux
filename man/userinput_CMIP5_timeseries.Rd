\name{userinput_CMIP5_timeseries}
\alias{userinput_CMIP5_timeseries}
\docType{data}
\title{
Example userinput for models2wux
}
\description{
This example \code{userinput_CMIP5_changesignal} can be used to test the
\code{\link{models2wux}} functionality. A userinput is a list of
configurations used to read and process climate model data. In general,
you should store it as an own file somewhere on your system. It
calculates a time series of the historical run 1971-2005 and RCP 8.5 2006-2100 for
temperature over the Alpine region of 2 CMIP5 models "NorESM1-M" and
"CanESM2". It aggregates the monthly NetCDF model output to boreal
seasons, winter, spirng, summer and autumn. It also stores the output as
a csv-file in your "/tmp" directory.
}
\usage{data(userinput_CMIP5_timeseries)}

\details{
  See "Configfile userinput" section in \code{\link{models2wux}}.
}

\seealso{\code{\link{models2wux}}, \code{\link{userinput_CMIP5_changesignal}}}

\examples{
## thats what userinput_CMIP5_timeseries looks like:
## it contains a single list named user.input
## describing 2 CMIP5 models in the alpine region
data("userinput_CMIP5_timeseries")
is.list(userinput_CMIP5_timeseries)
str(userinput_CMIP5_timeseries)

data(modelinput_test)

## reading in these data and process them:
\dontrun{wux.test <- models2wux(userinput_CMIP5_timeseries,
                                modelinput = model.input)}
## if you had a file "/tmp/userinput_CMIP5_timeseries.R" which contains a
## list 'user.input with the same content as 'userinput_CMIP5_timeseries'
## you could read the data also like this:
\dontrun{wux.test <- models2wux("/tmp/userinput_CMIP5_timeseries.R",
                        modelinput = model.input)}

## the result is what the data.set would look like, if you ran the code
## above:
data(CMIP5_example_timeseries)
wux.test <- CMIP5_example_timeseries

\dontrun{require(lattice)
xyplot(air_temperature ~ year|season,
       groups=acronym,
       data = wux.test,
       type = c("l", "g"),
       main = "Temperature trends for Alpine Region" )
}
}

\keyword{ datasets }
