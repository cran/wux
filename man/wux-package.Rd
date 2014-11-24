\name{wux-package}
\alias{wux-package}
\alias{wux}
\docType{package}
\title{
Wegener Center Climate Uncertainty Explorer
}
\description{
  
The WUX package is a toolbox to analyze climate change uncertainties
projected by numerical model simulations.

The package provides methods to calculate and interpret climate change
 signals and time series from entire multi-model ensembles. Climate
 model output in binary NetCDF format is read in and aggregated to a
 \code{data.frame} for statistical analysis with tools provided by the R
 environment. The NetCDF format is not restricted to any specific type
 of climate model. Global circulation models (GCMs), as the CMIP5 or
 CMIP3 simulations, can be read in the same way as Regional Climate
 Models (RCMs), as e.g. the CORDEX or ENSEMBLES simulations.

}
\details{
  This package can currently perform following actions:
  \itemize{
    \item Reading output of climate model simulations from NetCDF
    files, processing it, and writing it to a \code{data.frame} (the
    so-called WUX data frame).
    \item Various plotting options and summarizing utilities for a
    descriptive analysis of the projected  climate change signals.
    \item Performing an Analysis of Variance (ANOVA) in order to
    estimate variance components.
    \item Performing a simple two-way linear data reconstruction, in
    order to fill the missing values of a simulation matrix as e.g. the
    GCM-RCM simulation matrix of ENSEMBLES. 
%    \item Making your life easier with some useful helperfunctions
%    (actually there's only one right now...).
  }
}

\section{I. Reading, processing, and writing of climate model ouput}{

  \tabular{ll}{
    Functions: \cr
    \code{\link{models2wux}} \tab Reads NetCDF climate model output,
    processes it, and writes the results to a \code{data.frame} which
    is the backbone of all further WUX analyses\cr
    \code{\link{CMIP5fromESGF}} \tab Automated downloading of the
    CMIP5 multi-model climate ensemble  \cr
    \code{\link{read.wux.table}} \tab Reads in wux csv file obtained from
    \code{\link{models2wux}} from harddisk and creates a data frame from
    it (same \code{data.frame} as \code{models2wux} returns interactively)\cr
    \code{\link{AverageWuxDataFrame}} \tab WUX data frame averaging function\cr
    Datasets: \cr
    \code{\link{userinput_CMIP5_changesignal}},\cr
    \code{\link{userinput_CMIP5_timeseries}}, \cr  \code{\link{modelinput_test}} \tab Example config
    files for \code{\link{models2wux}}
    \cr
    \code{\link{ensembles}}, \code{\link{ensembles_gcms}},\cr
    \code{\link{cmip3_2050}},  \code{\link{cmip3_2100}}, \cr
    \code{\link{cmip5_2050}}, \code{\link{cmip5_2100}},\cr
 \code{\link{CMIP5_example_changesignal}}, \cr
    \code{\link{CMIP5_example_timeseries}}  \tab Example  data frames
    calculatated by \code{models2wux}\cr
  }
}

\section{II. Descriptive analysis of climate change signals}{
  Descriptive analysis of multiple climate model simulations.
  \tabular{ll}{
    \code{\link{summaryWux}} \tab Summary statistics of the WUX
    data frame \cr
    \code{\link{ScatterplotWux}} \tab Scatter Plot \cr
    \code{\link{HistplotWux}} \tab Density Plot \cr
    \code{\link{AnnualCycleplotWux}} \tab Annual Cycle Plot \cr
  }
}

\section{III. Analysis of variance components}{
  Extracts variance components of multiple climate model simulations
  using an ANOVA.
    \tabular{ll}{
  \code{\link{WuxAnova}} \tab ANOVA for WUX \code{data.frame} \cr
  \code{\link{AnovaBarplotWux}} \tab barplot for \code{\link{WuxAnova}}
  output\cr
  }
}

\section{IV. Reconstruction tools}{
  Tools for filling missing values of an unbalanced climate model
  simulation matrix (e.g. missing  RCM-GCM combinations of ENSEMBLES) in
  order to avoid biased ensemble estimates. Currently, the underlying
  reconstrtuction technique is based on an ANOVA.
    \tabular{ll}{
  \code{\link{AnovaReconstructLES}} \tab Linear reconstruction based on
  solving the linear equation system (LES) of the ANOVA design matrix\cr
  \code{\link{AnovaReconstructIterative}} \tab Iterative linear
  reconstruction based on an ANOVA\cr
  \code{\link{AnovaReconstructIterativeCC}} \tab Leave-one-out
  cross-calculation (CC) for \code{\link{AnovaReconstructIterative}}\cr
  }
}

%\section{IV. Helperfunctions}{
%  wrapTo180 and wrapTo360
%}


\author{
Thomas Mendlik \email{thomas.mendlik@uni-graz.at}, Georg Heinrich
\email{g.heinrich@uni-graz.at}, Andreas Gobiet
\email{andreas.gobiet@uni-graz.at} and Armin Leuprecht
\email{armin.leuprecht@uni-graz.at}

Maintainer: Thomas Mendlik \email{thomas.mendlik@uni-graz.at}
}
\keyword{ package }
