\name{CMIP5_example_changesignal}
\alias{CMIP5_example_changesignal}
\docType{data}
\title{
Climate change signals of example userinput for models2wux
}
\description{
This example of a WUX data.frame is the result of running
\code{userinput_CMIP5_changesignal} with \code{\link{models2wux}}.
}
\usage{data(CMIP5_example_changesignal)}

\details{
  You can download the NetCDF files from ESGF using {\code{\link{CMIP5fromESGF}}}.
}

\seealso{\code{\link{models2wux}}}

\examples{
## thats what CMIP5_changesignal looks like
data("CMIP5_example_changesignal")
CMIP5_example_changesignal

## You can run models2wux to get the same result as
## above.
data(userinput_CMIP5_changesignal)
data(modelinput_test)
\dontrun{
## You must have downloaded the example NetCDF files according to
## "modelinput_test" in order to run "models2wux", or you will get an
error message. See the examples of ?CMIP5fromESGF or ?modelinput_test.  
CMIP5_example_changesignal <- models2wux(userinput_CMIP5_changesignal,
                                modelinput = modelinput_test)}

}
\keyword{datasets}
