#' @description Sorts continuous matrices within columns
#' @title Within-column sorting of continuous values
#' @param X a matrix: each row a subject, each column a time/location across subjects
#' @param colorSeq a vector with the unique elements of X presented in the order of the desired
#' resultant sorting
#' @param naLast defaults to false; should NA values be sorted to first position or last. Defaults to FALSE.
#' @export
#' @details \code{wc} sorts within-columns, scrambling the subject-specific nature 
#' of the rows but revealing a group-level temporal patterns.  As with \code{wr} 
#' there is a discrete and continuous implementation \code{wc.disc} 
#' and \code{wc.cont}
wc.cont <- function(X, naLast=FALSE ){
  sorted <- apply( X, 2, function(W) sort(W,na.last = naLast ) )
  sorted
}
