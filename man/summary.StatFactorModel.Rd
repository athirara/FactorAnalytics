\name{summary.StatFactorModel}
\alias{summary.StatFactorModel}
\title{summary method for StatFactorModel object.}
\usage{
  \method{summary}{StatFactorModel} (object, digits = 3,
    ...)
}
\arguments{
  \item{object}{An Object created by
  \code{fitStatisticalFactorModel}.}

  \item{digits}{Integer indicates the number of decimal
  places. Default is 3.}

  \item{...}{other option used in \code{print} method.}
}
\description{
  Generic function of summary method for
  \code{fitStatisticalFactorModel}.
}
\examples{
# load data from the database
data(stat.fm.data)
# fit the factor model with OLS
fit <- fitStatisticalFactorModel(sfm.dat,k=2)
summary(fit)
}
\author{
  Yi-An Chen.
}

