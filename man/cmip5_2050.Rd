\name{cmip5_2050}
\alias{cmip5_2050}
\docType{data}
\title{
  Climate Change signals for CMIP5 ensemble
}

\description{
  This dataset contains air temperature and precipitation climate
  change signals of all climate simulations from the CMIP5
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
  CMIP5 project: \url{http://www-pcmdi.llnl.gov}
}
\references{
  Karl E. Taylor, Ronald J. Stouffer, and Gerald A. Meehl, 2012: An Overview of CMIP5 and
 the Experiment Design. Bull. Amer. Meteor. Soc., 93, 485-498.  doi:
 http://dx.doi.org/10.1175/BAMS-D-11-00094.1
}

\examples{
require(wux)
data(cmip5_2050)

str(cmip5_2050)
summary(cmip5_2050)

tas.range <- c(0, 2.5)
pr.range <- c(-10, 15)
\dontrun{plot(cmip5_2050, "delta.air_temperature",
              "perc.delta.precipitation_amount", boxplots = TRUE,
              ylim = pr.range, xlim = tas.range, ylab = "Precipitation Amount [%]",
              xlab = "2-m Air Temperature [K]", draw.legend = TRUE,
              draw.median.lines = FALSE, subreg.subset = "CORDEX.Africa",
              main = "CMIP5 2-m Air Temp. and Precip. Amount 1961-1990 to 2021-2050",
              label.only.these.models = "", draw.seperate.legend = TRUE,
              copyright = TRUE, horiz.box.col = "coral", vert.box.col = "cyan")
}
}
\keyword{datasets}
