//
//  AppDelegate.swift
//  HyperSecureDocsParentApp
//
//  Created by Srinija on 27/02/18.
//  Copyright © 2018 hyperverge. All rights reserved.
//

import UIKit
import HyperSnapSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        HyperSnapDemoAppLocalizer.DoTheSwizzling()
        
        if let appID = Global.shared.appID, let appKey = Global.shared.appKey, let region = Global.shared.region {
            //SDK Initialization Step
            HyperSnapSDK.initialize(appId: appID, appKey: appKey, region: region)
        }
        
        HyperSnapSDK.setShouldUseSignature(true)
        
        return true
    }



}

