Pod::Spec.new do |s|
  s.name                    = 'MultiNative'
  s.version                 = '0.0.1'
  s.summary                 = 'A multiplatform native framework'
  s.homepage                = 'https://github.com/noheltcj/multi-native.git'
  s.author                  = { 'Colton Nohelty' => 'noheltycolton@gmail.com' }
  s.license                 = { :type => 'MIT', :file => 'LICENSE' }
  s.platform                = :ios
  s.source                  = { :git => 'git@github.com/noheltcj/multi-native.git', :tag => '0.0.1' }
  s.ios.deployment_target   = '9.0'
  s.ios.vendored_frameworks = 'build/ios/release/MultiNative.framework'
end
