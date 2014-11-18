#' @name er
#' @title entire-row sorting 
#' @param X a matrix: each row a subject, each column a time/location across subjects
#' @param orderVar a scalar; one of the values in X upon which the percentage of occurence will determine the ordering of the rows. 
#' Defaults to the minimum value of X
#'  @param naLast defaults to false; should NA values be sorted to first position or last. Defaults to FALSE.
#' 
## entire row sort
er <- function(X,orderVar=min(X,na.rm=TRUE), naLast=F){
  if (length(orderVar) == 1){
    perc <- apply( X, 1, function(W){ sum(W==orderVar)  })
    return(X[order(perc), ])
  }
  X[order(orderVar), ]
}