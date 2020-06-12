
Pod::Spec.new do |s|

  s.name         = "AZTools"
  s.version      = "0.0.4"
  s.summary      = "常用Category和工具类"
  s.homepage     = "https://github.com/AlfredZY/AZTools"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "AlfredZY" => "AlfredZhang@foxmail.com" }

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/AlfredZY/AZTools.git", :tag => s.version }

  s.requires_arc = true

  s.source_files = 'AZTools/**/*.{h,m}'

end
