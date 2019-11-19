#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'local_notifications'
  s.version          = '0.0.1'
  s.summary          = 'No-op implementation of local_notifications desktop plugin to avoid build issues on iOS'
  s.description      = <<-DESC
temp fake local_notifications plugin
                       DESC
  s.homepage         = 'https://github.com/lesnitsky/flutter_desktop_plugins/tree/master/local_notifications'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Andrei Lesnitsky' => 'andrei.lesnitsky@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'

  s.ios.deployment_target = '8.0'
end
