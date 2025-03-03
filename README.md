| Supported Targets | TC375 Litekit |
| ----------------- | ----- |

# aurix_tc375_inav
This code implements [inav](https://github.com/iNavFlight/inav.git) for the [Aurix TC375 Litekit](). 

## Table of contents
- [aurix\_tc375\_inav](#aurix_tc375_inav)
  - [Table of contents](#table-of-contents)
  - [Scripts](#scripts)

## Scripts
[pre_build.bat](pre_build.bat) must be run before building the code. The aurix project is configured to do that.

[create_version_strings.sh](create_version_strings.sh) generates a header file containing the version information. This includes current git hash and tag.

[make_doc.bat](make_doc.bat) generates the doxygen documentation. 