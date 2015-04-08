\encoding{UTF-8}

\name{aovWux}

\alias{aovWux}

\title{
Missing value reconstruction based on ANOVA
}

\description{
Calculates an analysis of variance (ANOVA) based on the specified model.
}

\usage{
aovWux(model.formula = formula(model.formula), datain.df)
}

\arguments{
  \item{model.formula}{
    Model formula used for \code{\link{aov}}.
  }
  \item{datain.df}{
    WUX dataframe obtained from \code{\link{models2wux}}.
  }
}

\value{
  Returns a object of class \code{wux.aov}, a list containing the
  ANOVA results for each subregion and season. The names of the list
  entries are "subreg = xx;season = yy".
}

\author{
  Georg Heinrich \email{g.heinrich@uni-graz.at}
}

\examples{
## read WUX test data
library("wux")
data(ensembles)

wuxtest.df <- subset(ensembles, subreg == "GAR")

## data reconstruction to obtain a balanced design
reconstruct.df <- reconstruct(wuxtest.df,
  factor1.name = "acronym", factor2.name = "gcm", data.name =
  "perc.delta.precipitation_amount")

## calculate ANOVA
anova.list <- aovWux(perc.delta.precipitation_amount ~ acronym +
  gcm, reconstruct.df)
}

\keyword{ datagen }% __ONLY ONE__ keyword per line
\keyword{ models }% __ONLY ONE__ keyword per line
\keyword{ regression }% __ONLY ONE__ keyword per line
\keyword{ classes }% __ONLY ONE__ keyword per line
\keyword{ NA }% __ONLY ONE__ keyword per line
