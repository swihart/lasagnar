#' @name dfviewr
#' @title data frame viewer
#' @param df a dataframe 
#' @param col a vector of 5 colors.  The first is for dates, second for factors, third for characters, fourth for numeric, and fifth for NA.
#' @param gridlines (logical) default TRUE.
#' @param legend (logical) defaults to TRUE.
#' @param ... Additional stuff to be passed to \code{image}
dfviewr <- function(df, col=c("red","blue","green","white","black"), axes=FALSE, 
                       main="", main.adj=0, 
                       cex.axis=1.75, 
                       gridlines=TRUE,
                       legend=TRUE, ...){
  
    
  
  ## prep the mask matrix    

  mat.out <- matrix(NA, nrow=nrow(df), ncol=ncol(df))
  
  ## then cycle through columns for types; apply is.na() at the end    
  
  ## red for dates
  mat.out[,sapply(df,is.POSIXct)] <- 1
  ## blue for factors
  mat.out[,sapply(df,is.factor)] <- 2
  ## green for characters
  mat.out[,sapply(df,is.character)] <- 3
  ## white for numeric
  mat.out[,sapply(df,is.numeric)] <- 4
  ## black for NA
  mat.out[is.na(df)] <- 5
  
  ## row names might be nice for tracing back to the original data    
  
  row.names(mat.out) <- 1:nrow(df)
  
  
  lasagna(mat.out, col=col, cex=0.67, main=main, gridlines=gridlines)
  if(legend){legend("bottom", fill=col,
                    legend=c("dates", "factors", "characters", "numeric", "NA"), 
                    horiz=T, xpd=NA, inset=c(-.15), border="black")}
  
}