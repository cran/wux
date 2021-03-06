\name{ensembles_gcms}
\alias{ensembles_gcms}
\docType{data}
\title{
GCM forcing data from the ENSEMBLES project
}
\description{
  This dataset contains air temperature and precipitation climate
  change signals of the 8 A1B driving GCMs used as boundary conditions
  for the ENSEMBLES RCMs. The climate change signal is from 1961-1990 to 2021-2050.
}
\usage{data(ensembles_gcms)}

\source{
  ENSEMBLES project: \url{http://www.ensembles-eu.org/}
  CMIP3 project: \url{http://www-pcmdi.llnl.gov}
}
\references{
  van der Linden P, Mitchell JFB. 2009. ENSEMBLES: Climate Change and
  its Impacts: Summary of research and results from the ENSEMBLES
  project. Met Office Hadley Centre: Exeter.

  %% Hewitt, C. D. and D. J. Griggs, 2004: Ensembles-based Predictions of
  %% Climate Changes and their Impacts. Eos, 85, p566.
  %%  ~~ possibly secondary sources and usages  ~~
}

\seealso{\code{\link{cmip3_2050}}, \code{\link{ensembles}}, \code{\link{models2wux}}}

\examples{
require(wux)
data(ensembles_gcms)
ensembles.gcm.names <- levels(ensembles_gcms$acronym) #8 GCM names
summary(ensembles_gcms)

## Now lets compare this dataset to the CMIP3 ensemble
data(cmip3_2050)     # GCMs of CMIP3 ensemble
cmip3_2050.sub <- subset(cmip3_2050, subreg \%in\% c("World", "EU.ENS")
                       & em.scn == "A1B") 
cmip3_2050.sub <- droplevels(cmip3_2050.sub)
## "mpi_echam5-r3", "bccr_bcm2_0-r1", "ipsl_cm4-r2" can be found
## in the ensembles_gcms dataset as well as in the cmip3_2050 dataset
## so we delete it from one of these dataset
ensembles_gcms.sub <- subset(ensembles_gcms, !acronym \%in\%
                                c("mpi_echam5-r3", "bccr_bcm2_0-r1",
                                  "ipsl_cm4-r2"))
ensembles_gcms.sub <- gdata::drop.levels(ensembles_gcms.sub)
## combine cmip3 and ENSEMBLES GCMs in one data.frame
gcms.combined <- rbind(ensembles_gcms.sub, cmip3_2050.sub)

## Scatterplot
prec.range <- range(gcms.combined$perc.delta.precipitation_amount) + c(-1, 1)
tas.range <- range(gcms.combined$delta.air_temperature)
\dontrun{plot(gcms.combined,
               "perc.delta.precipitation_amount", "delta.air_temperature",
               subreg.subset = "EU.ENS", draw.median.lines = FALSE,
               label.only.these.models = ensembles.gcm.names,
               xlim = prec.range,
               ylim = tas.range,
               main = "GCMs from ENSEMBLES project within CMIP3 SRESA1B ensemble",
               draw.seperate.legend = TRUE)
}
}
\keyword{datasets}
