//
//  Global.swift
//  HyperSnapDemoApp
//
//  Created by Srinija on 22/01/19.
//  Copyright © 2019 hyperverge. All rights reserved.
//

import UIKit
import HyperSnapSDK

public class Global: NSObject {
    
    static var shared = Global()
    
    
    //Set SDK Credentials here. Initialisation happens in the AppDelegate
    var appID : String?//Add your AppID here
    var appKey : String?//Add your AppKey here
    var region : HyperSnapParams.Region? //Set this to .India or .AsiaPacific or .UnitedStates
    
    
    var currentDocument = Document.IndiaAadhaar
    
    public enum Document:Int {
        case IndiaAadhaar = 0
        case IndiaPan
        case IndiaPassport
        case IndiaVoterID
        case VietnamNID
        case VietnamDL
        
        static func getNumberOfDocuments() -> Int {
            return 6
        }
        func getDocumentType() -> HyperSnapParams.DocumentType{
            switch self{
            case .IndiaAadhaar,.IndiaPan,.VietnamNID,.VietnamDL:
                return .card
            case .IndiaPassport:
                return .passport
            case .IndiaVoterID:
                return .other
            }
        }
        //This will be called only for Voter ID
        func getAspectRatio() -> Double{
            switch self{
            case .IndiaAadhaar,.IndiaPan,.VietnamNID,.VietnamDL:
                return 0.625
            case .IndiaPassport:
                return 0.67
            case .IndiaVoterID:
                return 1.5
            }
        }
        
        func getNameString()->String {
            switch self {
            case .IndiaAadhaar:
                return "Aadhaar Card"
            case .IndiaPan:
                return "Pan Card"
            case .IndiaPassport:
                return "Indian Passport"
            case .IndiaVoterID:
                return "Voter ID"
            case .VietnamNID:
                return "National ID"
            case .VietnamDL:
                return "Vietnam DL"
            }
        }
        
        
        func getEndpoint()->String {
            switch self {
            case .IndiaAadhaar, .IndiaPan, .IndiaPassport, .IndiaVoterID:
                return "https://ind-docs.hyperverge.co/v2.0/readKYC"
            case .VietnamNID:
                return "https://apac.docs.hyperverge.co/v1.1/readNID"
            case .VietnamDL:
                return "https://apac.docs.hyperverge.co/v1.1/readDL"
            }
        }
        
        
        func getRegion()->HyperSnapParams.Region {
            switch self {
            case .IndiaAadhaar, .IndiaPan, .IndiaPassport, .IndiaVoterID:
                return HyperSnapParams.Region.India
            case .VietnamNID, .VietnamDL:
                return HyperSnapParams.Region.AsiaPacific
            }
        }
        
    }
    
    func getFaceMatchEndpoint()->String{
        if region == .India {
            return "https://ind-faceid.hyperverge.co/v1/photo/verifyPair"
        }else{
            return "https://apac.faceid.hyperverge.co/v1/photo/verifyPair"
        }
    }
    
}
