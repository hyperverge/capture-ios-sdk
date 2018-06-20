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
    
    @IBOutlet weak var languageSwitch: UISwitch!
    @IBOutlet weak var noLivenessButton: UIButton!
    
    @IBOutlet weak var textureLivenessButton: UIButton!
    
    @IBOutlet weak var textureAndGestureButton: UIButton!
    
    @IBOutlet weak var cardButton: UIButton!
    @IBOutlet weak var passportButton: UIButton!
    @IBOutlet weak var a4Button: UIButton!
    @IBOutlet weak var otherButton: UIButton!
    
    
    var document:HyperSnapParams.Document?
    static var language = "en"
    
    var documentType = HyperSnapParams.DocumentType.card
    var topText = "ID Card"
    
    var livenessMode = HyperSnapParams.LivenessMode.none

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setLanguage()

        
        let livenessMode = UserDefaults.standard.value(forKey: "livenessMode") as? Int
        
        if let livenessMode = livenessMode {
            setLivenessMode(mode: livenessMode)
        }
        
        setDocumentButtonUI()
        
        navigationController?.navigationBar.isHidden = true
        
    }
    
    
    
    @IBAction func FaceCaptureTapped(_ sender: UIButton) {
        let bundle = Bundle(for: HyperSnapSDK.self)
        let vc = UIStoryboard(name: HyperSnapSDK.StoryBoardName, bundle:bundle).instantiateViewController(withIdentifier: "HVFaceViewController") as! HVFaceViewController
        
        vc.setLivenessMode(livenessMode)
        
        vc.completionHandler = {error, result,vcNew in
            
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
                
            }
            
            vcNew.present(resultsViewController, animated: true, completion: nil)

            
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func presentDocCamera(_ document:HyperSnapParams.Document, topText:String){
        let bundle = Bundle(for: HVFaceViewController.self)
        let vc = UIStoryboard(name: HyperSnapSDK.StoryBoardName, bundle:bundle).instantiateViewController(withIdentifier: "HVDocsViewController") as! HVDocsViewController
        
        vc.document = document
        vc.topText = topText
        vc.bottomText = NSLocalizedString("descriptionText", comment: "no comments")
        
        let resultsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ResultsViewController") as! ResultsViewController
        
        
        vc.completionHandler = {error, result in
            if error != nil {
                print("Error received - Code:\(error!.code), Description:\(error!.userInfo[NSLocalizedDescriptionKey] ?? "No Description")")
                resultsViewController.error = error
            }
            
            if let result = result, let imageUri = result["imageUri"] as? String, let image = UIImage(contentsOfFile: imageUri){
                resultsViewController.image = image
            }
            
            vc.present(resultsViewController, animated: true, completion: nil)
            
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    
    
    @IBAction func documentCaptureTapped(_ sender: UIButton) {
        presentDocCamera(HyperSnapParams.Document(type: documentType),topText: topText)
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
    
    
    
    //MARK: Liveness Mode Methods
    
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
        textureAndGestureButton.setImage(#imageLiteral(resourceName: "tick_off"), for: .normal)
        switch mode {
        case 0:
            livenessMode = HyperSnapParams.LivenessMode.none
            noLivenessButton.setImage(#imageLiteral(resourceName: "tick_on"), for: .normal)
        case 1:
            livenessMode = HyperSnapParams.LivenessMode.textureLiveness
            textureLivenessButton.setImage(#imageLiteral(resourceName: "tick_on"), for: .normal)

        default:
            livenessMode = HyperSnapParams.LivenessMode.textureAndGestureLiveness
            textureAndGestureButton.setImage(#imageLiteral(resourceName: "tick_on"), for: .normal)
        }
        
        UserDefaults.standard.set(mode, forKey: "livenessMode")
        
    }
    
    
    
    //Localisation methods
    func setLanguage(){
        if ViewController.language == "en" {
            languageSwitch.setOn(false, animated: false)
            
        }else{
            languageSwitch.setOn(true, animated: false)
        }
        HyperSnapDemoAppLanguage.setAppleLanguageTo(lang: "en")
    }
    
    @IBAction func languageSwitch(_ sender: UISwitch) {
        if HyperSnapDemoAppLanguage.currentAppleLanguage() == "en" {
            HyperSnapDemoAppLanguage.setAppleLanguageTo(lang: "vi")
            ViewController.language = "vi"
            UserDefaults.standard.synchronize()
            
        }else{
            HyperSnapDemoAppLanguage.setAppleLanguageTo(lang: "en")
            ViewController.language = "en"
            UserDefaults.standard.synchronize()
            
        }
        
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        rootviewcontroller.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "rootnav")
        let mainwindow = (UIApplication.shared.delegate?.window!)!
        mainwindow.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
        UIView.transition(with: mainwindow, duration: 0.55001, options: .transitionFlipFromLeft, animations: { () -> Void in
        }) { (finished) -> Void in
        }
        
    }
    
    
}


