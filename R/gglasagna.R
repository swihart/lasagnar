#' @name gglasagna
#' @title ggplot() implementation of Lasagna Function
#' @description Ggplot Lasagna plotter
#' @param X a matrix: each row a subject, each column a time/location across subjects; preferably rownames are the ids.
#' @param col colors.  See "Escaping RGB Land" and the vignette for the colorspace package
#' for followable advice on colors.
#' @param axes (logical) TRUE invokes the default axes from image().  FALSE invokes best guess (to be better defined later)
#' @param main as in plot(), the text of the title.  Defaults to "(A)  Initial Lasagna Plot"
#' @param main.adj the value for `adj` in title().  Defaults to 0, which is left-aligned.
#' @param cex.axis the cex.axis value if `axes` is FALSE.
#' @param gridlines (logical ) default TRUE.
#' @param legend (logical) defaults FALSE.
#' @param ... Additional stuff to be passed to \code{image}
#' @import colorspace
#' @import ggplot2
#' @import reshape2
#' @export
gglasagna <- function(X, col=rainbow_hcl(length(unique(c(X)))), axes=FALSE, 
                      main="(A)  Initial Lasagna Plot", main.adj=0, 
                      cex.axis=1.75, 
                      gridlines=TRUE,
                      legend=FALSE, ...){
  
  
  H.df<-melt(X)
  
  ## EDIT to nograpes answer:
  ## reorder the factor that is Subject by setting levels to the reverse order of rownames 
  H.df$Subject <- factor(H.df[,1], 
                         levels = rev(rownames(X))) 
  ## get the times for scale_x_discrete(breaks=brks) call below
  brks <- sort(unique(H.df[,2])) 
  
  # If you want those exact colours the author used:
  colors<-col[match(ordered(H.df$value),levels(ordered(H.df$value)))]
  H.df$colors <- colors
  names(H.df) <- c("Subject","Time", "value", "colors")
  no.legend <- ggplot(H.df, aes_string(x = "Time",
                               y="Subject", 
                               fill="colors")) + 
    geom_tile() + ##scale_fill_identity() +
    ## add title: 
    ggtitle(main)+
    theme(plot.title = element_text(hjust = main.adj))+
    ## adjust size:
    theme(axis.text=element_text(size=30),
          axis.title=element_text(size=14,face="bold"))+
    ## get all the breaks:
    scale_x_discrete(breaks= c(brks)) +
    ## and for some reason need this line to zoom:
    ##coord_cartesian(xlim=c(.49,6.51))
    coord_cartesian(xlim=c(brks[1]-.51,brks[length(brks)]+.51))+
    ylab(names(dimnames(X))[1])+
    xlab(names(dimnames(X))[2])
  
  ## I have geom_tile() twice as a hack.  See bottom of:
  ## http://www.cookbook-r.com/Graphs/Legends_(ggplot2)/
  if(!legend){
    no.legend + 
      geom_tile(colour='black', show_guide=FALSE) + 
      scale_fill_identity() 
  } else{ 
    no.legend + geom_tile(colour='black', show_guide=FALSE) + 
      scale_fill_identity("Value", guide="legend", 
                          labels=rev(sort(unique(c(X)))))
  }
  
}
