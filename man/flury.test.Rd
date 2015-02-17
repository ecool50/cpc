\name{flury.test}
\alias{flury.test}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Flury's tests for common covariance structures
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Calculates the AIC and chi square statistics for all the applicable models in Flury's hierarchy of covariance structures for several covariance matrices.
}
\usage{
flury.test(covmats, nvec, B = FG(covmats, nvec)$B, qmax = NULL, commonvec.order = findcpc(covmats = covmats, B = B, plotting = F)$commonvec.order)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{covmats}{
Array of covariance matrices to be tested, created by a command such as \code{covmats<-array(NA,dim=c(p,p,k))}
}
  \item{nvec}{
Vector of sample sizes of the k groups.
}
  \item{B}{
Modal matrix, i.e. the orthogonal p x p matrix diagonalising the k covariance matrices simultaneously under the assumption of common principal components.
}
  \item{qmax}{
Maximum number of common eigenvectors for which to estimate the partial CPC model statistics.
}
  \item{commonvec.order}{
%%     ~~Describe \code{commonvec.order} here~~
Vector indicating the order of the most likely candidates of common eigenvectors -- from 1 (most likely) to p (least likely).
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
Returns a data frame with the following columns, containing a value for each of the models in Flury's hierarchy:
\item{Model}{Name of the model in Flury's hierarchy.}
\item{Chi.square}{Chi square statistic for the model.}
\item{DF}{Degrees of freedom associated with the chi square statistic.}
\item{Chi2.div.df}{The chi square statistic divided by its degrees of freedom.}
\item{AIC}{Akaike Information Criterion for the model.}
\item{No.of.CPCs}{Number of common eigenvectors for the model.}
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
Theo Pepler
}
\note{
%%  ~~further notes~~
Flury (1988) suggested picking the model with the lowest AIC value. Alternatively one may select the model for which the chi square statistic divided by its degrees of freedom is closest to one, although Flury (and others) cautions against this practice as the chi square statistics for the models are probably not independent of one another.
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
\code{\link{equal.test}}, \code{\link{prop.test}}, \code{\link{cpc.test}} and \code{\link{cpcq.test}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (covmats, nvec, B = FG(covmats, nvec)$B, p = dim(covmats)[1], 
    qmax = p - 2, commonvec.order = findcpc(covmats = covmats, 
        B = B, plotting = F)$commonvec.order) 
{
    if ((qmax + 2) > p) {
        qmax <- p - 2
        model.names <- c("Equality", "Proportionality", "CPC", 
            paste("CPC(", seq(from = qmax, to = 1), ")", sep = ""), 
            "Heterogeneity")
        No.of.CPCs <- c(p, p, p, (p - 2):1, 0)
    }
    else if (qmax < 1) {
        qmax <- 0
        model.names <- c("Equality", "Proportionality", "CPC", 
            "Heterogeneity")
        No.of.CPCs <- c(p, p, p, 0)
    }
    else {
        model.names <- c("Equality", "Proportionality", "CPC", 
            paste("CPC(", seq(from = qmax, to = 1), ")", sep = ""), 
            "Heterogeneity")
        No.of.CPCs <- c(p, p, p, (p - 2):1, 0)
    }
    nmodels <- length(model.names)
    chi.square <- rep(NA, times = nmodels)
    df <- rep(NA, times = nmodels)
    model.AIC <- rep(NA, times = nmodels)
    equal.test.output <- equal.test(covmats, nvec)
    chi.square[1] <- equal.test.output$chi.square
    df[1] <- equal.test.output$df
    model.AIC[1] <- AIC(equal.test.output$covmats.equal, covmats, 
        nvec, k = dim(covmats)[3], p = dim(covmats)[1], df = equal.test.output$df)
    prop.test.output <- prop.test(covmats, nvec)
    chi.square[2] <- prop.test.output$chi.square
    df[2] <- prop.test.output$df
    model.AIC[2] <- AIC(prop.test.output$covmats.prop, covmats, 
        nvec, k = dim(S)[3], p = dim(S)[1], df = prop.test.output$df)
    cpc.test.output <- cpc.test(covmats = covmats, nvec = nvec, 
        B = B)
    chi.square[3] <- cpc.test.output$chi.square
    df[3] <- cpc.test.output$df
    model.AIC[3] <- AIC(cpc.test.output$covmats.cpc, covmats, 
        nvec, k = dim(covmats)[3], p = dim(covmats)[1], df = cpc.test.output$df)
    if (qmax > 0) {
        B <- B[, commonvec.order]
        q <- qmax
        for (i in 1:qmax) {
            cpcq.test.output <- cpcq.test(covmats, nvec, B, q = q)
            chi.square[3 + i] <- cpcq.test.output$chi.square
            df[3 + i] <- cpcq.test.output$df
            model.AIC[3 + i] <- AIC(cpcq.test.output$covmats.cpcq, 
                covmats, nvec, k = dim(covmats)[3], p = dim(S)[1], 
                df = cpcq.test.output$df)
            q <- q - 1
        }
    }
    model.AIC[3 + qmax + 1] <- AIC(covmats, covmats, nvec, k = dim(covmats)[3], 
        p = dim(covmats)[1], df = 0)
    chi.square[1:(nmodels - 2)] <- chi.square[1:(nmodels - 2)] - 
        chi.square[2:(nmodels - 1)]
    df[1:(nmodels - 2)] <- df[1:(nmodels - 2)] - df[2:(nmodels - 
        1)]
    chi.div.df <- chi.square/df
    chi.square <- round(chi.square, 2)
    chi.div.df <- round(chi.div.df, 2)
    model.AIC <- round(model.AIC, 2)
    resultmat <- data.frame(Model = model.names, Chi.square = chi.square, 
        DF = df, Chi2.div.df = chi.div.df, AIC = model.AIC, No.of.CPCs = No.of.CPCs)
    return(resultmat)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line