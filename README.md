## HyperSnapSDK Framework Documentation

## Introduction
HyperSnapSDK is HyperVerge's documents + face capture framework that captures images at a resolution appropriate for our proprietary Deep Learning OCR and Face Recognition Engines.

### Requirements
- Minimum iOS Deployment Target - iOS 9.0

### Example Project
- Please refer to the example app provided in the repo to get an understanding of the implementation process.
- To run the app, clone/download the repo and open example/HyperSnapSDKDemoApp.xcworkspace.
- Build and run the app.

### Integration Steps


##### Via CocoaPods

HyperSnapSDK is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:
```
pod 'HyperSnapSDK'
```

##### Manually

- Download 'HyperSnapSDK.framework' and add it to your Xcode project
- Navigate to Targets -> General and include the framework under 'Embedded Binaries' and 'Linked Frameworks and Libraries'.
- Navigate to Targets -> 'Your App name' -> Build Settings. Ensure that 'Always Embed Swift Standard Libraries' is set to 'Yes'.


##### Permissions

The framework uses the device's camera. To request the user for camera permissions, add this key-value pair in your application's info.plist file.<br/>
    Key: Privacy - Camera Usage Description<br/>
    Value: "Access to camera is needed for document and face capture"
    
The same in xml would be:

```
<key>NSCameraUsageDescription</key>
<string>"Access to camera is needed for document and face capture"</string>
```

#### Presenting the ViewControllers:

The ViewControllers for both document capture and face capture have been provided in a Story Board in the framework. They are called 'HVDocsViewController' and 'HVFaceViewController' respectively.
To add them to your app, just call them like any other ViewController, only difference being, the bundle ID should be that of the  framework.

**For Face Capture:**

Swift:
     
        //Instantiate the ViewController
        let bundle = Bundle(for: HyperSnapSDK.self)
        let vc = UIStoryboard(name: HyperSnapSDK.StoryBoardName, bundle:bundle).instantiateViewController(withIdentifier: "HVFaceViewController") as! HVFaceViewController
            
        //Set ViewController properties (described later)
        vc.completionHandler = completionHandler
            
        //Present the ViewController
        self.present(vc, animated: true, completion: nil)
        
    
Objective C:
    
        //Instantiate the ViewController
        NSBundle *bundle  = [NSBundle bundleForClass:[HyperSnapSDK self]];

        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:HyperSnapSDK.StoryBoardName bundle: bundle];
        HVFaceViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"HVFaceViewController"];
        
        //Set ViewController properties (described later)
        vc.completionHandler = ^(NSError* error,NSDictionary<NSString *,id> * _Nonnull result){
            if(error != nil){
                printf("Error!");
            }else{
                printf("Success!");
            }
         };
    
        //Present the ViewController
        [self presentViewController:vc animated:YES completion:nil];
    
    
**For Document Capture:**

Swift:
    
        //Instantiate the ViewController
        let bundle = Bundle(for: HVFaceViewController.self)
        let vc = UIStoryboard(name: HyperSnapSDK.StoryBoardName, bundle:bundle).instantiateViewController(withIdentifier: "HVDocsViewController") as! HVDocsViewController
        
        //Set ViewController properties (described later)
        vc.document = Document(type: .card)
        vc.topText = "National ID"
        vc.bottomText = "Place your National ID inside the box"
        vc.completionHandler = completionHandler
        
        //Present the ViewController
        self.present(vc, animated: true, completion: nil)

        
Objective C:
    
        //Instantiate the ViewController
        NSBundle *bundle  = [NSBundle bundleForClass:[HyperSnapSDK self]];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:HyperSnapSDK.StoryBoardName bundle: bundle];
        HVDocsViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"HVDocsViewController"];
        
        //Set ViewController properties (described later)
        vc.topText = @"National ID";
        vc.bottomText = @"Please place your document inside the box";
        vc.completionHandler = ^(NSError* error,NSDictionary<NSString *,id> * _Nonnull result){
            if(error != nil){
                printf("Error!");
            }else{
                printf("Success!");
            }
         };
    
        //Present the ViewController
        [self presentViewController:vc animated:YES completion:nil];


##### Properties
These are the properties to be set while initializing the ViewController

- completionHandler(HVDocsViewController,HVFaceViewController) - required: This is to be a closure of type `error:NSError?, result:[String:AnyObject]?) -> Void`. It is called when a capture is successful or when an error has occured. The values of `error` and  `result` received by the closure determine whether the call was a success or failure. </br>
    - `error`: If the capture is successful, the error is set to `nil`. Otherwise, it is an `NSError` object with following information
        - `code`: Error code stating type of error. (discussed later)
        - `userInfo`: A dictionary of type `[String:Any]`.
            - The key `NSLocalizedDescriptionKey`  has the error description.
    - `result`: If the capture failed, this is set to `nil`. Otherwise, it is of type `[String:AnyObject]`. This has a single key-value pair. The key being 'imageUri' and the value is the local path of the captured image.
- document:(HVDocsViewController) - optional: This is the type of the document to be captured. The type determines the aspect ratio of the document. It is an enum with these values:
    - `.card`- Aspect ratio : 0.625. Example: Vietnamese National ID, Driving License, Motor Registration Certificate
    - `.a4`- Aspect ratio: 1.4. Example: Bank statement, insurance receipt
    - `.passport`- Aspect ratio: 0.78. Example: Passports
    - `.other`- This is for aspect ratios that don't fall in the above categories. In this case, the aspect ratio should be set in the next line by calling `vc.document.aspectRatio = <Aspect Ratio>`
- topText, bottomText, topLabelFont & bottomLabelFont (HVDocsViewController) - optional: The titles at the top and bottom in the View and their fonts respectively.
    
    
#### Error Codes

Descriptions of the error codes returned above are given here. 
Please note that when an error occurs, the ViewController is dismissed and the completionHandler is called with the error.

|Error Code|Description|Explanation|Action|
|----------|-----------|-----------|------|
|2|Internal SDK Error|Occurs when an unexpected error has happened with the HyperSnapSDK.|Notify HyperVerge|
|3|Operation Cancelled By User|When the user taps on cancel button before capture|Try again.|
|4|Camera Permission Denied|Occurs when SDK has not been initialized properly.|Check if the initialization of SDK is happening before any functionality is being used.|
|5|Hardware Error|Occurs when SDK has not been initialized properly.|Check if the initialization of SDK is happening before any functionality is being used.|
