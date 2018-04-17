Pod::Spec.new do |s|

  s.name         = "HyperSnapSDK"
  s.version      = "1.0.3"
  s.summary      = "HyperSecure is HyperVerge's iOS Framework for capturing documents and faces at a resolution appropriate for our proprietary Deep Learning OCR and Face Recognition Engines."
  # s.description  = "HyperSecure is an iOS Framework of HyperVerge's Face Recognition based Identity and Access Management (IAM) System."
  s.homepage     = "https://github.com/hyperverge/capture-ios-sdk"
  s.author       = "HyperVerge"
  s.platform     = :ios
  s.ios.deployment_target = "9.0"
  s.source       = { :http => "https://github.com/hyperverge/capture-ios-sdk/blob/master/HyperSnapSDK.zip?raw=true" }
  s.ios.vendored_frameworks = "HyperSnapSDK.framework"

end
