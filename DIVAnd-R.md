
## Installation of R language

__Documentation:__ https://cran.r-project.org/web/packages/JuliaCall/readme/README.html

```bash
sudo apt install r-base
```

### Installation of Julia in R

```R
install.packages("JuliaCall")
```

### Configure Julia

You may want to specify the path to the Julia executable:
```R
library(JuliaCall)
julia_setup(JULIA_HOME = "/home/ctroupin/.juliaup/bin/")
```
If sucessful, this command will issue
```R
Juliaup configuration is locked by another process, waiting for it to unlock.
Julia version 1.9.1 at location /home/ctroupin/.julia/juliaup/julia-1.9.1+0.x64.linux.gnu/bin will be used.
Loading setup script for JuliaCall...
Finish loading setup script for JuliaCall.
```

### Install Julia packages

__Documentation:__ https://search.r-project.org/CRAN/refmans/JuliaCall/html/julia_package.html

```R
julia_install_package_if_needed("Statistics")
julia_install_package_if_needed("DIVAnd")
julia_install_package_if_needed("NCDatasets") 
julia_install_package_if_needed("PyPlot")
```

### Loading Julia packages



Error
> julia_command("using DIVAnd")
[ Info: Precompiling DIVAnd [efc8151c-67de-5a8f-9a35-d8f54746ae9d]
ERROR: LoadError: InitError: could not load library
"/home/ctroupin/.julia/artifacts/461703969206dd426cc6b4d99f69f6ffab2a9779/lib/libnetcdf.so"
/usr/lib/x86_64-linux-gnu/libcurl.so: version `CURL_4' not found
(required by
/home/ctroupin/.julia/artifacts/461703969206dd426cc6b4d99f69f6ffab2a9779/lib/libnetcdf.so)
Stacktrace:
[cut]
Solution: maybe this:
https://discourse.julialang.org/t/problems-with-starting-circuitscape-from-r-package-juliacall/93965/2