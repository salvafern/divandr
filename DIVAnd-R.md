
## Installation of R language

```bash
sudo apt install r-base
```

### Installation of Julia in r

```R
install.packages("JuliaCall")
julia_setup(JULIA_HOME = "/home/ctroupin/.juliaup/bin/")
julia_install_package_if_needed("DIVAnd")
julia_install_package_if_needed("NCDatasets") 
julia_install_package_if_needed("PyPlot")
```


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