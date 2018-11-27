
Pod::Spec.new do |s|

  s.name         = "AZCategory"
  s.version      = "0.0.2"
  s.summary      = "常用Category"
  s.homepage     = "https://github.com/AlfredZY/AZCategory"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Alfred Zhang" => "AlfredZhang@foxmail.com" }
  
  s.platform     = :ios, "7.0"
  
  s.source       = { :git => "https://github.com/AlfredZY/AZCategory.git", :tag => s.version }

  s.requires_arc = true

  s.subspec 'PushAndPop' do |ss|
    ss.source_files = 'AZCategory/AZCategory/PushAndPop/*.{h,m}'
  end

  s.subspec 'Gradient' do |ss|
    ss.source_files = 'AZCategory/AZCategory/Gradient/*.{h,m}'
  end

  s.subspec 'SafeArea' do |ss|
    ss.source_files = 'AZCategory/AZCategory/SafeArea/*.{h,m}'
  end

end


