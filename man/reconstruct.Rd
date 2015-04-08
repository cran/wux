\encoding{UTF-8}

\name{reconstruct}

\alias{reconstruct}

\title{
Missing value reconstruction based on ANOVA
}

\description{
Performs a simple missing value reconstruction based on an ANOVA with
two factors using different methods.
}

\usage{
reconstruct(x, factor1.name, factor2.name,
 data.name, method = "LES", iterations.num = 100)
}

\arguments{
  \item{x}{
    WUX data frame of class \code{"wux.df"} obtained from \code{\link{models2wux}}
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
  \item{method}{
    One of the currently implemented methods: "LES", "Iterative" or
  "IterativeCC". See details section.
  }
  \item{iterations.num}{
    Number of iterations to be performed. Used only for \code{method}
  "Iterative" or "IterativeCC".
  }
}

\details{
  Tools for filling missing values of an unbalanced climate model
  simulation matrix (e.g. missing  RCM-GCM combinations of ENSEMBLES) in
  order to avoid biased ensemble estimates. Following methods are
  currently implemented:
  
  \subsection{\code{method = "LES"} (default)}{
    Performs a simple missing value reconstruction with two factors based on
    solving the linear equation system (LES) of the ANOVA.   The algorithm follows \enc{Déqué}{Deque} et al. (2007) but the
    reconstruction is based on solving the linear equation system (LES) of
    the ANOVA instead of reconstructing iteratively. The main advantages
    of this method are that it is much faster and can be more easily
    extended to more factors than the original one. However, keep in mind
    that the results slightly differ from the iterative procedure proposed
    by \enc{Déqué}{Deque} et al. (2007). The reconstruction algorithm is
    based on unique factor combinations (i.e. one element per combination
    of \code{factor1.name} and \code{factor2.name}).
  }
  
  \subsection{\code{method = "Iterative"}}{
    The data reconstruction follows the iterative procedure based on the
    ANOVA proposed by \enc{Déqué}{Deque} et al. (2007). The reconstruction
    algorithm is based on unique factor combinations (i.e. one element per
    combination of \code{factor1.name} and \code{factor2.name}).
  }
  
  \subsection{\code{method = "IterativeCC"}}{
    Performs a leave one out cross calculation (CC) of the ANOVA based
    missing value reconstruction with two factors based on and following the
    iterative procedure of \code{method = "Iterative"}.
  }
}

\references{
  \enc{Déqué}{Deque} M, Rowell DP, \enc{Lüthi}{Luethi} D, Giorgi F,
  Christensen JH, Rockel B, Jacob D,  \enc{Kjellström}{Kjellstroem} E,
  de Castro M, van den Hurk B. 2007. An intercomparison of regional
  climate simulations for Europe: Assessing uncertainties in model
  projections. Climatic Change 81: 53--70. DOI:10.1007/s10584-006-9228-x.
}

\author{
  Georg Heinrich \email{g.heinrich@uni-graz.at} and
  Thomas Mendlik \email{thomas.mendlik@uni-graz.at} }

\value{
  Returns a WUX data frame containing the reconstructed data of class
  \code{c("rwux.df", "wux.df", "data.frame")}. 
}

\examples{
## load WUX and read WUX test data
require(wux)
data(ensembles)

wuxtest.df <- subset(ensembles, subreg == "GAR")

## unique model acronyms are required for reconstruction
wuxtest.df$acronym <- factor(paste(wuxtest.df$institute, "_", wuxtest.df$rcm, sep=""))

## reconstruction of the  missing data
reconstructLES.df <- reconstruct(wuxtest.df,
  factor1.name = "acronym", factor2.name = "gcm", data.name =
  "perc.delta.precipitation_amount", method = "LES")

## reconstruction of the  missing data using iterative apporach from
## Deque et al (2007)
reconstructIterative.df <- reconstruct(wuxtest.df,
  factor1.name = "acronym", factor2.name = "gcm", data.name =
  "perc.delta.precipitation_amount", method = "Iterative",
  iterations.num = 10)

## reconstruction of the  missing data using iterative apporach with
## cross-calculation. This can take some time.
\dontrun{reconstructIterative.df <- reconstruct(wuxtest.df,
  factor1.name = "acronym", factor2.name = "gcm", data.name =
  "perc.delta.precipitation_amount", method = "IterativeCC",
  iterations.num = 10)}
}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ datagen }% __ONLY ONE__ keyword per line
\keyword{ models }% __ONLY ONE__ keyword per line
\keyword{ regression }% __ONLY ONE__ keyword per line
\keyword{ classes }% __ONLY ONE__ keyword per line
\keyword{ NA }% __ONLY ONE__ keyword per line
\keyword{ iteration }% __ONLY ONE__ keyword per line
