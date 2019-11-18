

# HyperSnapSDK Documentation for iOS

## Overview
HyperSnapSDK is HyperVerge's documents + face capture framework that captures images at a resolution appropriate for our proprietary Deep Learning OCR and Face Recognition Engines.

The framework provides a liveness feature that uses our advanced AI Engines to differentiate between a real user capturing their selfie from a photo/video recording.

The framework also provides optional Instructions pages for Document and Face capture and a Review page for Document capture.


![Screenshots](resources/screenshots.png?raw=true)


### Requirements
- Minimum iOS Deployment Target - iOS 9.0
-  Xcode 11.2.1

### ChangeLog

You can find the ChangeLog in the [CHANGELOG.md](CHANGELOG.md) file


## Table of contents


- [HyperSnapSDK Documentation for iOS](#hypersnapsdk-documentation-for-ios)
	- [Overview](#overview)
		- [Requirements](#requirements)
		- [ChangeLog](#changelog)
	- [Example Project](#example-project)
	- [Integration Steps](#integration-steps)
		- [1. Adding the SDK to your project](#1-adding-the-sdk-to-your-project)
			- [CocoaPods](#via-cocoapods-recommended)
			- [Manual](#manual)
		- [2. App Permissions](#2-app-permissions)
		- [3. Import Statements](#3-import-statements)
		- [4. Initializing the SDK](#4-initializing-the-sdk)
		- [5. Presenting the ViewControllers](#5-presenting-the-viewcontrollers)
			- [For Document Capture](#for-document-capture)
				- [Parameters](#parameters)
			- [For Face Capture](#for-face-capture)
				- [Parameters](#parameters)
			- [Liveness in Face Capture](#liveness-in-face-capture)
	- [Error Handling](#hverror)
	- [Advanced](#advanced)
		- [Localization](#localization)
			- [Document Based Customisation](#document-based-customisation)
		- [Styles](#styles)
		- [EXIF Data](#exif-data)
	- [TroubleShooting](#troubleshooting)
	- [Contact Us](#contact-us)



## Example Project
Please refer to the example app provided in the repo to get an understanding of the implementation.

To run the app:
  - clone/download the repo and open Example_Swift/HyperSnapSDKDemoApp.xcworkspace or Example_objC/HyperSnapDemoApp_ObjC.xcworkspace.
  - Set `appId`, `appKey` and `region` values in the Global.swift file to the ones received from HyperVerge.
  - Build and run the app.

## Integration Steps

### 1. Adding the SDK to your project

#### Via CocoaPods (Recommended)

HyperSnapSDK is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:
```
pod 'HyperSnapSDK'
```
- Navigate to Targets -> 'Your App name' -> Build Settings. Ensure that 'Always Embed Swift Standard Libraries' is set to 'Yes'.


#### Manual

- [Download](https://github.com/hyperverge/capture-ios-sdk/blob/master/HyperSnapSDK.zip?raw=true) 'HyperSnapSDK.framework' and add it to your Xcode project
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

To initialize the SDK, call the `HyperSnapSDK.initialize` method. This must be done before launching the camera. So, preferably in `applicationDidFinishLaunching` in the `AppDelegate` or `viewDidLoad` of the `ViewController` </br>

 Swift:
 ```
 HyperSnapSDK.initialize(appId: <appId>, appKey: <appKey>,region: HyperSnapParams.Region.AsiaPacific)
 ```

 Objective C:
 ```
 [HyperSnapSDK initializeWithAppId:@"<appID>" appKey:@"<appKey>" region:RegionAsiaPacific];
 ```
Where,
- appId, appKey are given by HyperVerge
- region: This is an enum, `HypeSnapParams.Region` with three values - `AsiaPacific`, `India` and `UnitedStates`.


### 5. Presenting the ViewControllers

The ViewControllers for both document capture and face capture have been provided in a StoryBoard in the framework. They are called `HVDocsViewController` and `HVFaceViewController` respectively. To add them to your app, call the `start` method of the respective ViewControllers.

#### For Document Capture

Swift:

        //1. Set properties
        let hvDocConfig = HVDocConfig()
        hvDocConfig.setDocumentType(HyperSnapParams.DocumentType.card)
        hvDocConfig.setShouldShowReviewPage(true)

		//2. Create completionHandler
        let completionHandler:(_ HVError?,_ result:[String:AnyObject]?,_ headers:[String:String]?, _ viewController:UIViewController)->Void = {error, result, headers, vcNew in
			if(error != nil){
				print("Error Received: \(error!.getErrorMessage()");
			}else{
				print("Results: \(result!.debugDescription)");
			}
		}
	//3. Call start method
	HVDocsViewController.start(self, hvDocConfig: hvDocConfig, completionHandler: completionHandler)


Objective C:
```
    HVDocConfig *docConfig = [HVDocConfig new];
	[docConfig setDocumentType:DocumentTypeA4];
	[docConfig setShouldShowReviewPage:true];
	[HVDocsViewController start:self hvDocConfig:docConfig completionHandler:^(HVError* error,NSDictionary<NSString *,id> * _Nonnull result, NSDictionary<NSString *,NSString *> * _Nonnull headers, UIViewController* vcNew){
		if(error != nil){
			NSLog(@"Error Received: %@",  error);
		}else{
			NSLog(@"Results: %@", result);
		}
	}];
```
##### Parameters
The start method takes a `HVDocConfig` object and a completion handler.

- `completionHandler`: This is a closure of type `HVError?, result:[String:AnyObject]?, vc:UIViewController -> Void`. It is called when a capture is successful or when an error has occured. The values of `error` and  `result` received by the closure determine whether the call was a success or failure. </br>
    - `error`: If the capture is successful, the error is set to `nil`. Otherwise, it is an object of type [HVError](#hverror)
    - `result`: If the capture failed, this is set to `nil`. Otherwise, it is of type `[String:AnyObject]`. This has a single key-value pair. The key is 'imageUri' and the value is the local path of the captured and processed image.

 -  `vc`: This is the ViewController that is currently active. You could choose to use this to present your next ViewController.
 Note: To dismiss the VC, please call `vc.dismiss`   if `shouldShowInstructionsPage`  is `false` and `vc.presentingViewController?.presentingViewController?.dimiss` if `shouldShowInstructionsPage`  is `true`.

- `hvDocConfig` : This is an object of type `HVDocConfig`. Its properties can be set with the setter methods provided for them.
	- `setDocumentType(_ type : HyperSnapParams.DocumentType)` The document type is used to determine the aspect ratio of the capture area.
	The `DocumentType` enum has four values:
	    - `.card`- Aspect ratio : 0.625. Example: Aadhaar Card, Vietnamese National ID, Driving License.
	    - `.a4`- Aspect ratio: 1.4. Example: Bank statement, insurance receipt
	    - `.passport`- Aspect ratio: 0.68. Example: Passports
	    - `.other`- This is for custom aspect ratio. In this case, the aspect ratio should be set in the next line by calling `hvDocConfig.setAspectRatio(_:)`.
	If the documentType is not set, it defaults to `.card`.
	- `setshouldShowInstructionsPage(_ shouldShow : Bool)` To determine if the instructions page should be shown before capture page. Defaults to `false`.
	- `setShouldShowReviewPage(_ shouldShow : Bool)` To determine if the document review page should be shown after capture page. Defaults to `false`.
	- `setShouldShowFlashButton(_ shouldShow : Bool)` Setting this to true will add a flash toggle button at the top right corner of the screen. It defaults to `false`.
	- `setShouldAddPadding(_ shouldAdd : Bool)` By default, padding is added around the document shown in the capture/review page. If this is not needed set this value to `false`.
	-  Label texts:
		- `setDocCaptureTitle(_ text : String)`
		- `setDocCaptureDescription(_ text : String)`
		- `setDocReviewTitle(_ text : String)`
		- `setDocReviewDescription(_ text : String)`
		- `setDocCaptureSubText(_ text : String)`
	These are the texts shown in the Capture page and the Review page. More customisations for the text and default values of these labels can be [found here](#localization)


#### For Face Capture

Swift:

        //1. Set properties
	    let hvFaceConfig = HVFaceConfig()
		hvFaceConfig.setLivenessMode(HyperSnapParams.LivenessMode.textureLiveness)

		//2. Create completionHandler
        let completionHandler:(_ error:HVError?,_ result:[String:AnyObject]?,_ headers:[String:String]?, _ viewController:UIViewController)->Void = {error, result,headers, vcNew in
			if(error != nil){
				print("Error Received: \(error!.getErrorMessage())");
			}else{
				print("Results: \(result!.debugDescription)");
			}
			vcNew.dismiss(animated: true, completion: nil)
		}

	//3. Call start method
	HVFaceViewController.start(self, hvFaceConfig: hvFaceConfig, completionHandler: completionHandler)


Objective C:

	 HVFaceConfig *faceConfig = [HVFaceConfig  new];
	[HVFaceViewController start:self hvFaceConfig:faceConfig completionHandler:^(HVError* error,NSDictionary<NSString *,id> * _Nonnull result, NSDictionary<NSString *,NSString *> * _Nonnull headers,UIViewController* vcNew){
	if(error != nil){
		NSLog(@"Error Received: %@",  error.getErrorMessage);
	}else{
		NSLog(@"Results: %@", result);
	}
	[vcNew dismissViewControllerAnimated:true completion:nil];
	}]

##### Parameters
The start method takes a `HVFaceConfig` object and a completion handler.

- `completionHandler`: This is a closure of type `error:NSError?, result:[String:AnyObject]?, vc:UIViewController -> Void`. It is called when a capture was successful or when an error has occured. The values of `error` and  `result` received by the closure determine whether the call was a success or failure. </br>
    - `error`: If the capture is successful, the error is set to `nil`. Otherwise, it is an object of type [HVError](#hverror).
    -   `result`: This is a dictionary of type  `[String:AnyObject]?`. If the capture failed, this is set to  `nil`  and a corresponding error is set in  `error`. For successful capture, response could be found [here](#liveness-in-face-capture).
    -  `vc`: This is the ViewController that is currently active. You could choose to use this to present your next ViewController.
 Note: To dismiss the VC, please call `vc.dismiss`   if `shouldShowInstructionsPage`  is `false` and `vc.presentingViewController?.presentingViewController?.dimiss` if `shouldShowInstructionsPage`  is `true`.

- `hvFaceConfig` : This is an object of type `HVFaceConfig`. Its properties can be set with the setter methods provided for them.
	- `setLivenessMode(_ livenessMode : HyperSnapParams.LivenessMode)`: [Explained here](#liveness-in-face-capture).
	- `setshouldShowInstructionsPage(_ shouldShow : Bool)`:  To determine if the instructions page should be shown before capture page. It defaults to `false`.
	- `setLivenessAPIHeaders(_ headers : [String:String])` : Any additional headers you want to send with the Liveness API Call. Following are headers that could be sent.
		 - *referenceId*: (String) This is a unique identifier that is assigned to the end customer by the API user. It would be the same for the different API calls made for the same customer. This would facilitate better analysis of user flow etc.
	-  `setLivenessAPIParameters(_ parameters : [String:AnyObject])` : Any additional parameters you want to send with the Liveness API Call. Following are parameters that could be sent.
		-  *dataLogging*: (String - "yes"/"no")  If you want HyperVerge to temporarily store the image to access the QC dashboard or for debugging purposes, please set this to "yes".
		- *allowEyesClosed*:(String - "yes"/"no") If this is set to 'no',  a error would be thrown when eyes are closed in the user photo. By default, closed eyes are allowed.


#### Liveness in Face Capture
The framework provides a liveness feature that uses our advanced AI Engines to differentiate between a real user capturing their selfie from a photo/video recording.
The liveness is enabled by default. To turn it off and on, use the `setLivenessMode` method in `HVConfig`.
```
hvFaceConfig.setLivenessMode(HyperSnapParams.LivenessMode.textureLiveness)
```
The structure of the result dictionary returned after Face Capture depends on the Liveness Mode:

**.none**: No liveness test is performed. The selfie that is captured is simply returned. If successful, the result dictionary in the completionHandler has one key-value pair.
	- `imageUri` : local path of the image captured

**.textureLiveness** :  Liveness test is performed on the selfie captured.  If livenessMode parameter is not set in `HVFaceConfig`, the framework defaults to this mode. If the call is successful, the API response is returned as the `result` dictionary in the completion handler. Apart from status code and success message, the result dictionary has the following fields:
- `imageUri` : String. Local path of the image captured <br/>
- `live`: String with values 'yes'/'no'. Tells whether the selfie is live or not.
- `liveness-score`: Float with values between 0 and 1. The confidence score for the liveness prediction.
- `to-be-reviewed`: String with values 'yes'/'no'. 'Yes' indicates that it is flagged for manual review.

<br/>

## API Calls

### OCR API Call
 To make OCR API calls directly from the App, use the following method:
 ```swift
HVNetworkHelper.makeOCRCall(endpoint:apiEndpoint, documentUri: docImageUri, parameters: params, headers: headers, completionHandler: completionHandler)
 ```
 where:

   - **parameters**: ([String:AnyObject]?) Optional.  Any additonal parameters to be sent with the API Call. Following are parameters that could be sent.
	  - *dataLogging*: (String - "yes"/"no")  If you want HyperVerge to temporarily store the image to access the QC dashboard or for debugging purposes, please set this to "yes".
   - **headers**: ([String:String]?) Optional.  Any additional headers to be sent with the API Call. Following are headers that could be sent.
	 - *referenceId*: (String) This is a unique identifier that is assigned to the end customer by the API user. It would be the same for the different API calls made for the same customer. This would facilitate better analysis of user flow etc.
   - **documentUri**: (String) The `imageUri` received in the completionHandler after Document Capture.
   - **completionHandler**: This is the callback which is used to return the results back after making the network request. Explained [here](#api-completionhandler).     
   - **endpoint**: (String)
        - For India KYC, these are the supported endpoints
	        - https://ind.docs.hyperverge.co/v1-1/readKYC
			- https://ind.docs.hyperverge.co/v1-1/readPAN
			- https://ind.docs.hyperverge.co/v1-1/readAadhaar
			- https://ind.docs.hyperverge.co/v1-1/readPassport
	        -  Please find the full documentation [here](https://github.com/hyperverge/kyc-india-rest-api)

	  - For Vietnam KYC, these are the supported endpoints
		- https://apac.docs.hyperverge.co/v1.1/readNID
		- https://apac.docs.hyperverge.co/v1.1/readMRC
		- https://apac.docs.hyperverge.co/v1.1/readDL
		- https://apac.docs.hyperverge.co/v1.1/verifyEVN
        - Please find the full documentation [here](https://github.com/hyperverge/kyc-vietnam-rest-api)

### Face Match Call
 To make Face ID match call directly from the App, use the following method:
  ```swift
     HVNetworkHelper.makeFaceMatchCall(endpoint:apiEndpoint, documentUri: docImageUri, faceUri:faceImageUri, parameters: params, headers: headers, completionHandler: completionHandler)
  ```

  where:
   * **endpoint**: (String)
	   - India: https://ind-faceid.hyperverge.co/v1/photo/verifyPair
      - Asia Pacific: https://apac.faceid.hyperverge.co/v1/photo/verifyPair

For more information, please check out the documentation [here](https://github.com/hyperverge/face-match-rest-api)
   - **parameters**: ([String:AnyObject]?) Optional.  It could have additonal parameters to be sent with the API Call. Following are parameters that could be sent.
	  - *dataLogging*: (String - "yes"/"no")  If you want HyperVerge to temporarily store the image to access the QC dashboard or for debugging purposes, please set this to "yes".
	  - *allowMultipleFaces*:(String - "yes"/"no") Set this to 'no' to have an error thrown when multiple faces are detected in the user photo. By default, multiple faces are allowed.
   - **headers**: ([String:String]?) Optional.  It could have additional headers to be sent with the API Call. Following are headers that could be sent.
	 - *referenceId*: (String) This is a unique identifier that is assigned to the end customer by the API user. It would be the same for the different API calls made for the same customer. This would facilitate better analysis of user flow etc.
- **faceUri**: (String) The `imageUri` received in the CompletionHandler after Face Capture.
- **documentUri**: (String) The `imageUri` received in the completionHandler after Document Capture.
 - **completionHandler**: This is the callback which is used to return the results back after making the network request. Explained [here](#api-completionhandler).  

## API CompletionHandler
This is of the type,
`(_ error: HVError?, _ result: [String: AnyObject]?, _ headers: [String:String]?)`

Where,

- **error** : Object of type [HVError](#hverror)
- **result** : `[String:AnyObject]?` If the API call was successful, this has the full API results. Otherwise, it is null.
- **headers** : `[String:String]?` This has any additional headers returned by HyperVerge's backend. If there are no such headers, it is null.

## HVError

HVError is the error object returned in case of failure in Face Capture, Document Capture, liveness call, makeOCRCall or makeFaceMatchCall.

It has two variables :  `errorCode`  and  `errorMessage`. These can be accessed with the following method:

```
let errorCode = hvError.getErrorCode()
let errorMessage = hvError.getErrorMessage()
```

Here are the various error codes returned by the SDK.

|Code|Description|Explanation|Action|
|-----|------|-----------|------|
|2|Internal SDK Error|Occurs when an unexpected error has happened with the HyperSnapSDK.|Notify HyperVerge|
|3|Operation Cancelled By User|When the user taps on cancel button before capture|Try again.|
|4|Camera Permission Denied|Occurs when the user has denied permission to access camera.|In the settings app, give permission to access camera and try again.|
|5|Hardware Error|Occurs when camera could not be initialized|Try again|
|6|Input Error|Occurs when the input needed by the start method/HVNetworkHelper method is not correct|Read error message for more details|
|11|Initialization Error|Occurs when SDK has not been initialized properly|Make sure HyperSnapSDK.initialise method is called before using the capture functionality|
|12|Network Error|Occurs when the internet is either non-existant or very patchy|Check internet and try again. If Internet is proper, contact HyperVerge|
|14|Internal Server Error|Occurs when there is an internal error at the server|Notify HyperVerge|
|22|Face Detection Error|Occurs when a face couldn't be detected in an image by the server|Try capture again|

Apart from the above errors, if the server returns a non 200 status code for any of the API calls (Liveness, Face Match and OCR), the status code is as it is returned as the error code and the corresponding message is returned as the error message.

These are the possible error codes that could be received from the server:

|Code|Description|Explanation|Action|
|-----|------|-----------|------|
|400|Invalid Request|Something is wrong with the input|Check the error message/API documentation|
|401|Authentication Error|Credentials provided in the initialization step are wrong|Check credentails. If they seem correct, contact HyperVerge|
|404|Endpoint not found|Endpoint sent to makeFaceMatchCall or makeOCRCall is not correct|Check API documentation|
|423|No supported KYC document found(OCR Call), <br/> Multiple Faces Found(Face Match Call), <br/> EyesClosed(Liveness Call)|Please check the API documentations for more details|Capture again|
|501, 502|Server Error|Internal server error has occured|Notify HyperVerge|
|503|Server Busy|Server Busy|Notify HyperVerge|



## Advanced

Customisation support has been provided to most of the labels and buttons in the framework's user interface.

Please note that using these features is completely optional.

### Localization

The framework supports localization for all the text it shows.

To implement localization, please add the relevant key - values in your app's `Localizable.Strings` files. While setting the texts, the framework will pick up the value for the corresponding key. If the values are not found, default values in the framework would be used.

|View Controller|Key|Default Value|
|---------|----------|-----------|
|HVDocInstructionsViewController|docInstructionsTitle|ID Capture Tips|
|HVDocInstructionsViewController|docInstructions1|Place within the box|
|HVDocInstructionsViewController|docInstructions2|Do not place outside|
|HVDocInstructionsViewController|docInstructions3|Avoid Glare|
|HVFaceInstructionsViewController|docInstructionsProceed|Proceed to Take Selfie|
|HVDocsViewController|docCaptureTitle|ID Card|
|HVDocsViewController|docCaptureDescription|Make sure your document is without any glare and is fully inside|
|HVDocsViewController|docCaptureSubText|Front Side|
|HVDocReviewViewController|docReviewTitle|Review This Page|
|HVDocReviewViewController|docReviewDescription|Make sure the image is clear and glare free|
|HVDocReviewViewController|docReviewRetakeButton|Retake|
|HVDocReviewViewController|docReviewContinueButton|Use This Photo|
|HVFaceInstructionsViewController|faceInstructionsTitle|Selfie Tips|
|HVFaceInstructionsViewController|faceInstructionsTop1|Good lighting on your face|
|HVFaceInstructionsViewController|faceInstructionsTop2|Hold phone in front of you|
|HVFaceInstructionsViewController|faceInstructionsBrightLight|Bright Light|
|HVFaceInstructionsViewController|faceInstructionsNoGlasses|No Glasses|
|HVFaceInstructionsViewController|faceInstructionsNoHat|No Hat|
|HVFaceInstructionsViewController|faceInstructionsProceed|Proceed to Capture ID|
|HVFaceViewController|faceCaptureTitle|Selfie Capture|
|HVFaceViewController|faceCaptureActivity|Processing|
|HVFaceViewController|faceCaptureFaceFound|Capture Now|
|HVFaceViewController|faceCaptureFaceNotFound|Place your face inside the circle|
|HVFaceViewController|faceCapturefaceNotFoundToast|Face not detected. Please try again|
|HVFaceViewController|faceCaptureMoveAway|Please move away from the screen|
|HVFaceViewController|faceCaptureWrongOrientation|Please hold the phone upright|


#### Document Based Customisation
Additional level of customisation has been given to the title and description texts in document capture and document review pages. This is to facilitate change of text based on the type of document.

For this, use the setter methods in `HVDocConfig` while initializing `HVDocsViewController`. The following are the variable names for the texts.
 - `docCaptureTitle`
 - `docCaptureDescription`
 - `docReviewTitle`
 - `docReviewDescription`
 - `docCaptureSubText`

Example:
```
hvDocConfig.setDocCaptureTitle("ID Card")
```

This inturn supports localization:
```
hvDocConfig.setDocCaptureTitle(NSLocalizedString("IDCardText", comment: ""))
```

Please note that if you set any of the above 5 texts in both `Localizable.strings` files and in `HVDocConfig`, the values in `HVDocConfig` would be considered.


### Styles

All prominent labels and buttons are objects of custom classes. Customisation of styles is available for these classes.

To set a style to an object, you call the setter method on the object's class. This style would be applied to all the objects of that class.

Note: Please make sure all the styles are set **before** initialising the ViewControllers.
Eg:. In the AppDelegates's applicationDidFinishLaunching(_:) or the viewDidLoad of the calling ViewController.

Here is an implementation example for setting some of the styles to achive the default UI:

```
let buttonColor = UIColor(red: 42.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1)
let textColor = UIColor(red: 115.0/255.0, green: 115.0/255.0, blue: 115.0/255.0, alpha: 1)

HVCameraButton.setImageTintColor(buttonColor)
HVDocReviewContinueButton.setBorderColor(buttonColor.cgColor)
HVDocReviewContinueButton.setBackgroundColor(buttonColor.cgColor)
HVDocReviewRetakeButton.setBorderWidth(2.0)
HVTitleLabel.setTextColor(textColor)
HVDocDescriptionLabel.setTextColor(textColor)
```
These are all the available classes:

|Class|Description|
|-----|-----------|
|HVCameraButton|Camera button in HVDocViewController and HVFaceViewController|
|HVDocReviewRetakeButton|Retake button in HVDocReviewViewController|
|HVDocReviewContinueButton|Continue button in HVDocReviewViewController|
|HVInstructionsProceedButton|'Proceed to Capture' buttons in HVDocInstructionsViewController and HVFaceInstructionsViewController|
|HVTitleLabel|Title labels in all ViewControllers|
|HVFaceInstructionTopLabel|The top two instructions in HVFaceInstructionsViewController|
|HVFaceInstructionBottomLabel|The bottom three instructions in HVFaceInstructionsViewController (no bright light, no glasses and no hat)|
|HVDocInstructionsLabel|All the instructions in HVDocInstructionsViewController|
|HVDocDescriptionLabel|Description label for aspect ratios < 1 in HVDocViewController and HVDocReviewViewController|
|HVDocDescriptionA4Label|Description label for aspect ratios > 1 in HVDocViewController and HVDocReviewViewController|
|HVFaceDescriptionLabel|Description label in HVFaceViewController|
|HVDocSubTextLabel|Label at the bottom end of the capture area in HVDocViewController that tells which side of the document to use|
|HVFaceActivityLabel|Label in the processing dialog shown while awaiting liveness response|
|HVFaceActivityIndicator|Activity indicator in the processing dialog shown while awaiting liveness response|

<br/>
These are the available methods for the above mentioned classes.

|Feature|Method Name|Classes|
|---------|----------|-----------|
|TintColor|setImageTintColor|HVCameraButton|
|BorderColor|setBorderColor|HVDocReviewRetakeButton, HVDocReviewContinueButton|
|BackgroundColor|setBackgroundColor|HVDocReviewRetakeButton, HVDocReviewContinueButton|
|BorderWidth|setBorderWidth|HVDocReviewRetakeButton, HVDocReviewContinueButton|
|TitleColor|setTitleColor|HVDocReviewRetakeButton, HVDocReviewContinueButton|
|TitleShadowColor|setTitleShadowColor|HVDocReviewRetakeButton, HVDocReviewContinueButton|
|TitleShadowOffset|setTitleShadowOffset|HVDocReviewRetakeButton, HVDocReviewContinueButton|
|Font|setFont|All Labels|
|Alignment|setTextAlignment|All Labels|
|TextColor|setTextColor|All Labels|
|ShadowColor|setShadowColor|All Labels|
|ShadowOffset|setShadowOffset|All Labels|
|Style|setStyle|HVFaceActivityIndicator|
|Color|setColor|HVFaceActivityIndicator|

### EXIF Data
Both Face and Document images returned by the SDK have EXIF data stored in them.
If the app has permissions to access location, the EXIF data would also contain the 'GPS' data of the image.
Please note that, if GPS data is needed, location permissions should be handled by the app before launching the SDK.

To get the EXIF data, use the following code on the `imageUri` returned by the SDK
 ```
let imageCFData = try! (Data(contentsOf: URL(fileURLWithPath: imageUri))) as CFData
if let cgImage = CGImageSourceCreateWithData(imageCFData, nil), let metaDict: NSDictionary = CGImageSourceCopyPropertiesAtIndex(cgImage, 0, nil) {
	print(metaDict)
}
 ```
## TroubleShooting
You can find the TroubleShooting guide [here](https://github.com/hyperverge/capture-ios-sdk/wiki/Troubleshooting)


## Contact Us
If you are interested in integrating this framework, please contact us at  [contact@hyperverge.co](mailto:contact@hyperverge.co). <br/>Learn more about HyperVerge [here](http://hyperverge.co/).
