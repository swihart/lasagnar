#' @name wr.disc
#' @description Sorts discrete matrices within rows
#' @title within-row sorting of discrete values
#' @param X a matrix: each row a subject, each column a time/location across subjects
#' @param colorSeq a vector with the unique elements of X presented in the order of the desired
#' resultant sorting
#' @param naLast defaults to false; should NA values be sorted to first position or last. Defaults to FALSE.
#' @export
#' @details \code{wc} sorts within-columns, scrambling the subject-specific nature 
#' of the rows but revealing a group-level temporal patterns.  As with \code{wr} 
#' there is a discrete and continuous implementation \code{wc.disc} 
#' and \code{wc.cont}
wr.disc <- function(X, colorSeq=sort(unique(X)), naLast=FALSE){
  P <- X
  ## set colnames with time / location / column index:
  #colnames(P)<-paste0(seq(ncol(P)),"/",ncol(P))
  ## name your dimensions
  #names(dimnames(P))[2]<-c('Proportion')
  P[,] <- NA
  ##make priority mask
  for (i in 1:length(colorSeq) ) {        
    P[ X == colorSeq[i] ] <- i  
  }
  sortedWR <-  apply( P, 1, function(W) sort(W,na.last = naLast ))
  ## transposed so output matrix is same orientation as input matrix
  sortedWR <- t(sortedWR)
  ## undo mask
  #P <- X
  ## set colnames with time / location / column index:
  #colnames(P)<-paste0(seq(ncol(P)),"/",ncol(P))
  ## name your dimensions
  names(dimnames(P))[2] <- c('Proportion')
  P[,] <- NA
  for (i in 1:length(colorSeq) ) {       
    P[ sortedWR == i ] <- colorSeq[i] 
    }
  P
}

