#   🐢 Turtles sightings 🐢
#   ≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡
# 
#   This notebooks illustrates the computation of a heatmap using observation
#   locations.
# 
#   Dataset: Marine Turtles National Biodiversity Network Trust. Marine Turtles.
#   National Biodiversity Network Trust, Newark, UK.
#   https://doi.org/10.15468/fyt9hw,
#   https://portal.obis.org/dataset/1cfc4d23-9fcd-42b2-95bf-9c4ee9bc50f6

#   ––––––––––––––––––––––––––––––––––––––––––––––––––

julia_command("using DIVAnd")
julia_command("using PyPlot")
julia_command("using Statistics")
julia_command("using DelimitedFiles")
julia_command("using LinearAlgebra")
julia_command("using Random")


# Read the data retrieved from OBIS
datadir = "../data"
if (!dir.exists(datadir)){
  dir.create(datadir)
}else{
  print("data directory exists")
}

turtlefile <- "../data/turtles.dat"
dataurl <- "hhttps://dox.ulg.ac.be/index.php/s/IsWWlNxWeQDuarJ/download"


if (!file.exists(turtlefile)){
    download.file(dataurl, turtlefile)
}else{
    print("Data file already downloaded")
}


AA=readdlm(turtlefile)
@show size(AA);

lon=AA[:,1]
lat=AA[:,2]
mean(lon), mean(lat)

scatter(lon,lat,s=1)
xlabel("Longitude")
ylabel("Latitude")
title("Location of observations")

#   A simple heatmap without land mask
#   ====================================

julia_assign("NX", 300)
julia_assign("NY", 250)
# Box size
julia_assign("LX", 18.)
julia_assign("LY", 15.)
# Bounding box
julia_assign("xleft", -14.)
julia_assign("ybot", 47.)
julia_assign("xright", xleft+LX)
julia_assign("ytop", ybot+LY)

xo=lon
yo=lat

# Eliminate points out of the box
sel=(xo.>xleft) .& (xo.<xright) .& (yo.>ybot) .& (yo.<ytop)

xo=xo[sel]
yo=yo[sel]
inflation=ones(size(xo))
scatter(xo,yo,s=1)
xlabel("Longitude")
ylabel("Latitude")
title("Location of observations in grid box")

#   Heatmap
#   –––––––––

dx=LX/(NX)
dy=LY/(NY)

xg = xleft+dx/2:dx:xleft+LX
yg = ybot+dy/2:dy:ybot+LY
# for pyplot
xp=xleft:dx:xleft+LX
yp = ybot:dy:ybot+LY
maskp,(pmp,pnp),(xip,yip) = DIVAnd.DIVAnd_rectdom(xp,yp)

mask,(pm,pn),(xi,yi) = DIVAnd.DIVAnd_rectdom(xg,yg)


# adding a mask
#mask[(xi.+0.25)./0.95 .+ (yi.-2.4)./1.1 .<1 ].=false
#mask[2*xi.+yi .<3.4 ].=false

@show size(xi)
# From here generic approach 
@time dens1,LHM,LCV,LSCV = DIVAnd.DIVAnd_heatmap(mask,(pm,pn),(xi,yi),(xo,yo),inflation,0;Ladaptiveiterations=1)

figure()
pcolor(xip,yip,dens1),colorbar()
scatter(xo,yo,s=1,c="white")
xlabel("Longitude")
ylabel("Latitude")
title("Density and observations")
@show LCV,LSCV,mean(LHM[1]),mean(LHM[2])

figure()
pcolor(xip,yip,log.(dens1)),colorbar()
xlabel("Longitude")
ylabel("Latitude")
title("Density (log)")

#   Now prepare land mask
#   =======================

bathname = "../data/gebco_30sec_4.nc"

if !isfile(bathname)
    download("https://b2drop.eudat.eu/s/ACcxUEZZi6a4ziR/download",bathname)
else
    @info("Bathymetry file already downloaded")
end

bx,by,b = load_bath(bathname,true,xg,yg)

pcolor(bx,by,b'); colorbar(orientation="horizontal")
xlabel("Longitude")
ylabel("Latitude")
title("Depth")

@show size(b)

for j = 1:size(b,2)
    for i = 1:size(b,1)
        mask[i,j] = b[i,j] >= 0
    end
end
pcolor(bx,by,Float64.(mask)')
xlabel("Longitude")
ylabel("Latitude")
title("Mask")

#   First heatmap with uniform and automatic bandwidth
#   ––––––––––––––––––––––––––––––––––––––––––––––––––––

@time dens1,LHM,LCV,LSCV= DIVAnd_heatmap(mask,(pm,pn),(xi,yi),(xo,yo),inflation,0;Ladaptiveiterations=0)

figure()
pcolor(xip,yip,log.(dens1)),colorbar()
xlabel("Longitude")
ylabel("Latitude")
#scatter(xo,yo,s=1,c="white")
title("Density (log)")
@show LCV,LSCV,mean(LHM[1]),mean(LHM[2])

#   Now with adapted bandwidth
#   ============================

@time dens1,LHM,LCV,LSCV= DIVAnd_heatmap(mask,(pm,pn),(xi,yi),(xo,yo),inflation,0;Ladaptiveiterations=1)

figure()
pcolor(xip,yip,log.(dens1)),colorbar()
xlabel("Longitude")
ylabel("Latitude")
#scatter(xo,yo,s=1,c="white")
title("Density (log)")


@show LCV,LSCV,mean(LHM[1]),mean(LHM[2])

#   But how much iterations ? Cross validation indicators can help
#   ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

dens1,LHM,LCV,LSCV= DIVAnd_heatmap(mask,(pm,pn),(xi,yi),(xo,yo),inflation,0;Ladaptiveiterations=0)
figure()
pcolor(xip,yip,log.(dens1)),colorbar()
xlabel("Longitude")
ylabel("Latitude")
title("$(mean(LHM[1])),$LCV,$LSCV")

dens1,LHM,LCV,LSCV= DIVAnd_heatmap(mask,(pm,pn),(xi,yi),(xo,yo),inflation,0;Ladaptiveiterations=1)
figure()
pcolor(xip,yip,log.(dens1)),colorbar()
xlabel("Longitude")
ylabel("Latitude")
title("$(mean(LHM[1])),$LCV,$LSCV")

dens1,LHM,LCV,LSCV= DIVAnd_heatmap(mask,(pm,pn),(xi,yi),(xo,yo),inflation,0;Ladaptiveiterations=2)
figure()
pcolor(xip,yip,log.(dens1)),colorbar()
xlabel("Longitude")
ylabel("Latitude")
title("$(mean(LHM[1])),$LCV,$LSCV")

dens1,LHM,LCV,LSCV= DIVAnd_heatmap(mask,(pm,pn),(xi,yi),(xo,yo),inflation,0;Ladaptiveiterations=3)
figure()
pcolor(xip,yip,log.(dens1)),colorbar()
xlabel("Longitude")
ylabel("Latitude")
title("$(mean(LHM[1])),$LCV,$LSCV")

dens1,LHM,LCV,LSCV= DIVAnd_heatmap(mask,(pm,pn),(xi,yi),(xo,yo),inflation,0;Ladaptiveiterations=4)
figure()
pcolor(xip,yip,log.(dens1)),colorbar()
xlabel("Longitude")
ylabel("Latitude")
title("$(mean(LHM[1])),$LCV,$LSCV")

dens1,LHM,LCV,LSCV= DIVAnd_heatmap(mask,(pm,pn),(xi,yi),(xo,yo),inflation,0;Ladaptiveiterations=5)
figure()
pcolor(xip,yip,log.(dens1)),colorbar()
xlabel("Longitude")
ylabel("Latitude")
title("$(mean(LHM[1])),$LCV,$LSCV")

#   4 iterations yield highest likelyhood and lowest rms
#   ======================================================

dens1,LHM,LCV,LSCV= DIVAnd_heatmap(mask,(pm,pn),(xi,yi),(xo,yo),inflation,0;Ladaptiveiterations=4)
figure()
pcolor(xip,yip,log.(dens1)),colorbar()
xlabel("Longitude")
ylabel("Latitude")
title("$(mean(LHM[1])),$LCV,$LSCV")

pcolor(xip,yip,log.(LHM[1].*LHM[2])),colorbar()
xlabel("Longitude")
ylabel("Latitude")
title("Surface of bandwidth (log)")

#   Important note
#   ≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡
# 
#   There is no information used on the effort of looking for turtles. Obviously
#   more are seen close to coastlines because of easier spotting.