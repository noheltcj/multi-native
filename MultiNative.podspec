Pod::Spec.new do |s|
  s.name                    = 'MultiNative'
  s.version                 = '0.0.2'
  s.summary                 = 'A multiplatform ios framework'
  s.homepage                = 'https://github.com/noheltcj/multi-native.git'
  s.author                  = { 'Colton Nohelty' => 'noheltycolton@gmail.com' }
  s.license                 = { :type => 'MIT', :file => 'LICENSE' }
  s.platform                = :ios
  s.requires_arc            = true
  s.module_name             = "MultiNative"
  s.source                  = { :git => 'https://github.com/noheltcj/multi-native.git', :tag => '0.0.2' }
  s.source_files            = 'archive/MultiNative.zip'
  s.ios.deployment_target   = '10.0'
  s.ios.vendored_frameworks = 'MultiNative.framework'
end
