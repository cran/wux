\name{summaryWux}
\alias{summaryWux}

\title{
Summary of a WUX data.frame
}
\description{
Prints a screen summary of a WUX \code{data.frame}. 
}
\usage{
summaryWux(object, parms = c("perc.delta.precipitation_amount",
"delta.air_temperature"), average.over.gcm.runs = FALSE, ...)
}

\arguments{
  \item{object}{
    WUX \code{data.frame} obtained from \code{\link{models2wux}}'
  }

  \item{parms}{
    String vector specifying the parameters to be evaluated. Default is
  \code{perc.delta.precipitation_amount} (percentage of precipitation change)
  and \code{delta.air_temperature} (air temperature change in K).
  }

  \item{average.over.gcm.runs}{
    Boolean. Should the runs of the same GCM be averaged out? This is
    recommended, as same GCMs tend to behave very similarly when run
    with different initial conditions and would thus lead to biased
    statistics when regarding as independent. Only available for GCM analysis. 
  }

  \item{\dots}{
    Further optional arguments. Not active now.
  }
}
\value{
  Returns a \code{summaryWux} object, which is a list, but will be
  printed in a special way.
  The list has two elements, namely \code{overall.stats} and
  \code{parms.stats}. Both are lists again. \code{overall.stats} stores
  all categorical statistics (climate model counts, emmission scenarios,
  rcm-gcm crosstables, ...). \code{parms.stats} is a list with
  statistics of continuous climate change signals (mean, standard
  deviation, coeficent of variation and quantiles) split by season, emission
  scenario, meteorological parameters and subregions.
}

\details{
  \code{summaryWux} gives an overview of model frequenzy and calculates
  statistics for each meteorological parameter within each season in
  each subregion for all emission scenarios.
  
  \code{print.summaryWux} prints the result to the screen.
}
\author{
  Thomas Mendlik \email{thomas.mendlik@uni-graz.at}
}

\examples{
## ENSEMBLES data summary
data(ensembles)
summaryWux(ensembles)

## CMIP3 data summary
data(cmip3_2100)
summaryWux(cmip3_2100, average.over.gcm.runs = TRUE) # Average GCMs with different 
                                                      # initial conditions
                                                      
## structure of summaryWux list
data(ensembles_gcms)
ensembles.gcms.summary <- summaryWux(ensembles_gcms)
ensembles.gcms.summary  # summary of 8 GCMs
str(ensembles.gcms.summary)
}

\keyword{ univar }% __ONLY ONE__ keyword per line
\keyword{ methods }% __ONLY ONE__ keyword per line
\keyword{ print }% __ONLY ONE__ keyword per line
\keyword{ manip }% __ONLY ONE__ keyword per line
