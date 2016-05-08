Pod::Spec.new do |s|
  s.name             = "PolarKit"
  s.version          = "0.1.0"
  s.summary          = "Polar coordinate system for iOS"

  s.homepage         = "https://github.com/alldne/PolarKit"
  s.license          = 'MIT'
  s.author           = { "Jeong Yong-uk" => "ywj1022@gmail.com" }
  s.source           = { :git => "https://github.com/alldne/PolarKit.git", :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'PolarKit/Classes/**/*'
end
