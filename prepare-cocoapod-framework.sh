./gradlew compileKonanMultiNative

if ! [ -x "$(command -v pod)" ]; then
  echo 'Error: Coacoapods is not installed.' >&2
  exit 1
fi

pod lib lint
