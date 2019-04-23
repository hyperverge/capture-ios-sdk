//
//  ResultsViewController.swift
//  HyperSecureDocsParentApp
//
//  Created by Srinija on 01/03/18.
//  Copyright © 2018 hyperverge. All rights reserved.
//

import UIKit
import HyperSnapSDK

//Implementation of OCR Call and Face Match Call using the SDK can be found in this class
class ResultsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    
    @IBOutlet weak var livenessResultLabel: UILabel!
    @IBOutlet weak var livenessErrorLabel: UILabel!
    @IBOutlet weak var livenessHeaderLabel: UILabel!
    
    @IBOutlet weak var faceMatchResultLabel: UILabel!
    @IBOutlet weak var faceMatchErrorLabel: UILabel!
    @IBOutlet weak var faceMatchHeaderLabel: UILabel!
    
    @IBOutlet weak var ocrResultLabel: UILabel!
    @IBOutlet weak var ocrErrorLabel: UILabel!
    @IBOutlet weak var ocrHeadersLabel: UILabel!
    
    
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title2: UILabel!
    
    @IBOutlet weak var livenessStack: UIStackView!
    @IBOutlet weak var faceMatchStack: UIStackView!
    @IBOutlet weak var ocrStack: UIStackView!
    
    
    var livenessResult : [String:AnyObject]? = nil
    var faceMatchResult : [String:AnyObject]? = nil
    var ocrResult : [String:AnyObject]? = nil
    
    var livenessError : HVError? = nil
    var faceMatchError : HVError? = nil
    var ocrError : HVError? = nil
    
    var livenessHeader : [String:String]? = nil
    var faceMatchHeader : [String:String]? = nil
    var ocrHeader : [String:String]? = nil
    
    var faceImageUri : String?
    var docImageUri : String?
    
    var shouldMakeOCRCall = false
    var shouldMakeFaceMatchCall = false
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool){
        
        activityIndicator.startAnimating()
        
        makeOCRCall()
        makeFaceMatchCall()
        
        setUI()
    }
    
    
    //MARK: Implementation of makeOCRCall method of HyperSnapSDK
    func makeOCRCall(){
        if !shouldMakeOCRCall {
            return
        }
        
        let completionHandler:(_ error: HVError?, _ result: [String: AnyObject]?, _ headers: [String:String]?) -> Void = {error, result, header in
            
            self.ocrResult = result
            self.ocrHeader = header
            self.ocrError = error
            
            self.shouldMakeOCRCall = false
            self.setUI()
        }
        let headers = ["referenceId":"test"]
        
        let params = ["dataLogging":"yes"] as [String:AnyObject]
        
        HVNetworkHelper.makeOCRCall(endpoint: Global.shared.currentDocument.getEndpoint(), documentUri: docImageUri ?? "", parameters: params, headers: headers, completionHandler: completionHandler)
    }
    
    
    //MARK: Iplementation of makeFaceMatchCall method of HyperSnapSDK
    func makeFaceMatchCall(){
        if !shouldMakeFaceMatchCall {
            return
        }
        let completionHandler:(_ error: HVError?, _ result: [String: AnyObject]?, _ headers: [String:String]?) -> Void = {error, result, header in
            
            self.faceMatchResult = result
            self.faceMatchHeader = header
            self.faceMatchError = error
            
            self.shouldMakeFaceMatchCall = false
            self.setUI()
        }
        
        let headers = ["referenceId":"test"]
        let params = ["dataLogging":"yes"] as [String:AnyObject]
        
        HVNetworkHelper.makeFaceMatchCall(endpoint: Global.shared.getFaceMatchEndpoint(), faceUri:faceImageUri ?? "", documentUri: docImageUri ?? "", parameters: params, headers: headers, completionHandler: completionHandler)
    }
    
    
    func setUI(){
        
        if(shouldMakeFaceMatchCall || shouldMakeOCRCall){
            return
        }
        
        activityIndicator.stopAnimating()
        
        //Liveness
        setVariousLabels(resultLabel: livenessResultLabel, errorLabel: livenessErrorLabel, headerLabel: livenessHeaderLabel, result: livenessResult, error: livenessError, header: livenessHeader, stack: livenessStack)
        
        //Face Match
        setVariousLabels(resultLabel: faceMatchResultLabel, errorLabel: faceMatchErrorLabel, headerLabel: faceMatchHeaderLabel, result: faceMatchResult, error: faceMatchError, header: faceMatchHeader, stack: faceMatchStack)
        
        //OCR
        setVariousLabels(resultLabel: ocrResultLabel, errorLabel: ocrErrorLabel, headerLabel: ocrHeadersLabel, result: ocrResult, error: ocrError, header: ocrHeader, stack: ocrStack)
        
        if let faceUri = faceImageUri{
            imageView.image = UIImage(contentsOfFile: faceUri)
            imageView.isHidden = false
        }else{
            imageView.isHidden = true
        }
        if let docImageUri = docImageUri {
            imageView2.image = UIImage(contentsOfFile: docImageUri)
            imageView2.isHidden = false
        }else{
            imageView2.isHidden = true
        }
    }
    
    func setVariousLabels(resultLabel:UILabel, errorLabel:UILabel, headerLabel:UILabel, result:[String:AnyObject]?, error: HVError?, header:[String:String]?, stack:UIStackView){
        
        if(result == nil && error == nil){
            stack.isHidden = true
            return
        }else{
            stack.isHidden = false
        }
        
        //Set Result Label
        var resultStr = ""
        if let result = result{
            for(key,value) in result {
                resultStr = "\(resultStr)\n\(key) : \(value)"
            }
        }else{
            resultStr = "Null"
        }
        
        resultLabel.text = "Result:\(resultStr)"
        
        //Set Error Label
        var errorStr = ""
        if let error = error {
            errorStr = "Error Code: \(error.getErrorCode())\nError Message: \(error.getErrorMessage())"
        }else{
            errorStr = "Null"
        }
        
        errorLabel.text = "Error:\n\(errorStr)"
        
        //Set Header Label
        var headerStr = ""
        if let header = header{
            for(key,value) in header {
                headerStr = "\(headerStr)\n\(key) : \(value)"
            }
        }else{
            headerStr = "Null"
        }
        
        headerLabel.text = "Header:\(headerStr)"
        
    }
    
    
    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
