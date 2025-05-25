Pod::Spec.new do |s|
  s.name             = 'WiseTrackLib'
  s.version          = '1.0.3'
  s.summary          = 'WiseTrack tracking SDK for iOS'
  s.description      = 'WiseTrack provides advanced user tracking features for iOS apps.'
  s.homepage         = 'https://wisetrack.io'
  s.license          = { :type => 'Commercial', :text => 'Copyright (c) 2024 WiseTrack. All rights reserved.' }
  s.author           = { 'Mostafa Movahhed' => 'thisismovahhed@gmail.com' }
  s.source           = { :http => 'https://github.com/wisetrack-io/ios-sdk/releases/download/1.0.3/WiseTrackLib.xcframework.zip'}
  s.frameworks       = 'Foundation', 'UIKit'
  s.ios.deployment_target = '11.0'
  s.swift_versions   = ["5.0"]
  s.vendored_frameworks = 'WiseTrackLib.xcframework'
  s.dependency 'Sentry', '~> 8.49.0'
end