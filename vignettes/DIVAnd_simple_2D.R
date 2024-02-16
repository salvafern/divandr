# Simplest DIVAnd interpolation with a 1D vector
# The input are created as R variables, then converted to Julia variables
# with the command julia_assign("aa", aa), with aa taking the name of the different variables

library(JuliaCall)
julia_setup(JULIA_HOME = path.expand("~/.juliaup/bin/"))
julia_command("using DIVAnd")
library(logger)
library(ggplot2)

# Create directories
figdir <- "./figures/"
dir.create(figdir)

# Create 2D data
fun <- function(x, y) {
  zz = sin(6 * x) * cos(6 * y)
  return(zz)
}

x <- runif(75)
y <- runif(75)
f = fun(x, y)

# Set the interpolation grid
NX <- 100
NY <- 110
xx <- seq(0, 1, length.out=NX)
yy <- seq(0, 1, length.out=NY)
julia_assign("xx", xx)
julia_assign("yy", yy)
julia_command("xi, yi = ndgrid(xx, yy)");
xi = julia_eval("xi")
yi = julia_eval("yi")

# True field (normally unknown)
fref <- fun(xi, yi)

# Mask: all points are valid points
mask <- matrix(TRUE, NX, NY)

# Metrics: pm is the inverse of the resolution along the 1st dimension
pm <- matrix(1, NX, NY) / (xi[2,1]-xi[1,1])
pn <- matrix(1, NX, NY) / (xi[2,1]-xi[1,1])

# Analysis parameters
# Correlation length
len <- 0.1

# Obs. error variance normalized by the background error variance
epsilon2 <- 1.0

# From R variable to Julia variable
# (maybe possible to do it differently)
julia_assign("pm", pm)
julia_assign("pn", pn)
julia_assign("xi", xi)
julia_assign("yi", yi)
julia_assign("x", x)
julia_assign("y", y)
julia_assign("f", f)
julia_assign("len", len)
julia_assign("mask", mask)
julia_assign("epsilon2", epsilon2)

# DIVAnd execution
julia_command("fi, s = DIVAndrun(mask, (pm, pn) ,(xi, yi), (x, y), f, len, epsilon2; alphabc=2);") 

# From Julia variable to R variable
fi = julia_eval("fi")

# Make the plots using plot.matrix
# Doesn't look very nice
# library('plot.matrix')
# plot(fi, border=NA, col=viridis)

# # Convert results to dataframe??
# d1 <- expand.grid(x = xx, y = yy) 
# out <- transform(d1, z = fi[as.matrix(d1)])
# out[order(out$x), ]

library(oce)
library(ocedata)
plot(coastlineWorld, col = NA,
     projection = "+proj=eck3",
     longitudelim=range(xx), 
     latitudelim=range(yy))
pal = oce.colorsTemperature()
zlim = range(fi, na.rm = TRUE)
c = colormap(fi, breaks=100, zclip = T, col = pal, zlim = zlim)
mapImage(xx, yy, fi, col=oceColorsTemperature)
