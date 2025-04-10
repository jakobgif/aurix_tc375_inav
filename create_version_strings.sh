echo "//this file is generated. Changes will be overwritten!" > ../version_strings.h
echo "#pragma once" >> ../version_strings.h

#now we get versions at but them into file
echo "#define GIT_HASH \"$(git describe --match="" --always --dirty)\"" >> ../version_strings.h
echo "#define GIT_TAG \"$(git describe --tags --dirty)\"" >> ../version_strings.h

#next commands can take a while with the dirty flag beause it has to index all files
echo "#define GIT_HASH_INAV \"$(git -C ../inav_tc375/ describe --match="" --always)\"" >> ../version_strings.h
echo "#define GIT_TAG_INAV \"$(git -C ../inav_tc375/ describe --tags)\"" >> ../version_strings.h