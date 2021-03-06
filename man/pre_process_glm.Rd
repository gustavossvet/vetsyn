\docType{methods}
\name{pre_process_glm}
\alias{pre_process_glm}
\title{\code{pre_process_glm}}
\arguments{
  \item{x}{a syndromic (\code{syndromicD} or
  \code{syndromicW}) object, which must have at least the
  slot of observed data and a data frame in the slot
  dates.}

  \item{slot}{the slot in the \code{syndromic} object to be
  processed, by default, "observed", but this argument can
  be used to change it to "baseline"}

  \item{syndromes}{an optional parameter, if not specified,
  all columns in the slot observed (or baseline if that was
  chosen in the previous parameter) of the \code{syndromic}
  object will be used. The user can choose to restrict the
  analyses to a few syndromic groups listing their name or
  column position in the observed matrix. See examples.}

  \item{family}{the GLM distribution family used, by
  default "poisson". if "nbinom" is used, the function
  glm.nb is used instead.}

  \item{formula}{the regression formula to be used. The
  following arguments are accepted for DAILY data
  (\code{syndromicD} class objects provided): trend (for a
  monotonic trend), year, month, dow (day of week), sin,
  cos, Ar1 (auto-regressive for 1 days) to AR7. For WEEKLY
  data (\code{syndromicW} class objects provided): trend,
  sin, cos, year and 1 to 4 autoregressive variables. These
  elements can be combined into any formula. The default
  for DAILY data is
  formula="dow+sin+cos+Ar1+Ar2+AR3+AR4+AR5" and for WEEKLY
  data "trend+sin+cos" See examples.}

  \item{frequency}{in case pre-processing is applied using
  "glm" AND the sin/cos functions are used, the cycle of
  repetitions need to be set. The default is a year (365
  days or 52 weeks).}

  \item{plot}{whether plots comparing observed data and the
  result of the pre-processing should be displayed.}

  \item{print.model}{whether the result of model fitting
  should be printed on the console. This is recommended
  when the user is exploring which dependent variables to
  keep or drop.}
}
\value{
  A matrix with all the pre-processed vectors.
}
\description{
  Function to remove known temporal effects from time
  series. It fits a glm model to the time series, and
  delivers the residuals.
}
\details{
  This function is provided for users interested in
  capturing (saving or plotting) the results of this
  pre-processing step. However, in the context of syndromic
  surveillance through objects of the class syndromic
  (\code{syndromicD} or \code{syndromicW}), pre-processing
  is performed in conjunction with the application of
  control-charts, saving results into an object of the
  class \code{syndromic} (D or W) (within detection
  algorithms. - See ewma_synd(), shew_synd() and
  cusum_synd())
}
\examples{
data(lab.daily)
my.syndromicD <- raw_to_syndromicD (id=SubmissionID,
                                 syndromes.var=Syndrome,
                                 dates.var=DateofSubmission,
                                 date.format="\%d/\%m/\%Y",
                                 remove.dow=c(6,0),
                                 add.to=c(2,1),
                                 data=lab.daily)
pre_processed_data <- pre_process_glm(my.syndromicD)
pre_processed_data <- pre_process_glm(my.syndromicD,
                              syndromes="Musculoskeletal")
pre_processed_data <- pre_process_glm(my.syndromicD,
                              syndromes=c("GIT","Musculoskeletal"))
pre_processed_data <- pre_process_glm(my.syndromicD,
                              syndromes=3)
pre_processed_data <- pre_process_glm(my.syndromicD,
                              syndromes=c(1,3))

pre_processed_data <- pre_process_glm(my.syndromicD,
                              family="nbinom")
data(lab.daily)
my.syndromicW <- raw_to_syndromicW (id=SubmissionID,
                                 syndromes.var=Syndrome,
                                 dates.var=DateofSubmission,
                                 date.format="\%d/\%m/\%Y",
                                 data=lab.daily)
pre_processed_data <- pre_process_glm(my.syndromicW)
pre_processed_data <- pre_process_glm(my.syndromicW,
                              syndromes="Musculoskeletal")
pre_processed_data <- pre_process_glm(my.syndromicW,
                              syndromes=c("GIT","Musculoskeletal"))
pre_processed_data <- pre_process_glm(my.syndromicW,
                              syndromes=3)
pre_processed_data <- pre_process_glm(my.syndromicW,
                              syndromes=c(1,3))

pre_processed_data <- pre_process_glm(my.syndromicW,
                              family="nbinom")
pre_processed_data <- pre_process_glm(my.syndromicW,slot="baseline")
}
\references{
  Fernanda C. Dorea, Crawford W. Revie, Beverly J. McEwen,
  W. Bruce McNab, David Kelton, Javier Sanchez (2012).
  Retrospective time series analysis of veterinary
  laboratory data: Preparing a historical baseline for
  cluster detection in syndromic surveillance. Preventive
  Veterinary Medicine. DOI:
  10.1016/j.prevetmed.2012.10.010.
}
\keyword{methods}

