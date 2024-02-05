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
