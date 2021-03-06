\name{flury.AIC}
\alias{flury.AIC}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{AIC statistics for Flury's hierarchy
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Calculates the Akaike Information Criterion (AIC) for the higher model vs. the lower model in Flury's hierarchy of covariance matrices.
}
\usage{
flury.AIC(covmats.high, covmats.low, nvec, df)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{covmats.high }{Array of estimated covariance matrices under the higher model in Flury's hierarchy.}
  \item{covmats.low }{Array of estimated covariance matrices under the lower model in Flury's hierarchy.}
  \item{nvec }{Vector of sample sizes of the k groups.}
  \item{df }{Degrees of freedom of the higher model, versus the model of unrelated covariance matrices.}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
This is a utility function used by \code{\link{flury.test}}, but can also be called directly if required.
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
Returns the AIC value (scalar).
}
\references{
%% ~put references to the literature/web site here ~
Flury, B. (1988). Common Principal Components and Related Multivariate Models. Wiley.
}
\author{
%%  ~~who you are~~
Theo Pepler
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
\code{\link{flury.test}}
}
\examples{
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
