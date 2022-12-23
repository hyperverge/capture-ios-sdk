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

#### 4.1.10 [28 Oct 2022]
- Disable pdf upload from document upload screen
- Add ui and alignment customisations 
- Add text customisations for QR module

#### 4.1.9 [13 Oct 2022]
- Fix retake message logic to use `code` from `summary.details` JsonArray
- Fix issue with AlertLabel, Face Retake screen in Dark mode 

#### 4.1.8 [29 Sept 2022]
- Add alert box in Selfie Capture Flow
- Refactor cache logic

#### 4.1.7 [6 Sept 2022]
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
