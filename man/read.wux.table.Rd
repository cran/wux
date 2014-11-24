\name{read.wux.table}
\alias{read.wux.table}

\title{
Reads in wux data.frame from harddisk
}
\description{
Reads in wux csv file obtained from \code{\link{models2wux}} from harddisk and creates a data frame from it
}

\usage{
read.wux.table(file, ...)
}

\arguments{
  \item{file}{
    the name of the file which the data are to be read from.
   }
  
  \item{\dots}{
     Further arguments to be passed to \code{\link{read.table}}.
 }
 
}
\author{
  Thomas Mendlik \email{thomas.mendlik@uni-graz.at}
}

\examples{
## read WUX test data
\dontrun{wux.data.frame <- read.wux.table("~/dir/to/data/ensembles_diff.csv")}
}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ IO }
\keyword{ file }% __ONLY ONE__ keyword per line
