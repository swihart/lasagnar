#' @name wc.disc
#' @title within-column sorting of discrete values
#' @param X a matrix: each row a subject, each column a time/location across subjects
#' @param colorSeq a vector with the unique elements of X presented in the order of the desired
#' resultant sorting.  Defaults to having lowest value sort to the bottom, highest value to the top.
#'  @param naLast defaults to false; should NA values be sorted to first position or last. Defaults to FALSE.
#' ## within-column for discrete
#' 
#' 
wc.disc <- function(X, colorSeq=rev(sort(unique(X))), naLast=F ){
  P <- X
  ## set colnames with time / location / column index:
  #colnames(P)<-paste0(seq(ncol(P)),"/",ncol(P))
  ## name your dimensions
  #names(dimnames(P))[2]<-c('Proportion')
  P[,] <- NA
  ##make priority mask
  for(i in 1:length(colorSeq) ){        P[ X==colorSeq[i] ] <- i  }
  sorted <- apply( P, 2, function(W) sort(W,na.last = naLast ) )
  ## don't need t() like I do in wr.disc
  ## undo mask
  names(dimnames(P))[1]<-c('Proportion')
  P[,] <- NA
  for(i in 1:length(colorSeq)  ){       P[ sorted==i ] <- colorSeq[i] }
  P
}