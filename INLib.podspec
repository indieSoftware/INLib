Pod::Spec.new do |s|
  s.name             = "INLib"
  s.version          = "0.1.0"
  s.summary          = "A little Objective-C Library used by indie-Software."
  s.homepage         = "https://github.com/indieSoftware/INLib"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Sven Korset" => "Sven.Korset@indie-Software.de" }
  s.source           = { :git => "https://github.com/indieSoftware/INLib.git", :tag => "0.1.0" }

  s.platform         = :ios
  s.ios.deployment_target = '6.0'
  s.requires_arc = true

  s.source_files = 'INLib/**/*.{h,m}'
  s.header_mappings_dir = 'INLib'
  s.public_header_files = 'INLib/**/*.h'

end
