//
//  SwitchLanguage.swift
//  HyperSnapDemoApp
//
//  Created by Srinija on 07/03/18.
//  Copyright © 2018 hyperverge. All rights reserved.
//

import UIKit
// constants
let APPLE_LANGUAGE_KEY = "AppleLanguages"
/// L102Language
class HyperSnapDemoAppLanguage {
    /// get current Apple language
    class func currentAppleLanguage() -> String{
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        return current
    }
    /// set @lang to be the first in Applelanguages list
    class func setAppleLAnguageTo(lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }
}
