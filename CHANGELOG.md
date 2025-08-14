#### 5.0.0 [12 Aug 2025]
- Enhancements
    - Improvements to face detection algorithm for face capture
    - Add support to save files within a private folder in the app's directory
- Bug Fixes
    - Fix force unwrap crash in document picker screen
    
#### 4.39.2 [30 Jul 2025]
- Bug Fixes
    - Fix bug with `setShouldEnableOverlay` for document capture
    - Fix crash happening when race condition occurs with camera opening
    
#### 4.39.1 [11 Jul 2025]
- Bug Fixes
    - Fix app crash on iOS 26 devices when liveness mode is set to .none
#### 4.39.0 [11 Jul 2025]
- Enhancements
    - Added fallback face detector support for iOS 26 via remote config

#### 4.38.0 [2 Jul 2025]
- Enhancements
    - Changed default lottie to .lottie for size optimisations

#### 4.37.1 [14 June 2025]
- Bug Fixes:
    - Fix document capture screen ui issues

#### 4.37.0 [16 May 2025]
- Bug Fixes:
    - Fix memory leaks and retained resources for face capture module

#### 4.36.1 [13 May 2025]
- Bug Fixes:
    - Fix multiple callbacks fired from QR capture module
#### 4.36.0 [30 Apr 2025]
- Enhancements:
    - Add support for enabling SDK close button via `<config>.setShowCloseIcon(true)` 
#### 4.35.0 [17 Apr 2025]
- Enhancements:
  - Add support for `parallel session` for doc and face
#### 4.34.0 [3 Apr 2025]
- Enhancements:
  - Add support for `assistiveCapture` property in document module in WebCore mode
#### 4.33.0 [26 Mar 2025]
- Enhancements:
    - Add support for `prefetchConfigs` method 
#### 4.32.0 [17 Mar 2025]
- Enhancements:
    - Security enhancements for doc module
    - Add support for `setShowConsent` for selfie capture module

#### 4.31.1 [21 Feb 2025]
- Bug Fixes:
    - Fix logic to display "Powered By Hyperverge" branding layout in Consent Screen


#### 4.31.0 [18 Feb 2025]
- Enhancements:
    - Security enhancements for face module
    
#### 4.30.1 [13 Feb 2025]
- Bug Fixes:
    - Fix camera bug with selfie retake flow
    
#### 4.30.0 [24 Jan 2025]
- Enhancements:
    - Add support for consent screen before selfie capture

#### 4.29.2 [21 Jan 2025]
- Enhancements:
    - Optimise camera load time for face capture screens
- Bug Fixes:
    - Fix document capture aspect ratio bug for a4 


#### 4.29.1 [13 Jan 2025]
- Enhancements:
    - Add support for additional data to enhance security during face capture.
    - Fix the black padding issue during video recording.
    
#### 4.29.0 [19 Dec 2024]
- Enhancements:
    - Add support for `setModuleId` setter method to increment attemptsCount
#### 4.28.1 [17 Dec 2024]
- Enhancements:
    - Enable private access folder for images saved within app's directory
- Bug Fixes:
    - Fix crash happening when metadata is attached to face camera
    
#### 4.28.0 [28 Nov 2024]
- Enhancements:
    - Add support for gradient backgrounds on buttons.
    
#### 4.27.0 [20 Nov 2024]
- Enhancements:
    - Add support for solid background for capture screens
    - Add support for color customisations to branding 

#### 4.26.0 [5 Nov 2024]
- Enhancements:
    - Add uiConfig support for `processingTitleLabel`, `processingHintLabel`
#### 4.25.0 [25 Oct 2024]
- Enhancements:
    - Add support for `submittedTimestamp` in HVResponse for doc & face capture
    - Add support for fallback cameraDevice when discoverSession fails
- Bug Fixes 
    - Fix retry message label image alignment in retake screens

#### 4.24.0 [21 Aug 2024]
- Enhancements:
    - Add UI config support for custom background image for non-capture screens
    - Add UI config support for capture-screen related UI elements

#### 4.23.1 [26 Jul 2024]
- Enhancements:
    - Enable doc capture button only after camera is initialised
    
#### 4.23.0 [13 Jun 2024]
- Enhancements:
    - Add support for iOS triple camera mode in QR scanner

#### 4.22.3 [22 May 2024]
- Enhancements:
    - Add loader view when feature config is being fetched for capture screens
- Bug Fixes :
    - Fix for overlapping camera view constraints on document capture screen
    
#### 4.22.2 [14 May 2024]
- Enhancements:
  - Make default config fetch non-blocking API call

#### 4.22.1 [29 Apr 2024]
- Enhancements:
  - Add ability to pre-load icons present in UI config
- Bug Fixes : 
  - Rename public final classes with HV prefix
  
#### 4.21.2 [26 Apr 2024]
- Enhancements:
  - Add ability to pre-load icons present in UI config
- Bug Fixes : 
  - Rename public final classes with HV prefix

#### 4.22.0 [22 Apr 2024]
- Features:
  - Added privacy manifest to HyperSnapSDK

#### 4.21.1 [18 Apr 2024]
- Features:
  - Add support for UI config for NFC Instruction screen
- Bug Fixes : 
  - Remove references to  `NWPathMonitor` which requires min deployment target set to 12 in Xcode 15

#### 4.20.2 [16 Apr 2024]
- Bug Fixes: 
  - Remove references to `NWPathMonitor` which requires min deployment target set to 12 in Xcode 15

#### 4.21.0 [03 Apr 2024]
- Features:
  - Add support for UI config for NFC modules
  - Add support lottie color customisations
  - Add support to reduced "Powered by HyperVerge" branding texts
- Bug Fixes:
  - Update default texts in QR flow

#### 4.20.1 [13 Mar 2024]
- Bug Fixes: 
  - Fix for white preview coming up when camera loads
  - Fix multiple capture sessions created for qr scanner page
  
#### 4.20.0 [9 Feb 2024]
- Features: 
  - Add support to use loader lottie while uploading documents
  - Add support to customise typography for all text elements used in the SDK

#### 4.19.1 [2 Feb 2024]
- Features: 
  - Migrate analytics fully from Rudderstack to Apollo
- Bug Fixes:
  - Fix issue with multiple callbacks in qr scanner page


#### 4.19.0 [23 Jan 2024]
- Features: 
  - Add support for back button visibility and icon customisations 
  

#### 4.18.0 [19 Jan 2024]
- Bug Fixes: 
  - Fixed issue with reversed instruction for active liveness on multi cam devices.
  
#### 4.17.1 [6 Jan 2024]
- Bug Fixes: 
  - Fixed automatic closing of iPad screens
  - Fixed face capture getting stuck when face is blurry

#### 4.17.0 [28 Nov 2023]
- Features: 
  - Added support for to view password protected files
- Bug Fixes: 
  - Fixed failing checks on signature verification

#### 4.16.1 [20 Oct 2023]
- Bug Fixes: 
  - Fix null pointer crash in switch camera
  - Fix crash in selecting available preview formats for image capture

#### 4.16.0 [10 Oct 2023]
- Features: 
  - Support video statement customisation through UI Config
  
#### 4.15.0 [28 Aug 2023]
- Features:
  - Support custom icons for primary buttons through UI config - support show/hide of these icons as well
  - Support displaying of client logos through UI config
- Bug Fixes:
  - Fix flashButton show/hide issue
  - Fix newline character signature issue
  - Fix indefinite loading animation after capturing the image in lower end devices
  - Fix SDK crash on clicking back button when image is being processed
  - Fix iPad closing on iOS 13 & above

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
