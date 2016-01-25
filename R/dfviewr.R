#' @name dfviewr
#' @title data frame viewer
#' @description Views data.frames with a legend
#' @param df a dataframe 
#' @param col a vector of 5 colors.  The first is for dates, 
#' second for factors, third for characters, fourth for numeric, and fifth for NA.
#' @param axes Axes passed to \code{lasagna}
#' @param main Title passed to \code{lasagna}
#' @param gridlines (logical) default TRUE,  passed to \code{lasagna}
#' @param legend (logical) defaults to TRUE. Creates a legend
#' @param ... Additional argument to be passed to \code{image}
#' @importFrom lubridate is.POSIXct
#' @export
dfviewr <- function(df, col=c("red","blue","green","white","black"), axes=FALSE, 
                       main="", 
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
  
  
  lasagna(mat.out, col=col, cex.axis=0.67, main=main, gridlines=gridlines)
  if(legend){
    legend("bottom", fill = col,
                    legend=c("dates", "factors", 
                             "characters", "numeric", "NA"), 
                    horiz = TRUE, xpd=NA, 
           inset=c(-.15), border="black")
    }
  
}
