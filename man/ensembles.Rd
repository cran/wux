\name{ensembles}
\alias{ensembles}
\docType{data}
\title{
ENSEMBLES dataset
}
\description{
  This dataset contains air temperature and precipitation climate
  change signals of all 22 A1B forced climate simulations from the
  ENSEMBLES project from 1961-1990 to 2021-2050.
}
\usage{data(ensembles)}

\source{
  The ENSEMBLES project: \url{http://www.ensembles-eu.org/}%%  ~~ reference to a publication or URL from which the data were obtained ~~
}
\references{
  van der Linden P, Mitchell JFB. 2009. ENSEMBLES: Climate Change and
  its Impacts: Summary of research and results from the ENSEMBLES
  project. Met Office Hadley Centre: Exeter.

  %% Hewitt, C. D. and D. J. Griggs, 2004: Ensembles-based Predictions of
  %% Climate Changes and their Impacts. Eos, 85, p566.
  %%  ~~ possibly secondary sources and usages  ~~
}
\examples{
require(wux)
data(ensembles)
ensembles <- droplevels(subset(ensembles, subreg == "EU.ENS"))

str(ensembles)
parms <- c("delta.air_temperature", "perc.delta.precipitation_amount",
           "delta.global_radiation", "delta.wind_speed")
summaryWux(ensembles, parms = parms)

\dontrun{ScatterplotWux(ensembles,  "perc.delta.precipitation_amount",
              "delta.air_temperature", boxplots = TRUE, xlim = c(-10,10),
              ylim = c(0, 3),
              label.only.these.models = c(""),
              xlab = "Precipitation Amount [\%]",
              ylab = "2-m Air Temperature [K]",
              main = "CCS 2-m Air Temp. and Precip. Amount 1961-90 to 2021-50",
              subreg.subset = c("EU.ENS"))}

## comparing ENSEMBLES RCMs with its driving GCMs
data(ensembles_gcms)
ensembles_gcms.eu <- gdata::drop.levels(subset(ensembles_gcms, subreg ==
"EU.ENS"))
gcm.names <- levels(ensembles_gcms.eu$acronym)

vars.of.interest <- !names(ensembles) \%in\% c("delta.global_radiation", "delta.wind_speed")
ensembles <- ensembles[vars.of.interest]
ensembles.merge <- rbind(ensembles, ensembles_gcms.eu)
summaryWux(ensembles.merge)

\dontrun{ScatterplotWux(ensembles.merge,  "perc.delta.precipitation_amount",
              "delta.air_temperature", boxplots = TRUE, xlim = c(-10,10),
              ylim = c(0, 3),
              label.only.these.models = gcm.names,
              xlab = "Precipitation Amount [\%]", ylab = "2-m Air Temperature [K]",
              main = "CCS 2-m Air Temp. and Precip. Amount 1961-90 to 2021-50",
              subreg.subset = c("EU.ENS"), draw.median.lines = FALSE)
}
}
\keyword{datasets}
