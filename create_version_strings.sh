OUTPUT_FILE="version_strings.h"

FC_VERSION_MAJOR=0
FC_VERSION_MINOR=0
FC_VERSION_PATCH_LEVEL=0

echo "//this file is generated. Changes will be overwritten!" > "$OUTPUT_FILE"
echo "#pragma once" >> "$OUTPUT_FILE"

#now we get versions at but them into file
GIT_HASH=$(git describe --match="" --always --dirty)
GIT_TAG=$(git describe --tags --dirty)
echo "#define GIT_HASH \"${GIT_HASH}\"" >> "$OUTPUT_FILE"
echo "#define GIT_TAG \"${GIT_TAG}\"" >> "$OUTPUT_FILE"

#next commands can take a while with the dirty flag beause it has to index all files
GIT_HASH_INAV=$(git -C ./inav_tc375/ describe --match="" --always --dirty)
GIT_TAG_INAV=$(git -C ./inav_tc375/ describe --tags --dirty)
INAV_VERSION=$(git -C ./inav_tc375/ describe --tags --abbrev=0)
echo "#define GIT_HASH_INAV \"${GIT_HASH_INAV}\"" >> "$OUTPUT_FILE"
echo "#define GIT_TAG_INAV \"${GIT_TAG_INAV}\"" >> "$OUTPUT_FILE"
echo "#define INAV_VERSION \"${INAV_VERSION}\"" >> "$OUTPUT_FILE"

#check if local copy is dirty
if [[ "$GIT_HASH" == *-dirty || "$GIT_HASH_INAV" == *-dirty ]]; then
    echo "#define GIT_IS_DIRTY" >> "$OUTPUT_FILE"
fi

#split inav version from git into strings
IFS='.' read -r FC_VERSION_MAJOR FC_VERSION_MINOR FC_VERSION_PATCH_LEVEL <<< "$INAV_VERSION"
echo "#define FC_VERSION_MAJOR ${FC_VERSION_MAJOR}" >> "$OUTPUT_FILE"
echo "#define FC_VERSION_MINOR ${FC_VERSION_MINOR}" >> "$OUTPUT_FILE"
echo "#define FC_VERSION_PATCH_LEVEL ${FC_VERSION_PATCH_LEVEL}" >> "$OUTPUT_FILE"