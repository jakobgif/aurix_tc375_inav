| Supported Targets | TC375 Litekit |
| ----------------- | ----- |

# aurix_tc375_inav
This code implements a ported version of [inav](https://github.com/jakobgif/inav_tc375.git) for the [Aurix TC375 Litekit](https://www.infineon.com/cms/de/product/evaluation-boards/kit_a2g_tc375_lite/). 

Run `git clone --recurse-submodules "https://github.com/jakobgif/aurix_tc375_inav.git"` to clone the repo including the submodules.

## Notes
Target MICOAIR743 uses same IMU and Baro as we do.

### TODO
- change optimization level to same as inav
- disable all features that require low level access
- add custom stuff to CLI

## Table of contents
- [aurix\_tc375\_inav](#aurix_tc375_inav)
  - [Notes](#notes)
    - [TODO](#todo)
  - [Table of contents](#table-of-contents)
  - [Building](#building)
    - [Build options](#build-options)
      - [Release build](#release-build)
      - [Debug build](#debug-build)
  - [Submodules](#submodules)
  - [VSCode](#vscode)
  - [Scripts](#scripts)
  
## Building
Building is done in Aurix development studio. 

### Build options
Do **not** use the Tasking compiler.

#### Release build
- Use TriCore Release (GCC) configuration
- BUILD_CONFIG_RELEASE is defined via -D flag
- Release uses optimisation level "Optimize most (-O3)"

#### Debug build
- Use TriCore Debug (GCC) configuration
- BUILD_CONFIG_DEBUG is defined via -D flag
- Debug uses optimisation level "Optimize for debug (-Og)"

## Submodules
This project uses a ported version of the inav flight control software as a submodule.

The submodules are also listed in [.gitmodules](.gitmodules).

## VSCode 
If vscode is used the following `c_cpp_properties.json` can be used to configure the workspace.

```JSON
{
    "configurations": [
        {
            "name": "Aurix",
            "includePath": [
                "${workspaceFolder}/*",
                "${workspaceFolder}/Libraries/**", //aurix lib
                //inav lib all
                //"${workspaceFolder}/inav_tc375/src/main/**",
                //inav lib with specific target
                "${workspaceFolder}/inav_tc375/src/main/*",
                "${workspaceFolder}/inav_tc375/src/main/blackbox/**",
                "${workspaceFolder}/inav_tc375/src/main/build/**",
                "${workspaceFolder}/inav_tc375/src/main/cms/**",
                "${workspaceFolder}/inav_tc375/src/main/common/**",
                "${workspaceFolder}/inav_tc375/src/main/config/**",
                "${workspaceFolder}/inav_tc375/src/main/drivers/**",
                "${workspaceFolder}/inav_tc375/src/main/fc/**",
                "${workspaceFolder}/inav_tc375/src/main/flight/**",
                "${workspaceFolder}/inav_tc375/src/main/io/**",
                "${workspaceFolder}/inav_tc375/src/main/msc/**",
                "${workspaceFolder}/inav_tc375/src/main/msp/**",
                "${workspaceFolder}/inav_tc375/src/main/navigation/**",
                "${workspaceFolder}/inav_tc375/src/main/programming/**",
                "${workspaceFolder}/inav_tc375/src/main/rx/**",
                "${workspaceFolder}/inav_tc375/src/main/scheduler/**",
                "${workspaceFolder}/inav_tc375/src/main/sensors/**",
                "${workspaceFolder}/inav_tc375/src/main/startup/**",
                "${workspaceFolder}/inav_tc375/src/main/target/FHTW_TC375_LK/**", //only our target required
                "${workspaceFolder}/inav_tc375/src/main/telemetry/**"
            ],
            "defines": [
                "FROM_AURIX_STUDIO"
            ],
            "cStandard": "gnu99",
            //"cppStandard": "gnu++17",
            "intelliSenseMode": "gcc-x64"
        }
    ],
    "version": 4
}
```

## Scripts
[pre_build.bat](pre_build.bat) must be run before building the code. The aurix project is configured to do that.

[create_version_strings.sh](create_version_strings.sh) generates a header file containing the version information. This includes current git hash and tag.

[make_doc.bat](make_doc.bat) generates the doxygen documentation. 