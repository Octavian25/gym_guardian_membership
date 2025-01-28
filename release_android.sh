#!/bin/sh

# Fungsi untuk menaikkan versi
increase_version() {
  local type=$1
  local version=$(grep 'version:' pubspec.yaml | cut -d ' ' -f 2)
  local major=$(echo $version | cut -d '.' -f 1)
  local minor=$(echo $version | cut -d '.' -f 2)
  local patch=$(echo $version | cut -d '.' -f 3 | cut -d '+' -f 1)
  local build=$(echo $version | cut -d '+' -f 2)

  case $type in
    patch)
      patch=$((patch+1))
      build=$((build+1))
      ;;
    minor)
      minor=$((minor+1))
      build=$((build+1))
      ;;
    major)
      major=$((major+1))
      build=$((build+1))
      ;;
    *)
      echo "Unknown type"
      exit 1
      ;;
  esac

  if sed --version 2>&1 | grep -q GNU; then
    sed -i "s/version: .*/version: $major.$minor.$patch+$build/" pubspec.yaml
  else
    sed -i "" -e "s/version: .*/version: $major.$minor.$patch+$build/" pubspec.yaml
  fi
}

# Fungsi untuk memperbarui file lib/utility/constant.dart
update_app_version() {
  local version=$1
  local file="lib/utility/constant.dart"
  if [ -f "$file" ]; then
    if sed --version 2>&1 | grep -q GNU; then
      sed -i "s/String appVersion = .*/String appVersion = \"$version\";/" $file
    else
      sed -i "" -e "s/String appVersion = .*/String appVersion = \"$version\";/" $file
    fi
    echo "Updated constant appVersion: $version"
  else
    echo "// File ini di-generate otomatis" > $file
    echo "const String appVersion = \"$version\";" >> $file
  fi
}

VERSION=$(grep 'version:' pubspec.yaml | cut -d ' ' -f 2 | cut -d '+' -f 1)
echo "Current project version: $(grep 'version:' pubspec.yaml | cut -d ' ' -f 2)"
echo "Which version would you like to increase?"
echo "1) Patch"
echo "2) Minor"
echo "3) Major"
echo "4) No change"

read -p "Enter your choice (1/2/3/4): " version_choice

case $version_choice in
  1)
    increase_version patch
    ;;
  2)
    increase_version minor
    ;;
  3)
    increase_version major
    ;;
  4)
    echo "No version change selected."
    ;;
  *)
    echo "Invalid choice"
    exit 1
    ;;
esac

NEW_VERSION=$(grep 'version:' pubspec.yaml | cut -d ' ' -f 2 | cut -d '+' -f 1)
update_app_version $NEW_VERSION

echo "Updated project version: $(grep 'version:' pubspec.yaml | cut -d ' ' -f 2)"

# shorebird release android --artifact=apk
# Bangun APK
flutter build apk --split-per-abi
if [ $? -ne 0 ]; then
  echo "Error: Flutter build failed!"
  exit 1
fi

# Ganti nama file APK
OUTPUT_DIR="build/app/outputs/flutter-apk"
DEST_DIR="/Users/nagatech/drive_file/loyalityMembership"

cd $OUTPUT_DIR || exit
for file in app-*-release.apk; do
  abi=$(echo $file | sed -e 's/app-\(.*\)-release.apk/\1/')
  new_name="$abi.apk"
  mv "$file" "$new_name"
  
  # Pindahkan file ke direktori tujuan
  mv "$new_name" "$DEST_DIR"
  echo "Moved $new_name to $DEST_DIR"
done

flutter build apk
mv app-release.apk loyalityMembership.apk
mv loyalityMembership.apk /Users/nagatech/drive_file/
echo "All APK files have been renamed and moved successfully!"


# Tampilkan pertanyaan sebelum memanggil curl
read -p "Apakah Anda ingin update Splitted APK di server? (y/n): " answer
if [ "$answer" != "${answer#[Yy]}" ]; then
  curl --location --request POST 'https://103.150.191.156:1980/run-download-folder?scriptPath=LoyalityMembership%2Fdownload.sh' --header 'x-secret-key: mroctopus2025'
else
  echo "Update APK di server dibatalkan."
fi

read -p "Apakah Anda ingin update Master APK di server? (y/n): " answer
if [ "$answer" != "${answer#[Yy]}" ]; then
  curl --location --request POST 'https://103.150.191.156:1980/run-download-folder?scriptPath=download-loyalityMembership.sh' --header 'x-secret-key: mroctopus2025'
else
  echo "Update APK di server dibatalkan."
fi
