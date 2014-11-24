\name{AverageWuxDataFrame}
\alias{AverageWuxDataFrame}

\title{
WUX data frame averaging function
}
\description{
  Collapses WUX data frame by averaging over specified factor (column
  name). The chosen data frame column will disappear after
  aggregation.

  This function is primarly used to average over model runs (see example).
}

\usage{
AverageWuxDataFrame(x, INDEX, fun = "mean")
}

\arguments{
  \item{x}{
    wux \code{data.frame} (returned by \code{\link{models2wux}} or \code{\link{read.wux.table}})
   }
  
  \item{INDEX}{
    character column names from wux \code{data.frame} over which aggregation
    should take place. Those columns will dissapear after aggregation
  }
  
  \item{fun}{
    keyword for aggregation function. Default is \code{mean}
  }
 
}

\author{
  Thomas Mendlik \email{thomas.mendlik@uni-graz.at}
}

\examples{
## load WUX and read WUX test data
require(wux)
data(cmip3_2050)

## average over runs
cmip3.avg.runs <- AverageWuxDataFrame(cmip3_2050, "gcm.run")
## average over seasons, runs and subregions
cmip3.avg.all <- AverageWuxDataFrame(cmip3_2050, INDEX = c("gcm.run", "subreg", "season"))


}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ IO }
\keyword{ iteration }
\keyword{ datagen }
\keyword{ univar }% __ONLY ONE__ keyword per line
\keyword{ manip }% __ONLY ONE__ keyword per line
