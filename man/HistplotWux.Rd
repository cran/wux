\name{HistplotWux}
\alias{HistplotWux}

\title{
Plots histograms and kernel density estimates 
}

\description{
HistplotWux plots either one or two histograms and the according kernel
density estimates using \code{density}.

This plotting routine extracts all the information from the input
dataframe which has to be 'WUX-style' (see \code{\link{models2wux}}).
}

\usage{
HistplotWux(datain1.df, datain2.df = NULL, var.name = NULL,
subreg.subset = NULL, season.subset = NULL, plot.density = TRUE,
%% plot.lmm.density = FALSE, 
hist1.col = "red", hist2.col = "blue", bw = "nrd0", kernel = "gaussian",
mark.df = NULL, plot.legend = FALSE,  xlim = NULL, ylim = NULL,
xtick.number = 10, ytick.number = 10, xminor.tick = FALSE, yminor.tick =
FALSE, xlab = NULL, ylab = "Probability Density", main =
NULL, out.file.directory = NULL, out.file.name = NULL, copyright = FALSE, ...)
}

\arguments{
  \item{datain1.df}{
    1st WUX dataframe obtained from \code{\link{models2wux}}.
  }

  \item{datain2.df}{
    2nd WUX dataframe obtained from \code{\link{models2wux}}.
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

  \item{plot.density}{
    Boolean. Indicating if kernel density estimates should be
    plotted. Default is \code{TRUE}.
  }

  %% \item{plot.lmm.density}{ Boolean. Indicating if normal density
  %%   estimates from a Linear Mixed effects model should be plotted using
  %%   the \code{lme4} package. This is only possible when evaluating
  %%   RCMs. It fits the corresponding parameter (e.g. temperature change)
  %%   letting the \code{rcm} and the \code{gcm} factor be a random effect
  %%   (\code{... ~ 1 + (1|gcm) + (1|rcm)}). This makes sense if the
  %%   RCM-GCM matrix is unbalanced. Default is \code{FALSE}
  %%   (experimental).  }
  
  \item{hist1.col}{
    Character string of the 1st histogram color (e.g. \code{"red"}).
  }
  
  \item{hist2.col}{
    Character string of the 2nd histogram color (e.g. \code{"blue"}). 
  }

  \item{bw}{
    The smoothing bandwidth to be used in \code{density}. Default is
    \code{"nrd0"}.
  }

  \item{kernel}{
    A character string giving the smoothing kernel to be used in
    \code{density}. This must be one of \code{"gaussian"},
    \code{"rectangular"}, \code{"triangular"},
    \code{"epanechnikov"},\code{"biweight"}, \code{"cosine"} or
    \code{"optcosine"} with default \code{"gaussian"}.
  }

  \item{mark.df}{
    Subset of WUX dataframe indicating the models to be marked.
  }
 
  \item{plot.legend}{
    Boolean. Indicating if a plot legend indicating the models of mark.df and
    sample size should be plotted. Default is \code{FALSE}.
  }

  \item{xlim}{
    Range vector for the x-axis.
  }
  
  \item{ylim}{
    Range vector for the y-axis.
  }

  \item{xtick.number}{
    Number of ticks for the x-axis with default \code{10}.
  }

  \item{ytick.number}{
    Number of ticks for the y-axis with default \code{10}.
  }  

  \item{xminor.tick}{
    Boolean. Indicating if minor ticks for the x-axis should be
    plotted. Default is \code{FALSE}.
  }

  \item{yminor.tick}{
    Boolean. Indicating if minor ticks for the y-axis should be
    plotted. Default is \code{FALSE}.
  }  

  \item{xlab}{
    Label for x-axis.
  }
  
  \item{ylab}{
    Label for y-axis with default \code{Probability Density}.
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
    \code{out.file.name = "histogram"} will store to the files to
    \code{histogram_EUROPE_DJF.eps} and \code{histogram_EUROPE_JJA.eps}. If
    neither \code{out.file.name} nor \code{out.file.directory} are
    passed, the plot will be displyed on screen.
  }  

  \item{copyright}{
    Boolean. If a copyright message should be plotted.
    Default is FALSE.
  }

   \item{...}{
      Further optional arguments passed to \code{hist}.
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

## set dataframe for model marks
mark.df <- subset(wuxtest.df, acronym \%in\% c("ICTP-REGCM3", "MPI-M-REMO"))
mark.df <- droplevels(mark.df)

## histogram plot
\dontrun{HistplotWux(datain1.df = wuxtest.df, var.name =
  "perc.delta.precipitation_amount", xlim = c(-50,50), ylim = c(0,0.12),
  xtick.number = 9, xminor.tick = TRUE,  ytick.number = 5,
  yminor.tick = TRUE, xlab = "Precipitation Amount [\%]", main =
  "WUX histogram", plot.legend = TRUE, mark.df = mark.df, hist1.col =
  "dark blue")

graphics.off()}
}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ hplot }
\keyword{ distribution }% __ONLY ONE__ keyword per line
\keyword{ univar }% __ONLY ONE__ keyword per line
