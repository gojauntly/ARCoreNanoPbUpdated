Pod::Spec.new do |s|
  s.name             = 'ARCoreNanoPbUpdated'
  s.version          = '1.45.0'
  s.summary          = 'Custom ARCore SDK with updated nanopb dependency.'
  s.description      = ' A custom version of the ARCore SDK for iOS that includes an updated nanopb dependency to resolve compatibility issues with Firebase.'
  s.homepage         = 'https://developers.google.com/ar/'
  s.license          = { :type => 'Apache License, Version 2.0', :file => 'LICENSE' }
  s.authors          = { 'Google, Inc.' => 'google-ar-sdk@google.com' }
  s.source           = { :git => 'https://github.com/trvon/arcore-ios-sdk.git', :branch => 'main' }
  s.platform         = :ios, '12.0'
  s.swift_version    = '5.0'

  s.preserve_paths   = ['CHANGELOG', 'README.md', 'LICENSE', 'Package.swift']
  s.cocoapods_version = '>= 1.12.0'

  s.default_subspecs = ['Base']
  s.pod_target_xcconfig = {
    'ENABLE_BITCODE' => 'NO',
    'EXCLUDED_ARCHS[sdk=iphoneos*]' => 'armv7',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386'
  }
  s.user_target_xcconfig = s.pod_target_xcconfig

  s.subspec 'Base' do |base|
    base.source_files = ['Base/Sources/dummy.h', 'Base/Sources/ARCore/ARCore.h']
    base.vendored_frameworks = 'Base/Frameworks/ARCoreBase.xcframework'
    base.frameworks = ['CoreTelephony', 'Foundation', 'SystemConfiguration', 'Security', 'UIKit']
    base.libraries = ['c++', 'z']
    base.preserve_paths = ['Base/dummy.m', 'Base/Sources/ARCore/module.modulemap']
    base.dependency 'nanopb', '~> 3.30910.0'
    base.dependency 'GoogleDataTransport', '~> 9.2'
  end

  s.subspec 'CloudAnchors' do |cloud|
    cloud.source_files = 'CloudAnchors/Sources/dummy.h'
    cloud.vendored_frameworks = 'CloudAnchors/Frameworks/ARCoreCloudAnchors.xcframework'
    cloud.frameworks = ['ARKit', 'CoreFoundation', 'CoreGraphics', 'CoreImage', 'CoreMotion', 'CoreVideo', 'Foundation', 'ImageIO', 'Security', 'SystemConfiguration', 'UIKit']
    cloud.libraries = ['c++', 'z', 'sqlite3', 'm']
    cloud.preserve_paths = 'CloudAnchors/dummy.m'
    cloud.dependency 'ARCoreNanoPbUpdated/Base', '~> 1.45'
    cloud.dependency 'GTMSessionFetcher/Core', '>= 1.5', '< 4.0'
    cloud.dependency 'nanopb', '~> 3.30910.0'
  end

  s.subspec 'GARSession' do |gar|
    gar.source_files = 'GARSession/Sources/dummy.h'
    gar.vendored_frameworks = 'GARSession/Frameworks/ARCoreGARSession.xcframework'
    gar.frameworks = ['ARKit', 'CoreFoundation', 'CoreGraphics', 'CoreImage', 'CoreMotion', 'CoreTelephony', 'CoreVideo', 'Foundation', 'ImageIO', 'Security', 'SystemConfiguration', 'UIKit']
    gar.libraries = ['c++', 'z', 'sqlite3']
    gar.preserve_paths = 'GARSession/dummy.m'
    gar.resource_bundles = {
      'ARCoreResources' => 'GARSession/Resources/ARCoreResources/**'
    }
    gar.dependency 'ARCoreNanoPbUpdated/Base', '~> 1.45'
    gar.dependency 'Firebase/RemoteConfig', '>= 8.0', '< 11.0'
    gar.dependency 'nanopb', '~> 3.30910.0'
  end
end
