Pod::Spec.new do |s|
  s.name         = "Netcore-Smartech-iOS-SDK"
  s.version      = "2.4.7"
  s.summary      = "The Netcore Smartech iOS SDK for App Engagement."
  s.description  = "Smartech provide full stack marketing automation. SDK provide app engagement feature."  
  s.homepage     = "https://github.com/NetcoreSolutions/Netcore-iOS-SDK"
  s.license          = { :type => "Commercial", :file => "LICENSE"}
  s.author           = { "Jobin Kurian" => "jobin.kurian@netcore.co.in" }
  s.platform     = :ios
  s.ios.deployment_target = "8.0"
  s.requires_arc = true
  s.source = { :git => "https://github.com/NetcoreSolutions/Netcore-iOS-SDK.git", :tag => "v#{s.version}" }
  s.ios.frameworks = "UIKit","Foundation","JavaScriptCore", "Security","SystemConfiguration","CoreLocation"
  s.ios.vendored_frameworks = "NetCorePush.framework"
end
