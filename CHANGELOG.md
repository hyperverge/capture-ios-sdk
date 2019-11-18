#### Version 2.4.4 [16 November 2019]
- Moved support to Xcode 11.2.1
- Made default modal presentation style to 'fullScreen'

#### Version 2.4.3 [30 September 2019]
- Moved support to Xcode 11 and Swift 5.1

#### Version 2.4.2 [29 September 2019]
- Minor bug fix with multiple faces detection module
- Included provision to add padding to selfie captured

#### Version 2.4.1 [23 April 2019]
- Moved support to Xcode 10.2 and Swift 5
- Multiple faces detection in face capture


#### Version 2.4.0 [4 March 2018]

- Added methods to make Face Match and OCR calls
- Added 'HVError' class
- Response structure of liveness call changed to return full API response and headers
- Optimised SDK size


#### Version 2.3.0 [12 October 2018]

- Moved support to Xcode 10.0 and Swift 4.2
- Exif data added to images returned in Face and Document capture

#### Version 2.2.1 [21 September 2018]

- Added optional Instruction Pages for Face and Document Capture
- Added Review Page for Document capture
- Added provision for style customisation for all prominent labels and buttons
- Added restriction to capturing selfies in landscape mode
- Added optional 'clientID' field to liveness calls
- Added new keys and modified existing keys in localisation

#### Version 2.1.3 [19 July 2018]

- Performance improvement in liveness

#### Version 2.1.2 [02 July 2018]

- Minor bug fixes
- `aspectRatio`  of documents has been changed from `CGFloat` to `Double`

#### Version 2.1.1 [20 June 2018]

- Added an option to optimize the liveness call.
- Minor bug fixes
- Minor UI updates

#### Version 2.0.0 [06 June 2018]

- Added Liveness Module
- UI revamp in both document and face capture ViewControllers
- Moved the 'Document' class to 'HyperSnapParams.Document' and the 'DocumentType' enum to 'HyperSnapParams.DocumentType'
- Exposed an enum for errors - 'HyperSnapParams.Error'
- Minor change in completionHandler structure for HVFaceViewController

#### Version 1.0.3 [17 April 2018]

- Compiled with Swift 4.1 (was 4.0.3)
- Minor UI change
- Minor issue with rotation fixed

#### Version 1.0.2 [12 April 2018]
- Temporary release with Swift 4.0.3
