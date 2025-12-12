# create a packed release that can be directly imported into aurix development studio

# navigate to directory of this script
cd "$(dirname "$0")"

mkdir temp
cd temp

echo cloning aurix repo
# get the latest aurix project release from github
API_URL="https://api.github.com/repos/jakobgif/aurix_tc375_inav/releases/latest"
RELEASE_JSON=$(curl -s "$API_URL")

# extract tag name
AURIX_TAG_NAME=$(echo "$RELEASE_JSON" | grep -m 1 '"tag_name":' | cut -d '"' -f 4)
echo "Release tag: $AURIX_TAG_NAME"

# extract asset urls
ASSET_URLS=$(echo "$RELEASE_JSON" | grep "browser_download_url" | cut -d '"' -f 4)

# build url to download zip
SOURCE_ZIP="https://github.com/jakobgif/aurix_tc375_inav/archive/refs/tags/$AURIX_TAG_NAME.zip"

echo "Found assets:"
echo "$ASSET_URLS"
echo "$SOURCE_ZIP"

DOWNLOAD_URLS="$ASSET_URLS $SOURCE_ZIP"

for URL in $DOWNLOAD_URLS; do
    echo "Downloading $URL ..."
    curl -L -O -J "$URL"
done

#unpack the aurix repo
ZIP_FILE=$(ls *.zip)
echo "unzipping $ZIP_FILE"
unzip -q "$ZIP_FILE"

mv "${ZIP_FILE%.zip}" "aurix_tc375_inav"
cd aurix_tc375_inav

mkdir "TriCore Debug (GCC)"
mkdir "TriCore Release (GCC)"

echo

echo copy generated files to build folder
cp "../settings_generated.c" "TriCore Debug (GCC)" -v
cp "../settings_generated.h" "TriCore Debug (GCC)" -v
cp "../version_strings.h" "TriCore Debug (GCC)" -v

cp "../settings_generated.c" "TriCore Release (GCC)" -v
cp "../settings_generated.h" "TriCore Release (GCC)" -v
cp "../version_strings.h" "TriCore Release (GCC)" -v

echo delete pre build and post build script
rm "pre_build.bat" -v
rm "post_build.bat" -v

echo

echo cloning inav repo

# get the latest aurix project release from github
API_URL="https://api.github.com/repos/jakobgif/inav_tc375/releases/latest"
RELEASE_JSON=$(curl -s "$API_URL")

# extract tag name
INAV_TAG_NAME=$(echo "$RELEASE_JSON" | grep -m 1 '"tag_name":' | cut -d '"' -f 4)
echo "Release tag: $INAV_TAG_NAME"

# build url to download zip
SOURCE_ZIP="https://github.com/jakobgif/inav_tc375/archive/refs/tags/$INAV_TAG_NAME.zip"

echo "Found assets:"
echo "$SOURCE_ZIP"

echo "Downloading $SOURCE_ZIP ..."
curl -L -O -J "$SOURCE_ZIP"

rm -rf inav_tc375

#unpack the inav repo
ZIP_FILE=$(ls *.zip)
echo "unzipping $ZIP_FILE"
unzip -q "$ZIP_FILE"
rm -rf "$ZIP_FILE"

mv "${ZIP_FILE%.zip}" "inav_tc375"

echo pack aurix project
zip -r "../aurix_tc375_inav_${AURIX_TAG_NAME}_${INAV_TAG_NAME%-aurix}.zip" .
mv -v "../aurix_tc375_inav_${AURIX_TAG_NAME}_${INAV_TAG_NAME%-aurix}.zip" "../../aurix_tc375_inav_${AURIX_TAG_NAME}_${INAV_TAG_NAME%-aurix}.zip"

#clean temp folder
rm -rf ../../temp

echo done

read -p "Press enter to continue"