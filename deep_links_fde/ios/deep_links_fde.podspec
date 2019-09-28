#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'deep_links_fde'
  s.version          = '0.0.1'
  s.summary          = 'No-op implementation of deep_links_fde desktop plugin to avoid build issues on iOS'
  s.description      = <<-DESC
temp fake deep_links_fde plugin
                       DESC
  s.homepage         = 'https://github.com/lesnitsky/flutter_desktop_plugins/tree/master/deep_links_fde'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Andrei Lesnitsky' => 'andrei.lesnitsky@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'

  s.ios.deployment_target = '8.0'
end
