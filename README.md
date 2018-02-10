[![Docker pulls](https://img.shields.io/docker/pulls/dlanguage/dmd.svg)](https://hub.docker.com/r/dlanguage/dmd/)
[![Docker Build](https://img.shields.io/docker/automated/dlanguage/dmd.svg)](https://hub.docker.com/r/dlanguage/dmd/)
[![Latest Tag](https://img.shields.io/github/tag/lindt/docker-dmd.svg)](https://hub.docker.com/r/dlanguage/dmd/)

# docker-dmd

Docker Image for DMD the Digital Mars [D](http://dlang.org) Compiler.

## Motivation

Installation of a compiler sometimes is cumbersome. This Docker image should take this pain and allow you to easily switch between Versions of the same compiler and even different compilers.

In case a native installation is required, `curl -fsS https://dlang.org/install.sh | bash -s dmd` could be used.

## Other Compilers

Allows to use all major D Compilers without installation.

| Compiler | Latest Tag |
| -------- | ---------- |
| DMD      | [![Latest Tag](https://img.shields.io/github/tag/lindt/docker-dmd.svg)](https://hub.docker.com/r/dlanguage/dmd/) |
| LDC      | [![Latest Tag](https://img.shields.io/github/tag/lindt/docker-ldc.svg)](https://hub.docker.com/r/dlanguage/ldc/) |
| GDC      | [![Latest Tag](https://img.shields.io/github/tag/lindt/docker-gdc.svg)](https://hub.docker.com/r/dlanguage/gdc/) |

## Usage

Place a `test.d` in your current directory.
```
import std.stdio;

void main() {
    writeln("Hello, World!");
}
```

Then execute
```
docker run --rm -ti -v $(pwd):/src dlanguage/dmd dmd -run test.d
```

This should plot:
```
Hello, World!
```

If you are too lazy to create a file, you can compile directly from stdin:

```sh
echo 'void main(){import std.stdio; writeln("Hello World");}' | docker run --rm -i -v $(pwd):/src dlanguage/dmd dmd -run -
```
