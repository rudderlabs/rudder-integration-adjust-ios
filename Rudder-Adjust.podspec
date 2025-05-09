require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name             = 'Rudder-Adjust'
  s.version          = package['version']
  s.summary          = 'Privacy and Security focused Segment-alternative. Adjust Native SDK integration support.'

  s.description      = <<-DESC
Rudder is a platform for collecting, storing and routing customer event data to dozens of tools. Rudder is open-source, can run in your cloud environment (AWS, GCP, Azure or even your data-centre) and provides a powerful transformation framework to process your event data on the fly.
                       DESC

  s.homepage         = 'https://github.com/rudderlabs/rudder-integration-adjust-ios'
  s.license          = { :type => "ELv2", :file => "LICENSE.md" }
  s.author           = { 'RudderStack' => 'sdk@rudderstack.com' }
  s.source           = { :git => 'https://github.com/rudderlabs/rudder-integration-adjust-ios.git', :tag => "v#{s.version}" }

  s.ios.deployment_target = '12.0'

  s.source_files = 'Rudder-Adjust/Classes/**/*'

  s.dependency 'Rudder', '~> 1.29'
  s.dependency 'Adjust', '~> 5.1.0'
end
