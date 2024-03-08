   > This is a placeholder page. 
>   Please check back later - or better yet, write up what you were looking for here and contribute it! This way the next person looking for this feature won't have to..

# Introduction
Ubuntu 20.04 is the officially supported platform for p4c. There's also
unofficial support for macOS 11. Other platforms are untested; you can try to
use them, but YMMV.

- A C++17 compiler. GCC 9.1 or later or Clang 6.0 or later is required.

- `git` for version control

- CMake 3.16.3 or higher

- Boehm-Weiser garbage-collector C++ library

- GNU Bison and Flex for the parser and lexical analyzer generators.

- Google Protocol Buffers v3.25.3 or higher for control plane API generation

- C++ boost library

- Python 3 for scripting and running tests

- Optional: Documentation generation (enabled when configuring with
  --enable-doxygen-doc) requires Doxygen (1.8.10 or higher) and Graphviz
  (2.38.0 or higher).

Backends may have additional dependencies. The dependencies for the backends
included with `p4c` are documented here:
  * [BMv2](backends/bmv2/README.md)
  * [eBPF](backends/ebpf/README.md)
  * [graphs](backends/graphs/README.md)

## Ubuntu dependencies

Most dependencies can be installed using `apt-get install`:

```{code-block} Bash
:caption: Bash Shell

sudo apt-get install cmake g++ git automake libtool libgc-dev bison flex \

libfl-dev libboost-dev libboost-iostreams-dev \

libboost-graph-dev llvm pkg-config python3 python3-pip \

tcpdump

pip3 install --user -r requirements.txt
```

For documentation building:
`sudo apt-get install -y doxygen graphviz texlive-full`

`p4c` also depends on Google Protocol Buffers (Protobuf). `p4c` requires version
3.0 or higher, so the packaged version provided in Ubuntu 20.04 **should**
work. However, P4C typically installs its own version of Protobuf using CMake's `FetchContent` module
(at the moment, 3.25.3). If you are experiencing issues with the Protobuf version shipped with your OS distribution, we recommend that to install Protobuf 3.25.3 from source. You can find instructions
[here](https://github.com/protocolbuffers/protobuf/blob/v3.25.3/src/README.md).
After cloning Protobuf and before you build, check-out version 3.25.3:

`git checkout v3.25.3`

Please note that while all Protobuf versions newer than 3.0 should work for
`p4c` itself, you may run into trouble with some extensions and other p4lang
projects unless you install version 3.25.3.

`p4c` also depends on Google Abseil library. This library is also a pre-requisite for Protobuf of any version newer than 3.21. Therefore the use of Protobuf of suitable version automatically fulfils Abseil dependency. P4C typically installs its own version of Abseil using CMake's `FetchContent` module (Abseil LTS 20240116.1 at the moment).

### CMake
p4c requires a CMake version of at least 3.16.3 or higher. On older systems, a newer version of CMake can be installed using `pip3 install --user cmake==3.16.3`. We have a CI test on Ubuntu 18.04 that uses this option, but there is no guarantee that this will lead to a successful build.

## Fedora dependencies

```{code-block} bash
:caption: Bash Shell
sudo dnf install -y cmake g++ git automake libtool gc-devel bison flex \

libfl-devel gmp-devel boost-devel boost-iostreams boost-graph llvm pkg-config \

python3 python3-pip tcpdump

sudo pip3 install -r requirements.txt
```

For documentation building:

```bash
sudo dnf install -y doxygen graphviz texlive-scheme-full
```

You can also look at the [dependencies installation script](tools/install_fedora_deps.sh)
for a fresh Fedora instance.

## macOS dependencies

Installing on macOS:

- Enable XCode's command-line tools:
  ```
  xcode-select --install
  ```

- Install Homebrew:
  ```
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  ```
  Be sure to add `/usr/local/bin/` to your `$PATH`.

- Install dependencies using Homebrew:
  ```
  brew install autoconf automake libtool bdw-gc boost bison pkg-config
  ```
  or with MacPorts
  ```
  sudo port install autoconf automake coreutils libtool boehmgc boost bison pkg-config
  ```

  By default, Homebrew doesn't link programs into `/usr/local/bin` if
  they would conflict with a version provided by the base system. This
  includes Bison, since an older version ships with macOS. `make
  check` depends on the newer Bison we just installed from Homebrew
  (see [#83](http://github.com/p4lang/p4c/issues/83)), so you'll want
  to add it to your `$PATH` one way or another. One simple way to do
  that is to request that Homebrew link it into `/usr/local/bin`:
  ```
  brew link --force bison
  ```

  Optional documentation building tools:
  ```
  brew install doxygen graphviz
  ```
  Homebrew offers a `protobuf` formula. It installs version 3.2, which should
  work for p4c itself but may cause problems with some extensions. It's
  preferable to use the version of Protobuf which is supplied with CMake's fetchcontent (3.25.3).

  The `protobuf` formula requires the following CMake variables to be set,
  otherwise CMake does not find the libraries or fails in linking. It is likely
  that manually installed Protobuf will require similar treatment.

```{code-block} Bash
:caption: Terminal

  PB_PREFIX="$(brew --prefix --installed protobuf)"
  ./bootstrap.sh \

    -DProtobuf_INCLUDE_DIR="${PB_PREFIX}/include/" \

    -DProtobuf_LIBRARY="${PB_PREFIX}/lib/libprotobuf.dylib" \

    -DENABLE_PROTOBUF_STATIC=OFF
  ```

## Garbage collector

P4c relies on [BDW garbage collector](https://github.com/ivmai/bdwgc)
to manage its memory.  By default, the p4c executables are linked with
the garbage collector library.  When the GC causes problems, this can
be disabled by setting `ENABLE_GC` cmake option to `OFF`.  However,
this will dramatically increase the memory usage by the compiler, and
may become impractical for compiling large programs.  **Do not disable
the GC**, unless you really have to.  We have noticed that this may be
a problem on MacOS.

## Crash dumps

P4c will use [libbacktrace](https://github.com/ianlancetaylor/libbacktrace.git)
to produce readable crash dumps if it is available.  This is an optional
dependency; if it is not available everything should build just fine, but
crash dumps will not be very readable.
