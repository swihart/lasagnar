#' @name wr.disc
#' @title within-row sorting of discrete values
#' @param X a matrix: each row a subject, each column a time/location across subjects
#' @param orderVar a vector with the unique elements of X presented in the order of the desired
#' resultant sorting
#' @param colorSeq ideally the elements of 'palette' of the original lasagna plot in the corresponding order of `orderVar`
#' @param naLast defaults to false; should NA values be sorted to first position or last. Defaults to FALSE.
#' ## within-row for discrete
wr.disc <- function(X, orderVar=c(), colorSeq, naLast=F){
  P <- matrix(NA, nrow=nrow(X), ncol=ncol(X))
  ##make priority mask
  for(i in 1:length(colorSeq) ){        P[ X==colorSeq[i] ] <- i  }
  sortedWR <-  apply( P, 1, function(W) sort(W,na.last = naLast ))
  ## transposed so output matrix is same orientation as input matrix
  sortedWR <- t(sortedWR)
  ## undo mask
  P <- matrix(NA, nrow=nrow(X), ncol=ncol(X))
  for(i in 1:length(colorSeq)  ){       P[ sortedWR==i ] <- colorSeq[i] }
  P
}
