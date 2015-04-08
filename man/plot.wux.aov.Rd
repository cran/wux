\name{plot.wux.aov}
\alias{plot.wux.aov}

\title{
  Barplots of the ANOVA results
}

\description{
Barplots of the \code{\link{aovWux}} results displaying the relative
or absolute contribution of the individual factors to the overall variance.
}

\usage{
\method{plot}{wux.aov}(x, ss.relative = TRUE, subreg.subset =
NULL, cex.names = 1.2, cex.lab = 1.2, legend.text = NULL, sd.text =
TRUE, sd.unit = "", ylim = NULL, ylab = NULL, main = NULL,
out.file.directory = NULL, out.file.name = NULL, copyright = FALSE, ...)
}

\arguments{
  \item{x}{
    Object of class \code{wux.aov} obtained from the ANOVA \code{\link{aovWux}}.
  }
  
  \item{ss.relative}{
   Boolean. Indicating if the relative contribution of the factors to the
   overall variance should be calculated. Default is \code{TRUE}.
 }
  
  \item{subreg.subset}{
    Vector of subregions to be plotted
    (e.g. \code{c("EU.ENS", "GAR")}).
  }
 
  \item{cex.names}{
    Expansion factor for numeric axis labels in \code{bxp}. Default is
    \code{1.2}. 
  }
  
  \item{cex.lab}{
    Expansion factor for axis names (bar labels) in \code{bxp}. Default is
    \code{1.2}.
  }

  \item{legend.text}{
    String vector of the factors (e.g. \code{c("GCM", "RCM", "RES")}).
  }

   \item{sd.text}{
     Boolean. Indicating if the overall standard deviation should be
    displayed. Default is \code{TRUE}.
  }

   \item{sd.unit}{
      Character string of the standard deviation unit with default
      \code{""} (e.g. "K").
  }

  \item{ylim}{
    Range vector for the y-axis.
  }
  
  \item{ylab}{
    Label for y-axis.
  }

  \item{main}{
    Main title.
  }

  \item{out.file.directory}{
     String of the directory where the plots are exported
       (e.g. \code{"/tmp/plots/"}). If
    neither \code{out.file.name} nor \code{out.file.directory} are
    passed, the plot will be displayed on screen.
  }

  \item{out.file.name}{ 
    Prefix of the file names of the plots. Files will be stored as
    \code{out.file.name_subreg_season.eps}, where \code{subreg} is one
    realization of the \code{subreg.subset} argument and \code{season}
    is one realization of \code{season.subset}. For example:
    \code{out.file.name = "Barplot"} will store to the files to
    \code{Barplot_EUROPE_DJF.eps} and \code{Barplot_EUROPE_JJA.eps}. If
    neither \code{out.file.name} nor \code{out.file.directory} are
    passed, the plot will be displyed on screen.
  }  


  \item{copyright}{
    Boolean. If a copyright message should be plotted.
    Default is FALSE.
  }
  
   \item{...}{
      Further optional arguments passed to \code{barplot}.
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

## unique model acronyms are required for reconstruction
wuxtest.df$acronym <- factor(paste(wuxtest.df$institute, "_",
wuxtest.df$rcm, sep="")) 

## reconstruction of the  missing data
reconstructLES.df <- reconstruct(wuxtest.df, factor1.name =
"acronym", factor2.name = "gcm", data.name =
"perc.delta.precipitation_amount") 

## calculate ANOVA
anova.list <- aovWux(perc.delta.precipitation_amount ~ acronym +
gcm, reconstructLES.df)

## barplot of ANOVA results
\dontrun{plot(anova.list, ss.relative = TRUE, las = 1,
sd.unit = "\%", legend.text = c("RCM", "GCM", "RES"), mgp = c(2.5,1,0),
main = "ANOVA Barplot", ylim = c(0,110))
}
}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ hplot }% __ONLY ONE__ keyword per line
\keyword{ models }% __ONLY ONE__ keyword per line
\keyword{ regression }% __ONLY ONE__ keyword per line
