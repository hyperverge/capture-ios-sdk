
## HyperSnapSDK Framework Documentation

## Overview
HyperSnapSDK is HyperVerge's documents + face capture framework that captures images at a resolution appropriate for our proprietary Deep Learning OCR and Face Recognition Engines.

The framework provides a liveness feature that uses our advanced AI Engines to tell if a captured image is that of a real person or a photograph.

### Requirements
- Minimum iOS Deployment Target - iOS 9.0
-  Xcode 9.3


## Table of contents

- [Overview](#overview)
- [Table of contents](#table-of-contents)
	- [Requirements](#requirements)
- [Example Project](#example-project)
- [Integration Steps](#integration-steps)
	- [1. Adding the SDK to your project](#1-adding-the-sdk-to-your-project)
		- [Via CocoaPods](#via-cocoapods)
		- [Manual](#manual)
	- [2. App Permissions](#2-app-permissions)
	- [3. Import Statements](#3-import-statements)
	- [4. Initializing the SDK](#4-initializing-the-sdk)
	- [5. Presenting the ViewControllers](#5-presenting-the-viewcontrollers)
		- [For Document Capture](#for-document-capture)
			- [Properties](#properties)
		- [For Face Capture](#for-face-capture)
			- [Properties](#properties)
	- [Integrating Liveness in Face Capture](#integrating-liveness-in-face-capture)
- [Error Codes](#error-codes)
- [Advanced](#advanced)
	- [Localization](#localization)
		- [Document Capture](#document-capture)
		- [Face Capture](#face-capture)
- [Contact Us](#contact-us)


## Example Project
- Please refer to the example app provided in the repo to get an understanding of the implementation process.
- To run the app, clone/download the repo and open example/HyperSnapSDKDemoApp.xcworkspace.
- Build and run the app.

## Integration Steps

### 1. Adding the SDK to your project

#### Via CocoaPods

HyperSnapSDK is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:
```
pod 'HyperSnapSDK'
```

#### Manual

- Download 'HyperSnapSDK.framework' and add it to your Xcode project
- Navigate to Targets -> General and include the framework under 'Embedded Binaries' and 'Linked Frameworks and Libraries'.
- Navigate to Targets -> 'Your App name' -> Build Settings. Ensure that 'Always Embed Swift Standard Libraries' is set to 'Yes'.


### 2. App Permissions

The framework uses the device's camera. To request the user for camera permissions, add this key-value pair in your application's info.plist file.<br/>
    Key: Privacy - Camera Usage Description
    Value: "Access to camera is needed for document and face capture"
    
The same in xml would be:
```
<key>NSCameraUsageDescription</key>
<string>"Access to camera is needed for document and face capture"</string>
```
### 3. Import Statements
Add the import statement in all files using the HyperSnapSDK
Objective C:
 ```
@import HyperSnapSDK;
 ```

 Swift:
 ```
import HyperSnapSDK
 ```

### 4. Initializing the SDK

Add the following line to your code for initializing the Library. This must be called before launching the camera. So, preferably in `viewDidLoad` of the `ViewController` or `applicationDidFinishLaunching` in the `AppDelegate`.</br>

 Objective C:
 ```
 [HyperSnapSDK initializeWithAppId:@<appId> appKey:@<appKey> region: <region> product: <product>];
 ```

 Swift:
 ```
 HyperSecureSDK.initialize(appId: <appId>, appKey: <appKey>,region: <region>, product: <product>)
 ```
Where,
- appId, appKey are given by HyperVerge
- region: This is an enum, `HypeSnapParams.Region` with three values - `AsiaPacific`, `India` and `UnitedStates`.
- product: This is an enum, `HyperSnapParams.Product` with two values - `faceID` annd `faceIAM`. 

>**Note**: Please note that this step is required only if liveness is used.

### 5. Presenting the ViewControllers

The ViewControllers for both document capture and face capture have been provided in a Story Board in the framework. They are called 'HVDocsViewController' and 'HVFaceViewController' respectively.
To add them to your app, just call them like any other ViewController. The only difference is that the bundle ID should be that of the  framework.

#### For Document Capture

Swift:
    
        //Instantiate the ViewController
        let bundle = Bundle(for: HyperSnapSDK.self)
        let vc = UIStoryboard(name: HyperSnapSDK.StoryBoardName, bundle:bundle).instantiateViewController(withIdentifier: "HVDocsViewController") as! HVDocsViewController
        
        //Set ViewController properties (described later)
        vc.document = HyperSnapSDK.Document(type: .card)
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

- completionHandler (required): This is to be a closure of type `error:NSError?, result:[String:AnyObject]?) -> Void`. It is called when a capture is successful or when an error has occured. The values of `error` and  `result` received by the closure determine whether the call was a success or failure. </br>
    - `error`: If the capture is successful, the error is set to `nil`. Otherwise, it is an `NSError` object with following information
        - `code`: Error code stating type of error. (discussed later)
        - `userInfo`: A dictionary of type `[String:Any]`.
            - The key `NSLocalizedDescriptionKey`  has the error description.
    - `result`: If the capture failed, this is set to `nil`. Otherwise, it is of type `[String:AnyObject]`. This has a single key-value pair. The key being 'imageUri' and the value is the local path of the captured image.
- document (optional): This is the type of the document to be captured. It is of type `HyperSnapParams.Document`. The `type` in the init method determines the aspect ratio of the document. It is an enum, `HyperSnapParams.DocumentType`, with these values:
    - `.card`- Aspect ratio : 0.625. Example: Vietnamese National ID, Driving License, Motor Registration Certificate
    - `.a4`- Aspect ratio: 1.4. Example: Bank statement, insurance receipt
    - `.passport`- Aspect ratio: 0.68. Example: Passports
    - `.other`- This is for custom aspect ratio. In this case, the aspect ratio should be set in the next line by calling `vc.document.aspectRatio = <Aspect Ratio>`
- `topText`, `bottomText`, `topLabelFont` & `bottomLabelFont` (optional): The titles at the top and bottom in the View and their fonts respectively.

#### For Face Capture

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
        vc.completionHandler = ^(NSError* error,NSDictionary<NSString *,id> * _Nonnull result, UIViewController* newVC){
            if(error != nil){
                printf("Error!");
            }else{
                printf("Success!");
            }
         };
    
        //Present the ViewController
        [self presentViewController:vc animated:YES completion:nil];
    
    
##### Properties
These are the properties to be set while initializing the HVFaceViewController

- completionHandler - required: This is to be a closure of type `error:NSError?, result:[String:AnyObject]?,vc:UIViewController) -> Void`. It is called when a capture is successful or when an error has occured. The value of `error` received by the closure determine whether the call was a success or failure. </br>
    - `error`: If the process was successful, the error is set to `nil`. Otherwise, it is an `NSError` object with following information
        - `code`: Error code stating type of error. (discussed later)
        - `userInfo`: A dictionary of type `[String:Any]`.
            - The key `NSLocalizedDescriptionKey`  in `userInfo` has the error description.
    - `result`: This is a dictionary of type `[String:AnyObject]`. If the capture failed, this is set to `nil` and a corresponding error is set in `error`. If a capture was successful but there was an error in a later step (only when liveness in enabled - discussed later) or when the capture was successful and the liveness is disabled, the result has a single key-value pair. The key being `imageUri` and the value being the local path of the captured image. 
    - `vc`: This is the ViewController that is currently active. You could choose to use this to present your next ViewController or dismiss it.
    > **Note:**  The `vc` could be a `HVFaceViewController` or a `HVGestureViewController`(if gesture liveness is enabled)
    
<br/>

### Integrating Liveness in Face Capture

The framework has two liveness detection methods. Texture liveness and Gesture Liveness. This can be set while initializing HVFaceViewController by calling the 'setLivenessMode' method before presenting the ViewController.

        vc.setLivenessMode(livenessMode)

Here, `livenessMode` is of type `HypeSnapParams.LivenessMode`, an enum with 3 values:

**.none**: No liveness test is performed. The selfie that is captured is simply returned. If successful, the result dictionary in the completionHandler has one key-value pair. 
- `imageUri` : local path of the image captured

**.textureLiveness** : Texture liveness test is performed on the selfie captured.  If successful, a result dictionary with the following key-value pairs is returned in the completionHandler

- `imageUri` : String. Local path of the image captured <br/>
- `live`: String with values 'yes'/'no'. Tells whether the selfie is live or not.
- `liveness-score`: Float with values between 0 and 1.
- The confidence score for the liveness prediction.
- `to-be-reviewed`: String with values 'yes'/'no'. Yes indicates that it flagged for manual review.

**.textureAndGestureLiveness**: In this mode, based on the results of the texture Liveness call, the user might be asked to do a series of gestures to confirm liveness. The user performing the gestures is arbitrarily matched with the selfie captured. If  one or more of these matches fail, a 'faceMatch' error is returned (refer to 'Error Codes' section). 
If all the gestures are succefully performed and the face matches are sucessful, a result dictionary with the following key-value pairs is returned in the completionHandler
- `imageUri` : String. Local path of the image captured <br/>
- `live`: String with values 'yes'/'no'. Tells whether the selfie is live or not.

<br/>
#### Optimize Texture Liveness
If bandwidth is low/limited or the time taken by the API call is a constraint, add the following line while initializing the HVFaceViewController to optimize the liveness calls. Please note that this process has a slightly lower accuracy compared to the non-optimized one. By default the non-optimized process would be used.

```
vc.shouldOptimizeLivenessCall(true)
```

<br/>

## Error Codes

Descriptions of the error codes returned in the completion handler are given here. 
Please note that when an error occurs, the ViewController is dismissed and the completionHandler is called with the error.

You could compare the error codes you receive directly with a hardcoded value or  with the `HyperSnapSDK.Error` enum values.
eg:.  
```
	switch HyperSnapSDK.Error(rawValue:error!.code)! {
		case HyperSnapSDK.Error.operationCancelledByUser:
			print("Operation cancelled by user")
		case HyperSnapSDK.Error.cameraPermissionDenied:
			print("Camera permissions denied")
		default:
			break
	}
```

|Error Code|Description|Explanation|Action|
|----------|-----------|-----------|------|
|2|Internal SDK Error|Occurs when an unexpected error has happened with the HyperSnapSDK.|Notify HyperVerge|
|3|Operation Cancelled By User|When the user taps on cancel button before capture|Try again.|
|4|Camera Permission Denied|Occurs when the user has denied permission to access camera.|In the settings app, give permission to access camera and try again.|
|5|Hardware Error|Occurs when there is an error setting up the camera.|Make sure the camera is accessible.|
|101|Initialization Error|Occurs when SDK has not been initialized properly.|Make sure HyperSnapSDK.initialise method is called before using the capture functionality|
|102|Network Error|Occurs when the internet is either non-existant or very patchy.|Check internet and try again. If Internet is proper, contact HyperVerge|
|103|Authentication Error|Occurs when the request to the server could not be Authenticated/Authorized.|Make sure appId and appKey set in the initialization method are correct|
|104|Internal Server Error|Occurs when there is an internal error at the server.|Notify HyperVerge|
|201|Face Match Error|Occurs when one or more faces captured in the gestures flow do not match the selfie|This is equivalent to liveness fail. Take corresponding action|
|202|Face Detection Error|Occurs when a face couldn't be detected in an image by the server|Try capture again|


## Advanced

### Localization

The framework currently supports English(Base) and Vietnamese. 

#### Document Capture
 While initializing document capture flow, to set the text of topLabel or bottomLabel with localisation support, add relavent entries in Localizable.strings files and use the corresponding key while setting topText or bottomText. Please refer to the example project for more details.

   Swift:
    
        vc.bottomText = NSLocalizedString("bottomText", comment: "")
        
   Objective C:
    
        vc.bottomText = NSLocalizedString(@"bottomText", comment: "");

#### Face Capture

While initializing face capture flow (all liveness modes), please add relavent entries in the `Localization.Strings` files for the following keys. The framework will pick up the value for the corresponding key. If the values are not set, default values in the framework would be used.

|Key|Default Value|View Controller|
|----------|-----------|-----------|
|captureNow|Capture Now|HVFaceViewController|
|placeFaceInCircle|Place your face inside the circle|HVFaceViewController, HVGestureViewController|
|faceNotFoundToast|Face not detected. Please try again|HVFaceViewController|
|lookLeftText|Look Left|HVGestureViewController|
|lookRightText|Look Right|HVGestureViewController|
|tiltLeftText|Tilt Left|HVGestureViewController|
|tiltRightText|Tilt Right|HVGestureViewController|
|timeRanOutText|Time Ran Out|HVGestureViewController|
|incorrectActionText|Incorrect Action Performed|HVGestureViewController|
|multipleFacesText|Multiple Faces Detected|HVGestureViewController|




<br/>

## Contact Us
If you are interested in integrating this framework, please send us a mail at  [contact@hyperverge.co](mailto:contact@hyperverge.co). Learn more about HyperVerge [here](http://hyperverge.co/).
