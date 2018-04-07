
Pod::Spec.new do |s|
  s.name         = "GCTNavigation"
  s.version      = "0.0.1"
  s.summary      = "Navigation 相关功能实现"
  s.description  = <<-DESC
  Navigation 相关功能实现：
  GCTNavigationBar：快速方便使用的自定义 navigationBar 
  测滑返回扩展。
                   DESC

  s.homepage     = "https://github.com/GCTec/GCTNavigation"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "Later" => "lshxin89@126.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/GCTec/GCTNavigation.git", :tag => s.version }
  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
  s.frameworks = 'UIKit', 'Foundation'
  s.requires_arc = true

  s.public_header_files = 'GCTNavigation/Classes/*.h'
  s.source_files = 'GCTNavigation/Classes/*.{h,m}'
end
