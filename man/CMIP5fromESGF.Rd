\name{CMIP5fromESGF}
\alias{CMIP5fromESGF}

\title{
  Downloads CMIP5 climate simulations from the ESGF data portal
}

\description{
  Downloads available monthly CMIP5 simulations from ESGF data portal. You need an account at any ESGF node
  (see \url{http://cmip-pcmdi.llnl.gov/cmip5/data_getting_started.html}). This
  function creates subdirectories for each climate
  simulation in the specified folder, automatically recieves the
  bash scripts needed for the partiular
  simulation-variable-experiment combination and then executes the bash
  scripts one by one. An external PYTHON script is called for this task.
  If either data or bash-scripts exist, the download will be skipped.
  Use this function with care. You need a working internet connection
  for this function to work.
}

\usage{
CMIP5fromESGF(save.to = NULL, variables = NULL,
              experiments = NULL, models = NULL)
}

\arguments{

  \item{save.to}{ Directory location for downloading CMIP5 data and bash
  scripts.  ATTENTION: subdirectories for each model-experiment
  combination will be created!  }
  
  \item{variables}{ Short variable names for meteorological parameters
   of interest (e.g. "tas" for 2m air temperature or "pr" for
   precipitation amount). See e.g.  the IPCC Standard Output from GCMs
   (\url{http://www-pcmdi.llnl.gov/ipcc/standard_output.html}).  }
 
  \item{experiments}{ Experiment of the climate simulation
    (e.g. c("historical", "rcp45"), see Taylor (2012) for a detailed
    description.  }

  \item{models}{ Climate simulations to be downloaded. If no models are
             provided (default), all available simulations will be
             retrieved. See the "Model" column at
             \url{http://cmip-pcmdi.llnl.gov/cmip5/availability.html} for
             available simulations.  ATTENTION: This is a considerable
             amount of data, so watch out for your diskspace!}
 
 
}
\details{
  Firstly you need an ESGF account. If you do not have any, start here:
  \url{http://cmip-pcmdi.llnl.gov/cmip5/data_getting_started.html}
  
  
  This function calls an external python script which 
  \enumerate{
    \item looks for the latest CMIP5 models at ESGF \url{http://pcmdi9.llnl.gov}
    \item generates a local directory structure where the data will be stored
    \item receives the corresponding bash files from ESGF
    \item executes the bash files.
  }
  You can find the location of the script with
  \code{system.file("exec", "CMIP5_downloader.py", package="wux")}

  This function is an alternative to downloading the corresponding
  models by point-and-click on the ESGF node (as
  \url{http://pcmdi9.llnl.gov} or \url{http://esgf-data.dkrz.de}), as it takes
  advantage of the ESGF search API mechanism for automated data screening
  and wget-script generation. For thei nterested user more information
  on downloading strategies is available at
  \url{https://github.com/ESGF/esgf.github.io/wiki/ESGF_Data_Download_Strategies}. 
  
}

\section{Warning}{
  This function automatically creates new directories on your system,
  downloads wget scripts, flags them execueable and runs them, which
  can download quite some data. 
  
}

\references{
 Karl E. Taylor, Ronald J. Stouffer, and Gerald A. Meehl, 2012: An Overview of CMIP5 and
 the Experiment Design. Bull. Amer. Meteor. Soc., 93, 485-498.  doi:
 http://dx.doi.org/10.1175/BAMS-D-11-00094.1
}

\author{
  Thomas Mendlik \email{thomas.mendlik@uni-graz.at}
}

\note{
  Use with care, your harddisk might get stuffed. This tools works on
  unix platforms only.
}

\examples{
\dontrun{
## download temperature fields of two example GCMs (NorESM1-M and
## CanESM2) with the  RCP 8.5 and the historical run
## into your temporary directory. This command will create a folder
## "CMIP5" in "~/tmp" with two subfolders for each model again with
## two subfolders for each experiment.
CMIP5fromESGF(save.to = "~/tmp/CMIP5/",
              models = c("NorESM1-M", "CanESM2"),
              variables = c("tas"),
              experiments= c("historical", "rcp85"))
}
}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ IO }
\keyword{ file }% __ONLY ONE__ keyword per line
\keyword{ connection }% __ONLY ONE__ keyword per line
\keyword{ database }% __ONLY ONE__ keyword per line
\keyword{ programming }
\keyword{ interface }
