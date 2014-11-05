# lasagnar:  Lasagna plots R package
Bruce Swihart  
November 5, 2014  

The original paper:  [Lasagna Plots: A Saucy Alternative to Spaghetti Plots](http://journals.lww.com/epidem/Fulltext/2010/09000/Lasagna_Plots__A_Saucy_Alternative_to_Spaghetti.15.aspx)



```r
library(devtools)                                                                                                                                
install_github("swihart/lasagnar")                                                               
library(lasagnar)                                                                                                  
library(colorspace)                                                                                                                              
                                                                                                                                                 
lasagna(matrix(1:100, nrow=10, ncol=10, byrow=TRUE)[sample(1:10),])                                                                              
```

![plot of chunk unnamed-chunk-1](./readMe_files/figure-html/unnamed-chunk-1.png) 
