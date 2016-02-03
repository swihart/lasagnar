#' @name lasagna
#' @title Lasagna Function
#' @description Generic Lasagna Function
#' @param X a matrix: each row a subject, each column a time/location across subjects; preferably rownames are the ids.
#' @param col colors.  See "Escaping RGB Land" and the vignette for the colorspace package
#' for followable advice on colors.
#' @param axes (logical) TRUE invokes the default axes from image().  
#' FALSE invokes best guess, and better control using \code{xaxis/yaxis}.
#' @param xaxis Use best guess x-axis if \code{image.axis = FALSE}
#' @param yaxis Use best guess y-axis if \code{image.axis = FALSE}
#' @param main as in plot(), the text of the title.  Defaults to "(A)  Initial Lasagna Plot"
#' @param main.adj the value for `adj` in title().  Defaults to 0, which is left-aligned.
#' @param xlab Label for x-axis
#' @param ylab Label for y-axis
#' @param cex.axis the cex.axis value if `axes` is FALSE.
#' @param gridlines (logical) Add gridlines to the plot.  Useful if image is not
#' too big.
#' @param legend (logical) defaults to FALSE.  TRUE invokes image.plot() from fields package instead of image() and thus displays a legend.
#' @param ... Additional stuff to be passed to \code{image}
#' @importFrom fields image.plot
#' @export 
lasagna <- function(X, col=rainbow_hcl(length(unique(c(X)))), 
                   image.axes = FALSE, 
                   xaxis = TRUE,
                   yaxis = TRUE,
                   main="(A)  Initial Lasagna Plot", main.adj=0, 
                   xlab = NULL,
                   ylab = NULL,
                   cex.axis=1.75, 
                   gridlines=FALSE,
                   legend=FALSE, ...){
  if (!legend) {
    ## THE crucial piece:  everything else is just window dressing
    image(t(X)[,(nrow(X):1)], col=col, axes=image.axes, 
          useRaster = TRUE, ...  )
  } else{
    image.plot(t(X)[,(nrow(X):1)], col=col, axes=image.axes, 
               useRaster = TRUE, ...  )
  }
  ## box border
  box()
  title(main, adj = main.adj, xlab = xlab, ylab = ylab)
  if(!image.axes){
    if (xaxis){
      axis(side = 1, at = seq(0,1,1/(ncol(X)-1)), 
           labels = 1:ncol(X), 
           cex.axis=cex.axis, 
           tck = 0, mgp=c(0,.50,0))
    }
    if (yaxis){
      axis(side = 2, at = seq(0,1,1/(nrow(X)-1)), 
           labels = rev(rownames(X)), 
           las=1,
           cex.axis=cex.axis, 
           tck=0, mgp=c(0,.2,0))
    }
  }
  if(gridlines){
    ## next two axis() calls add grid-lines:
    axis(1,
         seq( 1/(ncol(X)-1)*0.5, 1 - 1/(ncol(X)-1)*0.5, 
              length=(ncol(X)-1)),##c(1/10,3/10,5/10,7/10,9/10),
         labels=NA,
         tck=1,
         lty=1,
         col="black") 
    axis(2,
         seq( 1/(nrow(X)-1)*0.5, 1 - 1/(nrow(X)-1)*0.5, 
              length=(nrow(X)-1)),##c(1/6,3/6,5/6),
         labels = NA,
         tck=1,
         lty=1,
         col="black") 
  }
}
