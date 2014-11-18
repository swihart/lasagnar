#' @name er
#' @title entire-row sorting 
#' @param X a matrix: each row a subject, each column a time/location across subjects
#' @param orderVar a vector with the unique elements of X presented in the order of the desired
#' resultant sorting
#'  @param naLast defaults to false; should NA values be sorted to first position or last. Defaults to FALSE.
#' 
## entire row sort
er <- function(X,orderVar=sort(unique(X)), naLast=F){
  if (length(orderVar) == 1){
    perc <- apply( X, 1, function(W){ sum(W==orderVar)  })
    return(X[order(perc), ])
  }
  X[order(orderVar), ]
}