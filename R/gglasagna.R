#' @name gglasagna
#' @title ggplot() implementation of Lasagna Function
#' @param X a matrix: each row a subject, each column a time/location across subjects; preferably rownames are the ids.
#' @param col colors.  See "Escaping RGB Land" and the vignette for the colorspace package
#' for followable advice on colors.
#' @param axes (logical) TRUE invokes the default axes from image().  FALSE invokes best guess (to be better defined later)
#' @param main as in plot(), the text of the title.  Defaults to "(A)  Initial Lasagna Plot"
#' @param main.adj the value for `adj` in title().  Defaults to 0, which is left-aligned.
#' @param cex.axis the cex.axis value if `axes` is FALSE.
#' @param gridlines (logical) default TRUE.
#' @param ... Additional stuff to be passed to \code{image}
gglasagna<- function(X, col=rainbow_hcl(length(unique(c(X)))), axes=FALSE, 
                   main="(A)  Initial Lasagna Plot", main.adj=0, 
                   cex.axis=1.75, 
                   gridlines=TRUE,...){

  
  H.df<-melt(X)
  
  ## EDIT to nograpes answer:
  ## reorder the factor that is Subject by setting levels to the reverse order of rownames 
  H.df$Subject <- factor(H.df[,1], levels = rev(rownames(X))) 
  ## get the times for scale_x_discrete(breaks=brks) call below
  brks <- sort(unique(H.df[,2])) 
  
  # If you want those exact colours the author used:
  colors<-col[match(ordered(H.df$value),levels(ordered(H.df$value)))]
  ggplot(H.df,aes(x=Time,y=Subject,fill=colors)) + 
    geom_tile(colour='black') + scale_fill_identity() +
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
    coord_cartesian(xlim=c(brks[1]-.51,brks[length(brks)]+.51))
  
  
  
  
  
  
  
  
  
  
#   
#   
#   
#   
#   
#   
#   ## THE crucial piece:  everything else is just window dressing
#   image(t(X)[,(nrow(X):1)], col=col, axes=axes, ...  )
#   ## box border
#   box()
#   title(main, adj=main.adj)
#   if(!axes){
#   axis(1, seq(0,1,1/(ncol(X)-1)), 1:ncol(X), cex.axis=cex.axis, tck=0, mgp=c(0,.50,0))
#   axis(2, seq(0,1,1/(nrow(X)-1)), rev(rownames(X)),las=1,
#        cex.axis=cex.axis, tck=0, mgp=c(0,.2,0))
#   }
#   if(gridlines){
#   ## next two axis() calls add grid-lines:
#   axis(1,
#        seq( 1/(ncol(X)-1)*0.5, 1 - 1/(ncol(X)-1)*0.5, length=(ncol(X)-1)),##c(1/10,3/10,5/10,7/10,9/10),
#        lab=NA,
#        tck=1,
#        lty=1,
#        col="black") 
#   axis(2,
#        seq( 1/(nrow(X)-1)*0.5, 1 - 1/(nrow(X)-1)*0.5, length=(nrow(X)-1)),##c(1/6,3/6,5/6),
#        lab=NA,
#        tck=1,
#        lty=1,
#        col="black") 
#   }
}