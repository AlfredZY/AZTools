
Pod::Spec.new do |s|

  s.name         = "AZCategory"
  s.version      = "0.0.3"
  s.summary      = "常用Category"
  s.homepage     = "https://github.com/AlfredZY/AZCategory"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Alfred Zhang" => "AlfredZhang@foxmail.com" }
  
  s.platform     = :ios, "7.0"
  
  s.source       = { :git => "https://github.com/AlfredZY/AZCategory.git", :tag => s.version }

  s.requires_arc = true

  s.source_files = 'AZCategory/Source/**/*.{h,m}'

end


