
# ----------------------------------------------------------------
# $Author: thm $
# $Date: 2014-11-21 10:49:55 +0100 (Fri, 21 Nov 2014) $
# $Rev: 321 $
# ----------------------------------------------------------------

## these is an image function providing a legend, as the image function from
## R's base package has no legend, and the image.plot function from the fields
## packages (though being nice) should be avoided, as loading the fileds
## package should be avoided, as that package has no namespace, thus leading
## to conflicts. And we don't want that, do we?

plotit <- function(model.name,
                   sub.name,
                   single.sub.data.clip,
                   data.list,
                   save.as.data) {
  ## Plots an image of the data obtained from the NetCDF file being clipped
  ## according to the current subregion. This is for diagnostic purpose only.
  ##
  ## Args:
  ##   x.list: Data list (of seasons) containg areal data-matrices from NetCDF
  ##           file (obtained from AggregateSecondStatistic)
  ##
  ## Returns:
  ##   Imageplot.

  ## store image as png in "/tmp/"
  png(paste(save.as.data, "_", model.name, "_", sub.name, ".png", sep = "" ))

  ## only plot first season
  x.list <- data.list[[1]]

  ## plot points according to the subregion - the circle size
  ## represents the weighting factor
  plot(single.sub.data.clip$lon[!is.na(x.list)],
       single.sub.data.clip$lat[!is.na(x.list)],
       ## xlim = c(range(single.sub.data.clip$lon[!is.na(x.list)])[1] - 1,
       ##   range(single.sub.data.clip$lon[!is.na(x.list)])[2] + 1),
       ## ylim = c(range(single.sub.data.clip$lat[!is.na(x.list)])[1] - 1,
       ##   range(single.sub.data.clip$lat[!is.na(x.list)])[2] + 1),
       ylim=c(10,75),
       xlim=c(-40,60),
       cex = single.sub.data.clip$weight[which(!is.na(x.list))],
       col = "red", pch = 20, xlab = "lon", ylab = "lat")

  ## plot grid and borders
  grid()
  ## data("wrld_simpl_lessIslands")
  ## plot(wrld_simpl_lessIslands,add=T)

  ## close device
  dev.off()
}


