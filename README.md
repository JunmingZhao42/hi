# Basic usage

### Compiling binaries

```sh
make all [BUILD_DIR=<build dir> CAKE=<cakeml compiler path>]
```

### Benchmarking binaries

There are specific Make targets for benchmarking. T

hese will put the benchmarking data files in your build directory.

They will test three programs for a given architecture:
* the C fibo
* the Pancake fibo
* the Pancake fibo with FFI

The binaries will also be objdumped into the build directory, the file
path will look like `assembly-<binary>.txt`.

For x64:
```sh
make bench_x64
```
For arm64:
```sh
make bench_arm64
```

