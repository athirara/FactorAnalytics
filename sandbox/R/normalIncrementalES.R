#' compute normal incremental ES given portfolio weights, mean vector and
#' covariance matrix.
#' 
#' compute normal incremental ES given portfolio weights, mean vector and
#' covariance matrix.Incremental ES is defined as the change in portfolio ES
#' that occurs when an asset is removed from the portfolio.
#' 
#' 
#' @param mu n x 1 vector of expected returns.
#' @param Sigma n x n return covariance matrix.
#' @param w n x 1 vector of portfolio weights.
#' @param tail.prob scalar tail probability.
#' @return n x 1 vector of incremental ES values.
#' @author Eric Zivot and Yi-An Chen
#' @references Jorian, P. (2007). Value at Risk, pg. 168.
#' @examples
#' 
#' data(managers.df)
#' ret.assets = managers.df[,(1:6)]
#' mu <- mean(ret.assets[,1:3])
#' Sigma <- var(ret.assets[,1:3])
#' w <- rep(1/3,3)
#' normalIncrementalES(mu,Sigma,w)
#' 
#' # given some Multinormal distribution
#' normalIncrementalES(mu=c(1,2),Sigma=matrix(c(1,0.5,0.5,2),2,2),w=c(0.5,0.5),tail.prob = 0.01)
#' 
normalIncrementalES <-
function(mu, Sigma, w, tail.prob = 0.01) {
## purpose: compute normal incremental ES given portfolio weights, mean vector and
## covariance matrix
## Incremental ES is defined as the change in portfolio ES that occurs
## when an asset is removed from the portfolio
## inputs:
## mu         n x 1 vector of expected returns
## Sigma      n x n return covariance matrix
## w          n x 1 vector of portfolio weights
## tail.prob  scalar tail probability
## output:
## iES      n x 1 vector of incremental ES values
## References:
## Jorian, P. (2007). Value at Risk,  pg. 168.
  mu = as.matrix(mu)
  Sigma = as.matrix(Sigma)
  w = as.matrix(w)
  if ( nrow(mu) != nrow(Sigma) )
    stop("mu and Sigma must have same number of rows")
  if ( nrow(mu) != nrow(w) )
    stop("mu and w must have same number of elements")
  if ( tail.prob < 0 || tail.prob > 1)
    stop("tail.prob must be between 0 and 1")
  
  n.w = nrow(mu)
  ## portfolio ES with all assets
  pES = -(crossprod(w, mu) - sqrt( t(w) %*% Sigma %*% w )*dnorm(qnorm(tail.prob))/tail.prob) 
  temp.w = w
  iES = matrix(0, n.w, 1)
  for (i in 1:n.w) {
  ## set weight for asset i to zero and renormalize
    temp.w[i,1] = 0
    temp.w = temp.w/sum(temp.w)
    pES.new = -(crossprod(temp.w, mu) - sqrt( t(temp.w) %*% Sigma %*% temp.w )*dnorm(qnorm(tail.prob))/tail.prob ) 
    iES[i,1] = pES.new - pES
  ## reset weight
    temp.w = w
  }
  return(iES)
}

