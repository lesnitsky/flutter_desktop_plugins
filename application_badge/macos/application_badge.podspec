#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'application_badge'
  s.version          = '0.0.1'
  s.summary          = 'Flutter plugin to show application badge'
  s.description      = <<-DESC
  Temporary desktop implmentations of connectivity from flutter/plugins
                       DESC
  s.homepage         = 'https://github.com/lesnitsky/fde_plugins/application_badge'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Andrei Lesnitksy' => 'andrei.lesnitsky@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'

  s.platform = :osx
  s.osx.deployment_target = '10.11'
end
