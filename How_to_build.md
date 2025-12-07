# How to build the project
This guide describes the steps required to build the INAV firmware for the Aurix TC375 platform.
It also explains how to switch targets for different microcontrollers and how to include or exclude specific parts of the firmware.

Building the project requires both the Eclipse-based Aurix Development Studio and a few terminal commands.
Since the project depends on generated settings, a script must be executed in the terminal to create these files.
After the settings have been generated, the project must be built before it can be flashed onto the microcontroller.

It is also possible to build a release with pre generated settings and version strings. This procedure is described here [Build .zip release](#build-zip-release)

## Table of contents
- [How to build the project](#how-to-build-the-project)
  - [Table of contents](#table-of-contents)
  - [Setting up the IDE for the build](#setting-up-the-ide-for-the-build)
  - [Generate settings in the GCC output folder](#generate-settings-in-the-gcc-output-folder)
  - [Build and falshing the project](#build-and-falshing-the-project)
  - [Build target selection](#build-target-selection)
  - [Build .zip release](#build-zip-release)
---

## Setting up the IDE for the build
For the build process the IDE **Aurix Development Studio** form Infineon Technologies AG is needed. The current IDE version used for this process is **Version: 1.10.2**. Mind that other version could lead to different software behaviours and so adjust accordingly. The Software can be downloaded on the official site or the following link: 
**https://www.infineon.com/design-resources/platforms/aurix-software-tools/aurix-tools/aurix-development-studio**


<div align="center">
<img src="images\aurix_workspace.png" alt="aurix_workspace" width="600"/>
</div>

After the start of the IDE, select the workspace where the project resides.
The workspace should contain the `aurix_tc375_inav` folder, that was cloned via `git clone --recurse-submodules "https://github.com/jakobgif/aurix_tc375_inav.git"` mentioned in the [README.md](README.md). 

Once the workspace has been set up, the actual project needs to be imported into it.
To do this, go to **File → Import**. In the import window, select **General → Projects from Folder or Archive** and click next. On the next page, select the import directory where the git repository resides. The window should refresh automatically and detect the project. Mark the project for import and you can click finish.

<div align="center">
<img src="images\aurix_import.png" alt="aurix_import" width="600"/>
</div>

<div align="center">
<img src="images\aurix_import2.png" alt="aurix_import" width="600"/>
</div>

After that, the project should appear in the IDE on the left-hand side.
Right-click the project folder and select **Set Active Project**.
This tells the IDE which project should be built, and the project folder should now appear in bold, indicating that it is active.

**Notice**: Once the project is set as active, a compiler toolchain is assigned to it.
**Do not use** the **TASKING** compiler. The project must be built using the TriCore GCC toolchain, which automatically applies the required dialect flag `-std=gnu11`.

To change the compiler, right-click the project folder and navigate to Build Configuration → Set Active, and **use** one of the **TriCore (GCC)** configurations.

This project provides at two build configurations and is defined in [README.md](README.md) :
- **Debug**
- **Release**

To start building the project in the IDE, click the Build icon (the hammer symbol) in the toolbar.
To perform a rebuild, use the button next to it.

Once the build process starts, the IDE will compile the project and create a folder named `TriCore Debug (GCC)` or `TriCore Release (GCC)`, depending on the selected configuration.
The build will not complete successfully at this stage, as some additional settings still need to be generated. These folders are required for creating the generated settings used in the next section.

<div align="center">
<img src="images\aurix_build.png" alt="aurix_build" width="600"/>
</div> 

---

## Generate settings in the GCC output folder
To generate the required setting files, the **project relies on** the software **Ruby** and **Git-Bash** from **Git**.  
The settings script uses Ruby-based tooling to generate the output in the GCC output folder. The Ruby software itself is to be run inside a **Linux-like environment**, therefore on Windows , **WSL** ( Windows Subsystem for Linux) is **required**. To **execute the script** (.sh file) on Windows, we use **Git-Bash**. 

To **install Git** you can either go to the offical website and download and execute the setup sotware

**Git install**: https://git-scm.com/install/windows

or use the following command for the Windows Powershell. **Notice**: you need to install `winget tool` for the command.

```bash
winget install --id Git.Git -e --source winget
```

You can **install WSL** via the Windows Terminal, PowerShell or CMD with the following command:

```bash
wsl --install
```

Afterwords the installation open WSL and run the following commands to install Ruby inside WSL.

```bash
sudo apt update
sudo apt install ruby
```

After Ruby has been installed on to the system, open a terminal and navigate into the `aurix_tc375_inav` porject directory. In that directory execute the following command to execute the settings generation script:

```bash
./generate_settings.bat
```

The generation of the settings **may take a couple of minutes**, depending on the system. Once the script is finished, the ouput `done` should appear in the termnial. While the settings are being generated, the following output should appear:

```bash
creating include paths
running settings.rb
ruby: warning: shebang line ending with \r may cause problems
```

**Notice**: Depending on the IDE version and the installation path of the IDE, the script may require minor modifications to function correctly.
Navigate from the `aurix_tc375_inav` directory to `inav_tc375/src/utils` and open the file `aurix_generate_settings.sh`.
In this file, line 18 should contain the following:

```bash
export CFLAGS="$INCLUDES -I/mnt/c/Infineon/AURIX-Studio-1.10.2/tools/Compilers/tricore-gcc11/tricore-elf/include $DEFS"
```

**Update this path according to your installed IDE version and installation path**. This path directs the script to the Aurix Platform Libraries inside the Tricore GCC toolchain. If this path does not match, the settings generation will fail.

---

## Build and falshing the project
After the settings have been generated in the GCC output folder, the **project needs to be built again** inside the IDE.
This time, the build process should complete successfully, although a few minor warnings may appear.
Once the build has finished, the INAV firmware can be flashed onto the microcontroller.

The **flash button** is the **orange circular symbol** in the IDE toolbar, as shown in the following picture:
<div align="center">
<img src="images\aurix_flash.png" alt="aurix_flash" width="600"/>
</div> 

## Build target selection
Aurix Development Studio allows excluding folders from the build process.
This feature can be used to switch between different build targets within the project, without creating separate project copies.

To modify which parts of the code are excluded from the build, right-click the project folder and select **Properties**.
Then navigate to **C/C++ General → Paths and Symbols** and open the **Source Location** tab.
You should see a list of folder paths already configured for the project.

Edit the filter ending with `main` to view all paths that are currently excluded from the build.
Paths starting with `no-` are **included**, and all **others** are **excluded**.
Adjust these filters according to your needs.

<div align="center">
<img src="images\aurix_target_selection.png" alt="aurix_target_selection" width="800"/>
</div> 

## Build .zip release
Note: It is not recomended to use this approach for development.

To build a firmware release with pre generated settings and version strings follow this procedure:
- Import the project as described in [Setting up the IDE for the build](#setting-up-the-ide-for-the-build)
- copy `settings_generated.c and settings_generated.h` into the build folder.
- copy `version_strings.h` into the build folder.
- comment out line 11 of `pre_build.bat` (`..\inav_tc375\src\utils\aurix_generate_version_strings.sh`)
- comment out line 5 of `post_build.bat` (`del version_strings.h`)
