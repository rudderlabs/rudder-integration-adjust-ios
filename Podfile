workspace 'RudderAdjust.xcworkspace'
use_frameworks!
inhibit_all_warnings!
platform :ios, '9.0'

def shared_pods
    pod 'Rudder', :path => '~/Documents/Rudder/RudderStack-Cocoa/'
end

target 'SampleiOSObjC' do
    project 'Examples/SampleiOSObjC/SampleiOSObjC.xcodeproj'
    shared_pods
    pod 'Rudder-Adjust', :path => '.'
end

target 'RudderAdjust' do
    project 'RudderAdjust.xcodeproj'
    shared_pods
    pod 'Adjust' , '4.29.6'
end
