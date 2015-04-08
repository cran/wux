\name{CMIP5toModelinput}
\alias{CMIP5toModelinput}

\title{
  Creates a "modelinput" input file based on CMIP5 data on your disk to
  be further processed by models2wux.
}

\description{ This function creates a "modelinput" list (written into a
  file). That file can then be used to have all the relevant CMIP5 model
  information available for "models2wux". The input for this function is
  the directory where \code{CMIP5fromESGF} saves all the data. It is
  crucial for this funcion that the data is saved in the same directory
  strucure as created by "CMIP5fromESGF" (GCMname/RCP) . This function
  works for CMIP5 data on monthly basis only and can currently process
  only the parameters "air_temperature" and "precipitation_amount".  }

\usage{
CMIP5toModelinput(filedir = NULL, save.to = NULL, verbose = FALSE)
}

\arguments{
    filedir: Direcotry where the CMIP5 data are being stored.
             It is crucial for this funcion that the data is
             saved in the same directory strucure as created
             by "CMIP5fromESGF".
    save.to: character. Filename to safe the modelinupt.
    verbose: boolean. For additional information printed on the screen.

  \item{filedir}{ Direcotry where the CMIP5 data are being stored.
             It is crucial for this funcion that the data is
             saved in the same directory strucure as created
             by \code{CMIP5fromESGF}. }
  
  \item{save.to}{ character. Filename to safe the modelinupt. }
 
  \item{verbose}{ boolean. For additional information printed on the screen.}

}
\details{
  This function is based on the data obtained by
  \code{CMIP5fromESGF}. However, it is also possible to download the
  data manually and run this function. The directory structure must look
  like this: "GCMname/RCP" (e.g. \code{/tmp/CMIP5/NorESM1-M/rcp85}).

  In the background a PYTHON script is executed. You can find the file
  by typing the command
  \code{system.file("exec", "cmip5_to_wux_modeldict.py", package="wux")}  
}

\references{
 Karl E. Taylor, Ronald J. Stouffer, and Gerald A. Meehl, 2012: An Overview of CMIP5 and
 the Experiment Design. Bull. Amer. Meteor. Soc., 93, 485-498.  doi:
 http://dx.doi.org/10.1175/BAMS-D-11-00094.1
}

\author{
  Thomas Mendlik \email{thomas.mendlik@uni-graz.at}
}

\note{ This tools works on unix platforms only.  }

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

## create the corresponding modelinput list:
CMIP5toModelinput(filedir = "~/tmp/CMIP5",
                  save.to = "~/tmp/CMIP5_modelinput.R")

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
