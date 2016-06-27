#
# Be sure to run `pod lib lint QCPullRefresh.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'QCPullRefresh'
  s.version          = '0.1.0'
  s.summary          = 'QCPullRefresh is imitation BanTanAnimation Pull Refresh.'
  s.description      = <<-DESC
TODO: 这是一款模仿半糖下拉刷新的刷新控件, 仅供学习和参考. 其中主要参考了MJRefresh以及一些其他的刷新动画效果，旨在提高刷新效率.
                       DESC

  s.homepage         = 'https://github.com/QC-L/QCPullRefresh'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'QC-L' => 'liqichang_4869@163.com' }
  s.source           = { :git => 'https://github.com/QC-L/QCPullRefresh.git', :tag => s.version.to_s }
  s.ios.deployment_target = '7.0'
  s.source_files = 'QCPullRefresh/*.{h,m}'
  s.requires_arc = true
  s.frameworks = 'UIKit', 'CoreText', 'QuartzCore'
end
