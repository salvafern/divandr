```R
julia_command("using DIVAnd")
Error: Error happens in Julia.
InitError: could not load library "/home/ctroupin/.julia/artifacts/2829a1f6a9ca59e5b9b53f52fa6519da9c9fd7d3/lib/libhdf5.so"
/usr/lib/x86_64-linux-gnu/libcurl.so.4: version `CURL_4' not found (required by /home/ctroupin/.julia/artifacts/2829a1f6a9ca59e5b9b53f52fa6519da9c9fd7d3/lib/libhdf5.so)
Stacktrace:
  [1] dlopen(s::String, flags::UInt32; throw_error::Bool)
    @ Base.Libc.Libdl ./libdl.jl:117
  [2] dlopen(s::String, flags::UInt32)
    @ Base.Libc.Libdl ./libdl.jl:116
  [3] macro expansion
    @ ~/.julia/packages/JLLWrappers/pG9bm/src/products/library_generators.jl:63 [inlined]
  [4] __init__()
    @ HDF5_jll ~/.julia/packages/HDF5_jll/3C0GU/src/wrappers/x86_64-linux-gnu-libgfortran5-cxx11-mpi+mpich.jl:15
  [5] run_module_init(mod::Module, i::Int64)
    @ Base ./loading.jl:1128
  [6] register_restored_modules(sv::Core.SimpleVector, pkg::Base.PkgId, path::String)
    @ Base ./loading.jl:1116
  [7] _include_from_serialized(pkg::Base.PkgId, path::String, 
> 
```

Error: Error happens in Julia.
InitError: could not load library "/home/ctroupin/.julia/artifacts/87831472e1d79c45830c3d71850680eb745345fb/lib/libnetcdf.so"
libhdf5_hl.so.310: cannot open shared object file: No such file or directory
Stacktrace:


https://alexander-barth.github.io/NCDatasets.jl/latest/issues/

echo $LD_PRELOAD
echo $LD_LIBRARY_PATH
(→ empty)


> install.packages("terra")
Installing package into ‘/home/ctroupin/R/x86_64-pc-linux-gnu-library/4.1’
(as ‘lib’ is unspecified)
trying URL 'https://cloud.r-project.org/src/contrib/terra_1.7-71.tar.gz'
Content type 'application/x-gzip' length 836573 bytes (816 KB)
==================================================
downloaded 816 KB

* installing *source* package ‘terra’ ...
** package ‘terra’ successfully unpacked and MD5 sums checked
** using staged installation
configure: CC: gcc
configure: CXX: g++ -std=gnu++14
checking for gdal-config... no
no
configure: error: gdal-config not found or not executable.
ERROR: configuration failed for package ‘terra’
* removing ‘/home/ctroupin/R/x86_64-pc-linux-gnu-library/4.1/terra’

The downloaded source packages are in
	‘/tmp/Rtmp7j3L7z/downloaded_packages’
Warning message:
In install.packages("terra") :
  installation of package ‘terra’ had non-zero exit status

  

Error in download.file(dataurl, turtlefile) : 
  internet routines cannot be loaded
In addition: Warning message:
In download.file(dataurl, turtlefile) :
  unable to load shared object '/usr/lib/R/modules//internet.so':
  /home/ctroupin/.julia/juliaup/julia-1.10.0+0.x64.linux.gnu/lib/julia/libcurl.so.4.8.0: version `CURL_OPENSSL_4' not found (required by /usr/lib/R/modules//internet.so)



sudo apt-get install libgdal-dev


remotes::install_github("ropensci/rnaturalearthhires")


> julia_install_package("Statistics")
/usr/lib/R/bin/exec/R: symbol lookup error: /home/ctroupin/.julia/juliaup/julia-1.10.0+0.x64.linux.gnu/lib/julia/libcurl.so.4.8.0: undefined symbol: nghttp2_option_set_no_rfc9113_leading_and_trailing_ws_validation