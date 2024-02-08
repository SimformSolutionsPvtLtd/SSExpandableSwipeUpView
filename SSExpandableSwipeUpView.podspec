#
# Be sure to run `pod lib lint SSExpandableSwipeUpView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name              = 'SSExpandableSwipeUpView'
    s.version           = '1.0.0'
    s.summary           = 'It is a centralized hub designed to provide users with a quick and organized overview of their incoming alerts, messages, and updates.'
    s.description       = <<-DESC
    SSExpandableSwipeUpView is a library for iOS developers, written in Swift. It resembles iPhone notification tray, also known as the Notification Center, is a centralized hub designed to provide users with a quick and organized overview of their incoming alerts, messages, and updates. Accessible by swiping down from the top edge of the screen, the notification tray displays a chronological list of notifications from various apps and system events. The library offers a wide range of customizable options. SSExpandableSwipeUpView is simple to integrate into your existing projects and offers excellent performance, making it an essential tool for any iOS developer contributing to a seamless and personalized user experience.
                DESC
    s.homepage          = 'https://github.com/SimformSolutionsPvtLtd/SSExpandableSwipeUpView.git'
    s.license           = { :type => 'MIT', :file => 'LICENSE' }
    s.author            = { 'Purva Rupareliya' => 'purva.r@simformsolutions.com' }
    s.source            = { :git => 'https://github.com/SimformSolutionsPvtLtd/SSExpandableSwipeUpView.git', :tag => s.version.to_s }
    s.platform = :ios, "16.0"
    s.ios.deployment_target = '16.0'
    s.swift_version = '5.0'
    s.source_files      = 'Sources/**/*.{swift}'
    s.resources = "Sources/SSExpandableSwipeUpView/Resources/Assets.xcassets"
    s.resource_bundles  = {
      'SSExpandableSwipeUpView' => ['Sources/SSExpandableSwipeUpView/Resources/**/*']
    }
end


