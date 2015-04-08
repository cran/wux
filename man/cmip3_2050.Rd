\name{cmip3_2050}
\alias{cmip3_2050}
\docType{data}
\title{
  Climate Change signals for CMIP3 ensemble
}
\description{
  This dataset contains air temperature and precipitation climate
  change signals of all climate simulations from the CMIP3
  project from 1961-1990 to 2021-2050. Subregions are defined according
  to the CORDEX project. Subregion \code{EU.ENS} contains the European
  region defined in the ENSEMBLES project and \code{World} contains the
  entire earth.
  \url{http://wcrp.ipsl.jussieu.fr/SF_RCD_CORDEX.html}.
}

\details{
This dataset is an exemplary output of \code{models2wux}.
}
\source{
  CMIP3 project: \url{http://www-pcmdi.llnl.gov}
}
\references{
  Meehl, G. A., C. Covey, T. Delworth, M. Latif, B. McAvaney,
  J. F. B. Mitchell, R. J. Stouffer, and K. E. Taylor, 2007: The WCRP
  CMIP3 multi-model dataset: A new era in climate change research, Bulletin of the American Meteorological Society, 88, 1383-1394.
}
\examples{
require(wux)
data(cmip3_2050)

str(cmip3_2050)
summary(cmip3_2050)

\dontrun{plot(cmip3_2050,  "perc.delta.precipitation_amount",
              "delta.air_temperature",  subreg.subset = "CORDEX.Africa",
              boxplots = TRUE, xlim = c(-10,10), label.only.these.models = "",
              ylim = c(0, 3), xlab = "Precipitation Amount [\%]",
              ylab = "2-m Air Temperature [K]", draw.legend = FALSE,
              draw.median.lines = FALSE, 
              main = "CMIP3 2-m Air Temp. and Precip. Amount")
}
}
\keyword{datasets}
