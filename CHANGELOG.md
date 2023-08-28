#### 4.15.0 [28 Aug 2023]
- Features:
  - Support custom icons for primary buttons through UI config - support show/hide of these icons as well
  - Support displaying of client logos through UI config
- Bug Fixes:
  - Fix flashButton show/hide issue
  - Fix newline character signature issue
  - Fix indefinite loading animation after capturing the image in lower end devices
  - Fix SDK crash on clicking back button when image is being processed

#### 4.14.0 [14 Aug 2023]
- Features: 
  - Add support for `loggingPercentage` and `effectiveFrom` via Analytics config
  - Disable back button during API calls
- Bug Fixes
  - Add Processing text padding for A4 document type
#### 4.13.0 [28 July 2023]
- No changes 
  - Keeping it consistent with Android HyperSnapSDK version

#### 4.12.0 [30 Jun 2023]
- Features: 
  - Add support to make barcode read mandatory via HVDocConfig `setDisableBarcodeSkip` function
- Bug Fixes:
  - Fix memory issues in iPhone 6 & 7 variants
  
#### 4.11.0 [22 Jun 2023]
- Features: 
  - Migrated to the latest version of AVFoundation
  - Add support to return `latitude`, `longitude` in HVResponse
- Bug Fixes:
  - Fix signature check issue cause by JSONArray sorting
  
#### 4.10.0 [6 Jun 2023]
- Features:
  - Add support for iPad screens
  - Add secure flag support
    - Add setter function in HyperSnapSDKConfig to enable/disable secure feature - `setShouldSecure()`
    - Throws `securityError` when the user attempts to take a screenshot/records the screen
  - Add support for signature verification for all `allowedStatusCodes`
  - Add support to delete sensor data files after uploading
- Bug fixes:
  - Fix back navigation when instruction screen is present


#### 4.9.0 [22 May 2023]
- Features:
    - Add support for .lottie files in the SDK for animations
    - Add support for session recording in the camera layer
    - Add `isDocumentUpload` to OCR headers, `true` for upload flow

#### 4.8.2 [25 May 2023]
- Add support for .lottie files in the SDK for animations
    
#### 4.8.1 [8 May 2023]
- Bug fixes:
    - Fix camera initialisation to support latest devices
    - Fix retake message localisation
    
#### 4.8.0 [20 Apr 2023]
- Features:
    - Add support to enable/disable selfie video recording feature from remote config
    - Log video recording events to rudderstack
    - Add support to customise picker ui
    - Support feature enabling/disabling by OS config
    - Support Look Straight feature for iOS 16+ devices (which was previously disabled for all iOS 16+ devices)


#### 4.7.0 [04 Apr 2023]
- Features:
    - Update SDK security
    - Update QR Screen UI/UX:
        - Update QR scanning animation type
        - Update QR scanning animation color
        - Convert qr skip button to secondary button, update its placement in the screen
        - Support qr flow camera permission view text config
    - Add setter method to enable/disable overlay
    - Support `formPlaceHolderTextColor` from UI Config
- Bug fixes:
    - Fix Retake button placement issue
    - Fix Selfie retake button border radius issue
    - Fix Spinning animation issue
    - Fix Camera-permission view UI issues

#### 4.6.3 [20 March 2023]
- Fix font specific issues for UI config

#### 4.6.2 [04 March 2023]
- Fix ui/text config issues

#### 4.6.1 [16 Feb 2023]
- Add fix for lottie animation not loading 
- UI/UX bug fixes 
- [Patch] Add fix for html attributed string
- [Patch] Upload button text config issue fix

#### 4.6.0 [06 Jan 2023]
- Fix font family and font-weight keys
- Add text config support for wrong device orientation
- Add UI configs for QR instructions and QR scanning screens
- Add support for QR instructions animation customizations
- Support background color customisation from ui config - default to white
- Show online progress bar instead of loading VC while performing OCR and liveness calls
- Update document auto capture UI/UX

#### 4.2.1 [06 Jan 2022]
- Fix font family and font weight keys
- Support text config customisations for device orientation
- Fix for document upload flow crash

#### 4.5.0 [15 Dec 2022]
- UI refinements based on suggestions listed here
- UI/UX upgrade
    - Overlay for both Document and Selfie Capture screen
    - Document Auto capture UI/UX
    - Blur effect while capturing
- Rename Lottie... classes to HVLottie...
    - Make Lottie files internal
- Updated response structure for active liveness
- Adds support for HTML tags in TextViews

#### 4.4.0 [02 Dec 2022]
- Add selfie - active liveness feature
- Minor bug-fixes
  - Update `fonts` key in `UIConfig`
  - Update `animationPath` for document loading screen

#### 4.3.0 [18 Nov 2022]
- Add document detection - auto capture feature
- Support Doc detection feature via `DocDetect` subspec
- Update `deployment_target` to 11
- Add support for skip feature in QR Module

#### 4.2.0 [07 Nov 2022]
- Add extra checks to prevent image injection attacks on liveness api
- Fix issue with face not straight in iOS 16.0
- [PATCH] Fix for document upload flow crashß

#### 4.1.10 [28 Oct 2022]
- Disable pdf upload from document upload screen
- Add ui and alignment customisations 
- Add text customisations for QR module

#### 4.1.9 [13 Oct 2022]
- Fix retake message logic to use `code` from `summary.details` JsonArray
- Fix issue with AlertLabel, Face Retake screen in Dark mode 

#### 4.1.8 [29 Sep 2022]
- Add alert box in Selfie Capture Flow
- Refactor cache logic

#### 4.1.7 [06 Sep 2022]
- Added support to read barcode in document capture (Use setter function `setShouldReadBarcode`)
- Deprecate `setShouldReadQR` - Use `setShouldReadNIDQR` instead

#### 4.1.6 [18 Aug 2022]
- Bugfix : Branding issue fix

#### 4.1.5 [04 Aug 2022]
- Add Text and UI config
- Bugfix : Face Response Retake attempts

#### 4.1.4 [28 Jul 2022]
- Support Signature Check for ind based endpoints
- Send unique `fileName` in request body of all network calls

#### 4.1.3 [21 Jul 2022]
- QR Capture Screen UI/UX uprade
- Branding whitelisting
- Minor bug fixes in Instructions screen and Loading screen text customisation

#### 4.1.2 [29 Jun 2022]
- Add IP-to-geo feature
- Send failure attempts in HVResponse
- Fix minor UI bug

#### 4.1.1 [16 Jun 2022]
- Add selfie auto capture feature
- Remove unwanted logs

#### 4.1.0 [27 May 2022]
- Log necessary events to Rudderstack for Analytics
- Add video recording feature
- Loading VC dark mode bug fix

#### 4.0.0 [21 Apr 2022]
- Complete UI/UX revamp
- Integrate Rudderstack for analytics
