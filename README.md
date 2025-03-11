| Supported Targets | TC375 Litekit |
| ----------------- | ----- |

# aurix_tc375_inav
This code implements a ported version of [inav](https://github.com/jakobgif/inav_tc375.git) for the [Aurix TC375 Litekit](). 

## Table of contents
- [aurix\_tc375\_inav](#aurix_tc375_inav)
  - [Table of contents](#table-of-contents)
  - [Building](#building)
    - [Build options](#build-options)
      - [Release build](#release-build)
      - [Debug build](#debug-build)
  - [Submodules](#submodules)
  - [Scripts](#scripts)
  
## Building
Building is done in Aurix development studio. 

### Build options
Do not use the Tasking compiler.

#### Release build
- Use TriCore Release (GCC) configuration
- BUILD_CONFIG_RELEASE is defined via -D command
- Release uses optimiation level "Optimize most (-O3)"

#### Debug build
- Use TriCore Debug (GCC) configuration
- BUILD_CONFIG_DEBUG is defined via -D command
- Debug uses optimiation level "Optimize for debug (-Og)"

## Submodules
This project uses two submodules:
1. ported inav flight control software
2. fault injection unit for tc375

The submodules are also listed in [.gitmodules](.gitmodules).

## Scripts
[pre_build.bat](pre_build.bat) must be run before building the code. The aurix project is configured to do that.

[create_version_strings.sh](create_version_strings.sh) generates a header file containing the version information. This includes current git hash and tag.

[make_doc.bat](make_doc.bat) generates the doxygen documentation. 