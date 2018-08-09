./gradlew build

if ! [ -x "$(command -v lipo)" ]; then
  echo 'Error: lipo is not installed.' >&2
  exit 1
fi

lipo -create -arch_blank i386 \
  -arch arm64 multi-native-ios/build/konan/bin/ios_arm64/MultiNative.framework/MultiNative \
  -arch x86_64 multi-native-ios/build/konan/bin/ios_x64/MultiNative.framework/MultiNative \
  -output build/ios/release/MultiNative.framework/MultiNative

cp -R multi-native-ios/build/konan/bin/ios_arm64/MultiNative.framework/Headers build/ios/release/MultiNative.framework/
cp -R multi-native-ios/build/konan/bin/ios_arm64/MultiNative.framework/Modules build/ios/release/MultiNative.framework/

zip -r archive/MultiNative.zip LICENSE build/ios/release

if ! [ -x "$(command -v pod)" ]; then
  echo 'Error: Coacoapods is not installed.' >&2
  exit 1
fi

pod lib lint
pod spec lint
