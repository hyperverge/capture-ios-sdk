//
//  ViewController.swift
//  HyperSecureDocsParentApp
//
//  Created by Srinija on 27/02/18.
//  Copyright © 2018 hyperverge. All rights reserved.
//

import UIKit
import HyperSnapSDK

class ViewController: UIViewController {
    
    
    let appId = ""
    let appKey = ""
    
    
    @IBOutlet weak var languageSwitch: UISwitch!
    @IBOutlet weak var noLivenessButton: UIButton!
    
    @IBOutlet weak var textureLivenessButton: UIButton!
    
    @IBOutlet weak var cardButton: UIButton!
    @IBOutlet weak var passportButton: UIButton!
    @IBOutlet weak var a4Button: UIButton!
    @IBOutlet weak var otherButton: UIButton!
    
        
    var documentType = HyperSnapParams.DocumentType.card
    var topText = "ID Card"
    
    var livenessMode = HyperSnapParams.LivenessMode.textureLiveness
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Initializes the SDK. Please use the 'appId' and 'appKey' values provided by HyperVerge
        HyperSnapSDK.initialize(appId: appId, appKey: appKey, region: HyperSnapParams.Region.AsiaPacific, product: HyperSnapParams.Product.faceID)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let livenessMode = UserDefaults.standard.value(forKey: "livenessMode") as? Int
        
        if let livenessMode = livenessMode {
            setLivenessMode(mode: livenessMode)
        }
        
        setDocumentButtonUI()
        
        navigationController?.navigationBar.isHidden = true
        
    }
    
    
    
    @IBAction func FaceCaptureTapped(_ sender: UIButton) {
        
        let hvFaceConfig = HVFaceConfig()
        hvFaceConfig.setLivenessMode(HyperSnapParams.LivenessMode.textureLiveness)
        hvFaceConfig.setShowInstructionsPage(true)
        hvFaceConfig.setOptimizeLivenessCall(true)
        
        let completionHandler:(_ error:NSError?,_ result:[String:AnyObject]?,_ viewController:UIViewController)->Void = {error, result,vcNew in
            
            let resultsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ResultsViewController") as! ResultsViewController
            
            if error != nil {
                
                print("Error received - Code:\(error!.code), Description:\(error!.userInfo[NSLocalizedDescriptionKey] ?? "No Description")")
                resultsViewController.error = error
            }
            
            if let result = result, let imageUri = result["imageUri"] as? String,let image = UIImage(contentsOfFile: imageUri) {
                resultsViewController.image = image
                if let live = result["live"] as? String{
                    let isLive = live == "yes" ? true : false
                    resultsViewController.isLivenessSuccessful = isLive
                }
                
            }else{
                print("No image Uri received")
            }
            
            vcNew.present(resultsViewController, animated: true, completion: nil)
            
            
        }
        HVFaceViewController.start(self, hvFaceConfig: hvFaceConfig, completionHandler: completionHandler)
    }
    
    
    func presentDocCamera(_ documentType:HyperSnapParams.DocumentType, topText:String){
        
        let hvDocConfig = HVDocConfig()
        hvDocConfig.setDocumentType(documentType)
        hvDocConfig.setShowReviewPage(true)
        hvDocConfig.setShowInstructionsPage(true)
        //        hvDocConfig.setCapturePageDescriptionText("Place front of your ID Card in the box")
        //        hvDocConfig.setCapturePageSubText("sub in config")
        hvDocConfig.setShowFlashButton(true)
        
        let completionHandler:(_ error:NSError?,_ result:[String:AnyObject]?,_ viewController:UIViewController)->Void = {error, result, vcNew in
            guard error == nil else{
                print(error!)
                return
            }
            
            if let result = result, let imageUri = result["imageUri"] as? String, let image = UIImage(contentsOfFile: imageUri){
                let resultsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ResultsViewController") as! ResultsViewController
                resultsViewController.image = image
                vcNew.present(resultsViewController, animated: true, completion: nil)
                
            }else{
                print("No image Uri?")
            }
        }
        HVDocsViewController.start(self, hvDocConfig: hvDocConfig, completionHandler: completionHandler)
    }
    
    
    
    @IBAction func documentCaptureTapped(_ sender: UIButton) {
        presentDocCamera(documentType,topText: topText)
    }
    
    
    @IBAction func documentTypeSelected(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            documentType = .card
            topText = "ID Card"
        case 1:
            documentType = .passport
            topText = "Passport"
        case 2:
            documentType = .a4
            topText = "A4 Document"
        case 3:
            documentType = .other
            topText = "Custom Document"
        default:
            break
        }
        
        setDocumentButtonUI()
    }
    
    
    
    @IBAction func livenessModeSelected(_ sender: UIButton) {
        setLivenessMode(mode: sender.tag)
    }

    func setDocumentButtonUI(){
        cardButton.setImage(#imageLiteral(resourceName: "tick_off"), for: .normal)
        passportButton.setImage(#imageLiteral(resourceName: "tick_off"), for: .normal)
        a4Button.setImage(#imageLiteral(resourceName: "tick_off"), for: .normal)
        otherButton.setImage(#imageLiteral(resourceName: "tick_off"), for: .normal)

        switch documentType {
        case .card:
            cardButton.setImage(#imageLiteral(resourceName: "tick_on"), for: .normal)
        case .a4:
            a4Button.setImage(#imageLiteral(resourceName: "tick_on"), for: .normal)
        case .passport:
            passportButton.setImage(#imageLiteral(resourceName: "tick_on"), for: .normal)
        case .other:
            otherButton.setImage(#imageLiteral(resourceName: "tick_on"), for: .normal)
        }
    }
    
    func setLivenessMode(mode:Int){
        noLivenessButton.setImage(#imageLiteral(resourceName: "tick_off"), for: .normal)
        textureLivenessButton.setImage(#imageLiteral(resourceName: "tick_off"), for: .normal)
        if mode == 0 {
            livenessMode = HyperSnapParams.LivenessMode.none
            noLivenessButton.setImage(#imageLiteral(resourceName: "tick_on"), for: .normal)
        }else{
            livenessMode = HyperSnapParams.LivenessMode.textureLiveness
            textureLivenessButton.setImage(#imageLiteral(resourceName: "tick_on"), for: .normal)
        }

        
        UserDefaults.standard.set(mode, forKey: "livenessMode")
        
    }
    
    
    
    /** Localisation methods.
    Please add necessary strings in Localization.Strings files or try other languages.
    Right now, only the bottom text in document capture will change language on flipping this switch.
     */
    @IBAction func languageSwitch(_ sender: UISwitch) {
        if sender.isOn {
            HyperSnapDemoAppLanguage.setAppleLanguageTo(lang: "vi")
            UserDefaults.standard.synchronize()
            
        }else{
            HyperSnapDemoAppLanguage.setAppleLanguageTo(lang: "en")
            UserDefaults.standard.synchronize()
            
        }
        
    }


    
}


