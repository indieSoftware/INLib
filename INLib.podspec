Pod::Spec.new do |s|
  s.name             = "INLib"
  s.version          = "4.0.1"
  s.summary          = "A little iOS Library with common tasks."
  s.homepage         = "https://github.com/indieSoftware/INLib"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = "Sven Korset"

  s.platform         = :ios
  s.ios.deployment_target = '6.0'
  s.requires_arc     = true

  s.source           = { :git => "https://github.com/indieSoftware/INLib.git", :tag => "4.0.1" }
  s.source_files     = 'INLib/*.h'
  s.default_subspecs = 'CMethods', 'Macros', 'Classes', 'Categories'
	
  s.subspec 'CMethods' do |cmethods|
    cmethods.source_files = 'INLib/CMethods/**/*.{h,m}'
  end
  s.subspec 'Macros' do |macros|
    macros.source_files = 'INLib/Macros/**/*.{h,m}'
  end
  s.subspec 'Classes' do |classes|
    classes.source_files = 'INLib/Classes/**/*.{h,m}'
    classes.dependency 'INLib/Macros'
  end
  s.subspec 'Categories' do |categories|
    categories.source_files = 'INLib/Categories/**/*.{h,m}'
    categories.dependency 'INLib/Classes'
  end

  s.subspec 'CoreData' do |coredata|
    coredata.source_files = 'INLib/CoreData/**/*.{h,m}'
  	coredata.frameworks = 'CoreData'
  end
  
end
