Pod::Spec.new do |s|
  s.name             = 'Rudder-Adjust'
  s.version          = '0.1.0'
  s.summary          = 'A short description of Rudder-Adjust.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/arnab/Rudder-Adjust'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'arnab' => 'arnab@rudderlabs.com' }
  s.source           = { :git => 'https://github.com/arnab/Rudder-Adjust.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Rudder-Adjust/Classes/**/*'

  s.dependency 'RudderSDKCore', '~> 0.1.3'
  s.dependency 'Adjust', '~> 4.17.2'
end
