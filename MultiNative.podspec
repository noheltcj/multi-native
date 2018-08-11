Pod::Spec.new do |s|
  s.name                    = 'MultiNative'
  s.version                 = '0.0.3'
  s.summary                 = 'A multiplatform ios framework'
  s.homepage                = 'https://github.com/noheltcj/multi-native.git'
  s.author                  = { 'Colton Nohelty' => 'noheltycolton@gmail.com' }
  s.license                 = { :type => 'MIT', :file => 'LICENSE' }
  s.platform                = :ios
  s.requires_arc            = true
  s.module_name             = "MN"
  s.source                  = { :http => 'https://s3.us-east-2.amazonaws.com/multi-native-archive/MultiNative.zip' }
  s.source_files            = 'build/ios/release/MultiNative.framework/Headers/*.h'
  s.resource                = 'build/ios/release/MultiNative.framework/Info.plist'
  s.public_header_files     = 'build/ios/release/MultiNative.framework/Headers/*.h'
  s.ios.deployment_target   = '9.0'
  s.ios.vendored_frameworks = 'build/ios/release/MultiNative.framework'
end
