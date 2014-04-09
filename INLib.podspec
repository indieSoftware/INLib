Pod::Spec.new do |s|
  s.name             = "INLib"
  s.version          = "0.1.0"
  s.summary          = "A little iOS Library with common tasks."
  s.homepage         = "https://github.com/indieSoftware/INLib"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = "Sven Korset"

  s.platform         = :ios
  s.ios.deployment_target = '6.0'
  s.requires_arc     = true

  s.source           = { :git => "https://github.com/indieSoftware/INLib.git", :tag => "0.1.0" }
  s.source_files     = 'INLib/*.h'

  s.subspec 'Categories' do |categories|
    categories.source_files = 'INLib/Categories/**/*.{h,m}'
  end
  
end
