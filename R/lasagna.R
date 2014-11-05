#' @name lasagna
#' @title Lasagna Function
#' @param X a matrix: each row a subject, each column a time/location across subjects
#' @param col colors
#' @param axes (logical) axes on or off?
#' @param ... Additional stuff to be passed to \code{image}
lasagna<- function(X, col=rev(sequential_hcl(100, h=120, c = 80, power = 2.2)[1:100]), 
                   axes=FALSE, ...){
  image(t(X)[,(nrow(X):1)], col=col, axes=axes, ...  )
  box()
}