#' @name lasagna
#' @title Lasagna Function
#' @param X a matrix: each row a subject, each column a time/location across subjects
#' @param col colors.  See "Escaping RGB Land" and the vignette for the colorspace package
#' for followable advice on colors.
#' @param axes (logical) axes on or off?
#' @param ... Additional stuff to be passed to \code{image}
lasagna<- function(X, col=rainbow_hcl(100), axes=FALSE, ...){
  image(t(X)[,(nrow(X):1)], col=col, axes=axes, ...  )
  box()
}