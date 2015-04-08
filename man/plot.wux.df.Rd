\name{plot.wux.df}
\alias{plot.wux.df}

\title{
X - Y Scatterplot of climate change signals}
\description{
plot.wux.df plots one or more scatterplots containing climate
change signals of selected meteorological parameters.

This plotting routine extracts all the information from the input
data frame which has to be 'WUX-style' (see \code{\link{models2wux}}).
}

\usage{
\method{plot}{wux.df}(x,
               var1.name = "delta.air_temperature",
               var2.name = "perc.delta.precipitation_amount",
               subreg.subset = NULL,
               season.subset = NULL, boxplots = TRUE,
               label.only.these.models = NULL, highlight.models = NULL,
                no.text = FALSE,
               vert.box.col = "cyan", horiz.box.col = "coral",
               zero.line.col = "gray80", median.line.col = "black",
               draw.legend = TRUE, draw.seperate.legend = FALSE,
               draw.median.lines = TRUE, use.rainbow.colors = TRUE,
               xlim = NULL, ylim = NULL, xlab = NULL, ylab = NULL,
               main = NULL, out.file.directory = NULL,
               out.file.name = NULL, copyright = FALSE, ...)
}

\arguments{
  \item{x}{
    WUX data.frame (class \code{wux.df}) obtained from \code{\link{models2wux}}'.
  }
  
  \item{var1.name}{
   Character string of 1st parameter in WUX dataset. Default is
   temperature change.
 }
 
  \item{var2.name}{
    Character string of 2nd parameter in WUX dataset. Default is
    precipitation change. 
  }
  
  \item{subreg.subset}{
    Vector of subregions to be plotted
    (e.g. \code{c("EU.ENS", "GAR")}).
  }
  
  \item{season.subset}{
    Vector of seasons to be plotted
    (e.g. \code{c("MAM", "DJF")}).
  }
  
  \item{boxplots}{
    Boolean. Indicating if marginal boxplots for the two input
    parameters should be plotted. Default is \code{TRUE}.
}

  \item{label.only.these.models}{
    Character vector of modelnames (acronyms) to be labeled in the scatterplot.
  }
  
 \item{highlight.models}{
    Character vector of modelnames (acronyms) to be highlighted in the scatterplot.
  }
  
  \item{no.text}{
    Boolean. Indicating if no models should be labeled. Default is \code{FALSE}.
  }
  
  \item{vert.box.col}{
    Color character for vertical boxplot. Default is \code{coral}.
  }

  \item{horiz.box.col}{
    Color character for horizontal boxplot.  Default is \code{cyan}.
  }

  \item{zero.line.col}{
    Color character for the zero lines. Default is \code{gray80}.
  }

 \item{median.line.col}{
    Color character for the median lines. Default is \code{black}.
  }

  \item{use.rainbow.colors}{
    Boolean. Use \code{rainbow()} color palette if \code{TRUE},
    otherwise a custom color palette with 17 colors is used. Default is
    \code{TRUE}.
    }

  \item{xlim}{
    Range vector for 1st parameter (x-axis).
  }
  
  \item{ylim}{
    Range vector for 2nd parameter (y-axis).
  }
  
  \item{xlab}{
    Label of 1st parameter (x-axis).
  }
  
  \item{ylab}{
    Label of 2nd parameter (y-axis).
  }
  
  \item{draw.legend}{
    Boolean. Indicating if legend with GCMs should be plotted. Default is \code{TRUE}.
  }
  \item{draw.seperate.legend}{
    Boolean. Should legend with GCMs be plotted on a seperate screen?
    Default is \code{FALSE}. Draws legend even if \code{draw.legend} is
    set \code{FALSE}.
  }
  
  \item{draw.median.lines}{
    Draw median lines for both parameters. Default is \code{TRUE}.
  }
  
  \item{main}{
    Main title.
  }
  
  \item{out.file.directory}{
    Directory where the plots shall be exported (e.g. "/tmp/plots/"). If
    neither \code{out.file.name} nor \code{out.file.directory} are
    passed, the plot will be displyed on screen.
  }
  
  \item{out.file.name}{
    Prefix of the file names of the plots. Files will be stored as
    \code{out.file.name_subreg_season.eps}, where \code{subreg} is one
    realization of the \code{subreg.subset} argument and \code{season} is one
    realization of \code{season.subset}. For example: \code{out.file.name =
      "scatterplot"} will store to the files
    \code{scatterplot_EUROPE_DJF.eps} and \code{scatterplot_EUROPE_JJA.eps}. If
    neither \code{out.file.name} nor \code{out.file.directory} are
    passed, the plot will be displyed on screen.
  }

  \item{copyright}{
    Boolean. If a copyright message should be plotted.
    Default is FALSE.
  }
  
  \item{\dots}{
    Further optional arguments to be passed to \code{plot}, such as graphical parameters (see \code{par}).
  }
  
}

\author{
  Thomas Mendlik \email{thomas.mendlik@uni-graz.at} and Georg Heinrich \email{g.heinrich@uni-graz.at}
}

\examples{
require(wux)

### ENSEMBLES RCM analysis
data(ensembles)

\dontrun{plot(ensembles, "perc.delta.precipitation_amount",
  "delta.air_temperature", boxplots = TRUE, xlim = c(-40,40),
  ylim = c(0, 4), label.only.these.models = c("ICTP-REGCM3", "MPI-M-REMO"), 
  xlab = "Precipitation Amount [\%]", ylab = "2-m Air Temperature [K]",
  main = "Scatterplot", subreg.subset = c("GAR"))
}

### now see where ENSMEBLES GCMs lie within CMIP3 ensemble
data(ensembles_gcms) # GCMs for forcing of ENSEMBLES RCMs
data(cmip3_2050)     # GCMs of CMIP3 ensemble

ensembles.gcm.names <- levels(ensembles_gcms$acronym) #8 GCM names

cmip3_2050.sub <- subset(cmip3_2050, subreg \%in\% c("World", "EU.ENS")
                       & em.scn == "A1B") 
cmip3_2050.sub <- droplevels(cmip3_2050.sub)
ensembles_gcms.sub <- subset(ensembles_gcms, !acronym \%in\%
                                c("mpi_echam5-r3", "bccr_bcm2_0-r1",
                                  "ipsl_cm4-r2"))
ensembles_gcms.sub <- droplevels(ensembles_gcms.sub)
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
               draw.seperate.legend = TRUE)}




}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ hplot }
\keyword{ multivariate }% __ONLY ONE__ keyword per line
