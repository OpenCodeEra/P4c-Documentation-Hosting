## Installing p4c from source
1.  Clone the repository. It includes submodules, so be sure to use
    `--recursive` to pull them in:
    ```
    git clone --recursive https://github.com/p4lang/p4c.git
    ```
    If you forgot `--recursive`, you can update the submodules at any time using:
    ```
    git submodule update --init --recursive
    ```

2.  Install [dependencies](#dependencies). You can find specific instructions
    for Ubuntu 20.04 [here](#ubuntu-dependencies) and for macOS 11
    [here](#macos-dependencies).  You can also look at the
    [CI installation script](tools/ci-build.sh).

3.  Build. Building should also take place in a subdirectory named `build`.
    ```
    mkdir build
    cd build
    cmake .. <optional arguments>
    make -j4
    make -j4 check
    ```
    The cmake command takes the following optional arguments to
    further customize the build:
     - `-DCMAKE_BUILD_TYPE=RELEASE|DEBUG` -- set CMAKE_BUILD_TYPE to
      RELEASE or DEBUG to build with optimizations or with debug
      symbols to run in gdb. Default is RELEASE.
     - `-DCMAKE_INSTALL_PREFIX=<path>` -- set the directory where
       `make install` installs the compiler. Defaults to /usr/local.
     - `-DENABLE_BMV2=ON|OFF`. Enable [the bmv2
       backend](backends/bmv2/README.md). Default ON.
     - `-DENABLE_EBPF=ON|OFF`. Enable [the ebpf
       backend](backends/ebpf/README.md). Default ON.
     - `-DENABLE_UBPF=ON|OFF`. Enable [the ubpf
       backend](backends/ubpf/README.md). Default ON.
     - `-DENABLE_DPDK=ON|OFF`. Enable [the DPDK
       backend](backends/dpdk/README.md). Default ON.
     - `-DENABLE_P4C_GRAPHS=ON|OFF`. Enable [the p4c-graphs
       backend](backends/graphs/README.md). Default ON.
     - `-DENABLE_P4TEST=ON|OFF`. Enable [the p4test
       backend](backends/p4test/README.md). Default ON.
     - `-DENABLE_TEST_TOOLS=ON|OFF`. Enable [the p4tools
         backend](backends/p4tools/README.md). Default OFF.
     - `-DENABLE_DOCS=ON|OFF`. Build documentation. Default is OFF.
     - `-DENABLE_GC=ON|OFF`. Enable the use of the garbage collection
       library. Default is ON.
     - `-DENABLE_GTESTS=ON|OFF`. Enable building and running GTest unit tests.
       Default is ON.
     - `-DP4C_USE_PREINSTALLED_ABSEIL=ON|OFF`. Try to find a system version of Abseil instead of a fetched one. Default is OFF.
     - `-DP4C_USE_PREINSTALLED_PROTOBUF=ON|OFF`. Try to find a system version of Protobuf instead of a CMake version. Default is OFF.
     - `-DENABLE_ABSEIL_STATIC=ON|OFF`. Enable the use of static abseil libraries. Default is ON. Only has an effect when `P4C_USE_PREINSTALLED_ABSEIL` is enabled.
     - `-DENABLE_PROTOBUF_STATIC=ON|OFF`. Enable the use of static protobuf libraries. Default is ON.
       Only has an effect when `P4C_USE_PREINSTALLED_PROTOBUF` is enabled.
     - `-DENABLE_MULTITHREAD=ON|OFF`. Use multithreading.  Default is
       OFF.
     - `-DBUILD_LINK_WITH_GOLD=ON|OFF`. Use Gold linker for build if available.
     - `-DBUILD_LINK_WITH_LLD=ON|OFF`. Use LLD linker for build if available (overrides `BUILD_LINK_WITH_GOLD`).
     - `-DENABLE_LTO=ON|OFF`. Use Link Time Optimization (LTO).  Default is OFF.
     - `-DENABLE_WERROR=ON|OFF`. Treat warnings as errors.  Default is OFF.
     - `-DCMAKE_UNITY_BUILD=ON|OFF `. Enable [unity builds](https://cmake.org/cmake/help/latest/prop_tgt/UNITY_BUILD.html) for faster compilation.  Default is OFF.

    If adding new targets to this build system, please see
    [instructions](#defining-new-cmake-targets).

4.  (Optional) Install the compiler and the P4 shared headers globally.
    ```
    sudo make install
    ```
    The compiler driver `p4c` and binaries for each of the backends are
    installed in `/usr/local/bin` by default; the P4 headers are placed in
    `/usr/local/share/p4c`.

5.  You're ready to go! You should be able to compile a P4-16 program for BMV2
    using:
    ```
    p4c -b bmv2-ss-p4org program.p4 -o program.bmv2.json
    ```
