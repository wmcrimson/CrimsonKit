Pod::Spec.new do |s|
  s.name         	= "CrimsonKit"
  s.version      	= "1.0.0"
  s.platform        = :ios, "7.0"
  s.summary      	= "Log and Color Utilties"
  s.description		= "Basic Classes to provide easy asscess"
  s.homepage     	= "https://github.com/wmalloc/AlertViews-Blocks.git"
  s.license      	= 'BSD'
  s.author       	= { "Waqar Malik" => "wmalloc@gmail.com" }
  s.source       	= { :git => "https://github.com/wmalloc/CrimsonKit.git", :tag => "#{s.version}" }
  s.source_files 	= '*.{h,m,c}'
  s.public_header_files = 'CrimsonKit/*.h'
  s.requires_arc 	= true
end
