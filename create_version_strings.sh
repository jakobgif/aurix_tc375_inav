echo "//this file is generated. Changes will be overwritten!" > version_strings.h
echo "#pragma once" >> version_strings.h

#now we get versions at but them into file
echo "#define GIT_HASH \"$(git describe --match="" --always --dirty)\"" >> version_strings.h
echo "#define GIT_TAG \"$(git describe --tags --dirty)\"" >> version_strings.h