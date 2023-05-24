#
# Be sure to run `pod lib lint ChartsSwiftUI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name                    = 'ChartsSwiftUI'
  s.version                 = '0.1.4'
  s.summary                 = 'Charts built in SwiftUI'
  s.platform                = :ios
  s.ios.deployment_target   = '13.0'
  s.swift_version           = '5.1'
  s.description             = 'Charts built in SwiftUI'
  s.homepage                = 'https://github.com/intuit/ChartsSwiftUI'
  s.license                 = { :type => 'Proprietary' }
  s.author                  = { 'Intuit' => '' }
  s.source                  = { :git => 'https://github.com/intuit/ChartsSwiftUI.git', :tag => s.version.to_s }
  
  s.source_files            = ['Sources/ChartsSwiftUI/Classes/**/*']
  
  # s.resources               = [ 'ChartsSwiftUI/Assets/**/*.xcassets',
  #                               'ChartsSwiftUI/Assets/**/*.json' ]

end

