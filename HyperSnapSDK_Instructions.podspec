Pod::Spec.new do |s|

  s.name         = "HyperSnapSDK_Instructions"
  s.version      = "1.0.0"
  s.summary      = "Optional submodule of HyperSnapSDK"
  s.description  = "Optional submodule of HyperSnapSDK. Contains capture instructions screens for face and document capture"
  s.homepage     = "https://github.com/hyperverge/capture-ios-sdk"
  s.author       = "HyperVerge"
  s.platform     = :ios
  s.ios.deployment_target = "9.0"
  s.source       = { :http => "https://github.com/hyperverge/capture-ios-sdk/blob/master/HyperSnapSDK_Instructions.zip?raw=true" }
  s.ios.vendored_frameworks = "HyperSnapSDK_Instructions.framework"

end
