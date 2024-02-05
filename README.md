# EMODnet-Biology-PhaseV

Code and notes for the EMODnet Biology project Phase V, in which our goals will be:
1. To make `DIVAnd` interpolation method available in `R`
2. Create gridded maps (heatmaps) of a specific species (birds? mammals?) 
3. Compare the results obtained with `DIVAnd` with other methods available in `R`. 

## Installation and configuration 

The instructions are given for a machine running under Ubuntu (22.04.3 LTS -- Jammy).

### Installation of R language

__Documentation:__ https://cran.r-project.org/web/packages/JuliaCall/readme/README.html

```bash
sudo apt install r-base
```

### Installation of Julia

We suggest to use the `juliaup` tool (https://github.com/JuliaLang/juliaup), which makes easier the installation, upgrade and management of different versions of Julia.

### Installation of Julia in R

In a R session:
```R
install.packages("JuliaCall")
```

You are asked if you want to use a personal library (say "yes"):
```R
Warning in install.packages("JuliaCall") :
  'lib = "/usr/local/lib/R/site-library"' is not writable
Would you like to use a personal library instead? (yes/No/cancel) 
```

### Installation of netCDF 

R relies on the utility `nc-config` to it has to be installed:
```bash
sudo apt-get install libnetcdf-dev
```
then the library can be installed:
```R
install.packages("ncdf4")
```

## Configure Julia

You may want to specify the path to the Julia executable:
```R
library(JuliaCall)
julia_setup(JULIA_HOME = "/home/ctroupin/.juliaup/bin/")
```
If successful, this command will give:
```R
Julia version 1.9.3 at location /home/ctroupin/.julia/juliaup/julia-1.9.3+0.x64.linux.gnu/bin will be used.
Loading setup script for JuliaCall...

```

## Install Julia packages

__Documentation:__ https://search.r-project.org/CRAN/refmans/JuliaCall/html/julia_package.html

```R
julia_install_package_if_needed("Statistics")
julia_install_package_if_needed("PyPlot")
julia_install_package_if_needed("DIVAnd")
julia_install_package_if_needed("NCDatasets")
```

## Loading Julia packages

Before running the `julia_command(" ")`, 
ensure that the Julia packages are already installed (with the Julia version specified in the variable `JULIA_HOME`).

```R
julia_command("using Statistics")
julia_command("using PyPlot")
```

__Note:__ also possible to start a Julia session within `R`:
```R
system("julia")
```

### NCDatasets

I might be necessary to issue this command before starting the `R` session, in order to ensure the correct `libcurl` is used:
```bash
export LD_PRELOAD=/home/ctroupin/.local/share/R/JuliaCall/julia/1.9.1/julia-1.9.1/lib/julia/libcurl.so.4.8.0
```
(with the obvious adaptations in the path and in the library number).

```R
julia_command("using NCDatasets")
julia_command("using DIVAnd")
```
