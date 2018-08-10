set -e

rm -rf build

./gradlew build

if ! [ -x "$(command -v lipo)" ]; then
  echo 'Error: lipo is not installed.' >&2
  exit 1
fi

mkdir -p build/ios/release/MultiNative.framework

lipo -create \
  -output build/ios/release/MultiNative.framework/MultiNative \
  multi-native-ios/build/konan/bin/ios_arm64/MultiNative.framework/MultiNative \
  multi-native-ios/build/konan/bin/ios_x64/MultiNative.framework/MultiNative \

cp -R multi-native-ios/build/konan/bin/ios_arm64/MultiNative.framework/Headers build/ios/release/MultiNative.framework
cp -R multi-native-ios/build/konan/bin/ios_arm64/MultiNative.framework/Modules build/ios/release/MultiNative.framework
cp multi-native-ios/build/konan/bin/ios_arm64/MultiNative.framework/Info.plist build/ios/release/MultiNative.framework

zip -r build/MultiNative.zip LICENSE build/ios/release

if ! [ -x "$(command -v pod)" ]; then
  echo 'Error: Coacoapods is not installed.' >&2
  exit 1
fi

pod lib lint --verbose
pod spec lint --verbose
