#### 4.1.11 [7th Oct 2022]
- Added extra checks to prevent image injection attacks on liveness api
- Fixed issue with face not straight in iOS 16.0

#### 4.1.10 [28th Oct 2022]
- Disabled pdf upload from document upload screen
- Added ui and alignment customisations 
- Added text customisations for QR module

#### 4.1.9 [13th Oct 2022]
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
