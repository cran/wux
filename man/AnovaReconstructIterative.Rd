\encoding{UTF-8}

\name{AnovaReconstructIterative}

\alias{AnovaReconstructIterative}

\title{
Missing value reconstruction based on ANOVA
}

\description{
Performs a simple missing value reconstruction based on an ANOVA with
two factors using an iterative procedure.
}

\usage{
AnovaReconstructIterative(datain.df, factor1.name, factor2.name,
 data.name, iterations.num)
}

\arguments{
  \item{datain.df}{
    WUX data frame obtained from \code{\link{models2wux}}
  }
  \item{factor1.name}{
    Name of the 1st factor.
  }
  \item{factor2.name}{
    Name of the 2nd factor.
  }
  \item{data.name}{
    Name of the variable to be reconstructed.
  }
  \item{iterations.num}{
    Number of iterations to be performed.
  }
}

\details{
  The data reconstruction follows the iterative procedure based on the
  ANOVA proposed by \enc{Déqué}{Deque} et al. (2007). The reconstruction
  algorithm is based on unique factor combinations (i.e. one element per
  combination of \code{factor1.name} and \code{factor2.name}).  
}

\references{
  \enc{Déqué}{Deque} M, Rowell DP, \enc{Lüthi}{Luethi} D, Giorgi F,
  Christensen JH, Rockel B, Jacob D,  \enc{Kjellström}{Kjellstroem} E,
  de Castro M, van den Hurk B. 2007. An intercomparison of regional
  climate simulations for Europe: Assessing uncertainties in model
  projections. Climatic Change 81: 53--70. DOI:10.1007/s10584-006-9228-x.
}

\author{
  Georg Heinrich \email{g.heinrich@uni-graz.at}
}

\note{
  Returns a WUX data frame containing the reconstructed data. 
}

\examples{
## load WUX and read WUX test data
require(wux)
data(ensembles)

wuxtest.df <- subset(ensembles, subreg == "GAR")

## unique model acronyms are required for reconstruction
wuxtest.df$acronym <- factor(paste(wuxtest.df$institute, "_", wuxtest.df$rcm, sep=""))

## reconstruction of the  missing data
reconstructIterative.df <- AnovaReconstructIterative(wuxtest.df,
  factor1.name = "acronym", factor2.name = "gcm", data.name =
  "perc.delta.precipitation_amount", iterations.num = 100)
}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ datagen }% __ONLY ONE__ keyword per line
\keyword{ models }% __ONLY ONE__ keyword per line
\keyword{ regression }% __ONLY ONE__ keyword per line
\keyword{ classes }% __ONLY ONE__ keyword per line
\keyword{ NA }% __ONLY ONE__ keyword per line
\keyword{ iteration }% __ONLY ONE__ keyword per line
