Pod::Spec.new do |s|
  
  s.name         = "HyperSnapSDK"
  s.version      = "4.35.0-spm"
  s.summary      = "HyperVerge's iOS Framework for capturing documents and faces to be used with our AI Engines"
  s.description  = "HyperSnapSDK is HyperVerge’s documents + face capture framework that captures images at a resolution appropriate for our proprietary Deep Learning OCR and Face Recognition Engines.The framework provides a liveness feature that uses our advanced AI Engines to tell if a captured image is that of a real person or a photograph."
  s.homepage     = "https://github.com/hyperverge/capture-ios-sdk"
  s.author       = "HyperVerge"
  s.license      = { :type => 'Custom', :file => 'LICENSE' }
  s.source       = { :git => "https://github.com/hyperverge/capture-ios-sdk.git", :tag => "#{s.version}"}
  
  
  s.static_framework = true
  s.platform     = :ios
  s.ios.deployment_target = "11.0"
  s.swift_version = '5.0'
  s.default_subspecs = "Core"
  
  s.subspec 'Core' do |cs|
    cs.vendored_frameworks = 'Core/HyperSnapSDK.xcframework'
    cs.ios.resource = 'Core/HVResources.bundle'
  end
  
  s.subspec 'DocDetect' do |dds|
    dds.dependency 'TensorFlowLiteSwift', '2.11.0'
    dds.vendored_frameworks = 'DocDetect/HyperSnapSDK.xcframework'
    dds.ios.resource = 'DocDetect/HVResources.bundle'
  end

end
