\name{plotAnnualCycle}
\alias{plotAnnualCycle}

\title{
  Plots the annual cycle
}

\description{
plotAnnualCycle plots the monthly or seasonal annual cycle of
indicated models and the box-whisker plots of the underlying distribution.

This plotting routine extracts all the information from the input
data frame which has to be 'WUX-style' (see \code{\link{models2wux}}).
}

\usage{
plotAnnualCycle(datain.df, var.name = NULL, subreg.subset = NULL,
season.subset = NULL, plot.quantiles = NULL, quantile.method = 7,
mark.df = NULL, plot.legend = FALSE, cex.names = 1.2, cex.lab = 1.2,
ylab = NULL, main = NULL, out.file.directory = NULL, out.file.name =
NULL, copyright = FALSE, ...)
}

\arguments{
  \item{datain.df}{
    WUX data frame obtained from \code{\link{models2wux}}.
  }
  
  \item{var.name}{
   Character string of parameter in WUX dataset.
 }
  
  \item{subreg.subset}{
    Vector of subregions to be plotted
    (e.g. \code{c("EU.ENS", "GAR")}).
  }
  
  \item{season.subset}{
    Vector of seasons to be plotted
    (e.g. \code{c("MAM", "DJF")}).
  }

  \item{plot.quantiles}{
    5 element vector indictaing the  quantiles to be plotted
    (e.g. \code{c(0.02,0.25,0.5,0.75,0.98)}).
  }
  
  \item{quantile.method}{
    An integer between 1 and 9 selecting one of the nine quantile types
    in \code{quantiles} with default 7. 
  }

  \item{mark.df}{
    Subset of WUX data frame indicating the models to be marked.
  }
 
  \item{plot.legend}{
    Boolean. Indicating if a plot legend indicating the models of \code{mark.df} and
    sample size should be plotted. Default is \code{FALSE}.
  }

  \item{cex.names}{
    Expansion factor for numeric axis labels in \code{bxp}. Default is
    \code{1.2}. 
  }
  
  \item{cex.lab}{
    Expansion factor for axis names (bar labels) in \code{bxp}. Default is
    \code{1.2}.
  }
  
  \item{ylab}{
    Label for y-axis.
  }

  \item{main}{
    Main title.
  }

  \item{out.file.directory}{
     String of the directory where the plots are exported
       (e.g. \code{"/tmp/plots/"}).
  }

  \item{out.file.name}{
    Prefix of the file names of the plots. Files will be stored as
    \code{out.file.name_subreg_season.eps}, where \code{subreg} is one
    realization of the \code{subreg.subset} argument and \code{season}
    is one realization of \code{season.subset}. For example:
    \code{out.file.name = "AnnualCycle"} will store to the files to
    \code{AnnualCycle_EUROPE_DJF.eps} and \code{AnnualCycle_EUROPE_JJA.eps}.
  }

  
  \item{copyright}{
    Boolean. If a copyright message should be plotted.
    Default is FALSE.
  }

   \item{...}{
      Further optional arguments passed to \code{bxp}.
  }  

}


\author{
  Georg Heinrich \email{g.heinrich@uni-graz.at}
}


\examples{
## load WUX and read WUX test data
require(wux)
data(ensembles)

wuxtest.df <- subset(ensembles, subreg == "GAR")

## set data frame for model marks
mark.df <- subset(wuxtest.df, acronym \%in\% c("ICTP-REGCM3", "MPI-M-REMO"))
mark.df2 <- gdata::drop.levels(mark.df)

\dontrun{plotAnnualCycle(wuxtest.df, "perc.delta.precipitation_amount", mark.df =
mark.df, plot.legend = TRUE, boxfill = "light yellow", notch =
FALSE,  boxwex = 0.5, ylim = c(-60,60), plot.quantiles =
c(0.02,0.25,0.5,0.75,0.98), boxcol = "red", ylab = "Precipitation
Amount [\%]", main = "Annual cycle ", las = 1, copyright = TRUE)
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ hplot }
\keyword{ univar }% __ONLY ONE__ keyword per line
