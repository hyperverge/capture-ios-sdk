import Foundation
import UIKit



@objcMembers
public class ResourceBridge: NSObject {

    /// Returns the SwiftPM-generated resource bundle.
    @objc public class func spmResourceBundle() -> Bundle {
        return .module
    }

  
}
