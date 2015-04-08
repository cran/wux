\name{alpinesummer}
\alias{alpinesummer}
\docType{data}
\title{
Timeseries example of CMIP5 data over Greater Alpine Region in summer
}
\description{
 An example temperature timerseries for one subregion Greater Alpine Region (GAR)
 \code{\link{models2wux}} in summer (JJA) of the CMIP5 ensemble for RCP
 4.5. This is what a timeseries result from \code{\link{models2wux}}
 would look like. 
}
\usage{data(alpinesummer)}

% \details{
%   You can download the NetCDF files from ESGF using {\code{\link{CMIP5fromESGF}}}.
% }

\seealso{\code{\link{models2wux}}}

\examples{
## thats what alpinesummer looks like
data("alpinesummer")
head(alpinesummer)
## it really is a timeseries! hooraay!

## get an idea what the data look like
require(lattice)
\dontrun{xyplot(air_temperature ~ year|gcm,
       groups = acronym,
       data = alpinesummer,
       type = c("l", "g"),
       main = "JJA temperature of CMIP5 over Greater Alpine Region\nRCP 4.5 forcing")}
## have fun playing around with the data :)
}
\keyword{datasets}
