./gradlew build

if ! [ -x "$(command -v xcodebuild)" ]; then
  echo 'Error: xcodebuild is not installed.' >&2
  exit 1
fi

xcodebuild \
  -project multi-native-ios/MultiNativei386Stub/MultiNativei386Stub.xcodeproj \
  -scheme MultiNativei386Stub \
  -configuration Release \
  -sdk iphoneos CONFIGURATION_BUILD_DIR=./build clean build

if ! [ -x "$(command -v lipo)" ]; then
  echo 'Error: lipo is not installed.' >&2
  exit 1
fi

lipo -create \
  -arch arm64 multi-native-ios/build/konan/bin/ios_arm64/MultiNative.framework/MultiNative \
  -arch x86_64 multi-native-ios/build/konan/bin/ios_x64/MultiNative.framework/MultiNative \
  -arch_blank i386 \
  -output build/ios/release/MultiNative.framework/MultiNative

zip -r archive/MultiNative.zip LICENSE build/ios/release

if ! [ -x "$(command -v pod)" ]; then
  echo 'Error: Coacoapods is not installed.' >&2
  exit 1
fi

pod lib lint --verbose
pod spec lint --verbose
