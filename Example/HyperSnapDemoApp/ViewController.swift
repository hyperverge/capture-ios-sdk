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
    
    @IBOutlet weak var nationalID: UIButton!
    @IBOutlet weak var languageSwitch: UISwitch!
    
    var document:Document?
    static var language = "en"

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if ViewController.language == "en" {
            languageSwitch.setOn(false, animated: false)
            
        }else{
            languageSwitch.setOn(true, animated: false)
        }
        
        navigationController?.navigationBar.isHidden = true
        
    }
    
    @IBAction func FaceCaptureTapped(_ sender: UIButton) {
        let bundle = Bundle(for: HyperSnapSDK.self)
        let vc = UIStoryboard(name: HyperSnapSDK.StoryBoardName, bundle:bundle).instantiateViewController(withIdentifier: "HVFaceViewController") as! HVFaceViewController
        
        vc.completionHandler = {error, result in
            guard error == nil else{
                print("Error received - Code:\(error!.code), Description:\(error!.userInfo[NSLocalizedDescriptionKey] ?? "No Description")")
                return
            }
            
            if let result = result, let imageUri = result["imageUri"] as? String,let image = UIImage(contentsOfFile: imageUri) {
                let resultsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ResultsViewController") as! ResultsViewController
                resultsViewController.image = image
                vc.present(resultsViewController, animated: true, completion: nil)
                
            }else{
                print("No image Uri received")
            }
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    @IBAction func nationalIDTapped(_ sender: UIButton) {
        presentDocCamera(Document(type: .card),topText: "National ID")
    }
    
    @IBAction func electricityBillTapped(_ sender: UIButton) {
        presentDocCamera(Document(type: .a4),topText: "Electricity Bill")
    }
    
    @IBAction func bankStatementTapped(_ sender: UIButton) {
        presentDocCamera(Document(type: .a4),topText: "Bank Statement")
    }
    
    @IBAction func insuranceReceiptTapped(_ sender: UIButton) {
        presentDocCamera(Document(type: .a4),topText: "Insurance Receipt")
    }
    
    @IBAction func drivingLicenseTapped(_ sender: UIButton) {
        presentDocCamera(Document(type: .card),topText: "Driving License")
    }
    
    
    @IBAction func MRCTapped(_ sender: UIButton) {
        presentDocCamera(Document(type: .card),topText: "Motor Registration Certificate")
    }
    
    @IBAction func languageSwitch(_ sender: UISwitch) {
        if HyperSnapDemoAppLanguage.currentAppleLanguage() == "en" {
            HyperSnapDemoAppLanguage.setAppleLAnguageTo(lang: "vi")
            ViewController.language = "vi"
            UserDefaults.standard.synchronize()
            
        }else{
            HyperSnapDemoAppLanguage.setAppleLAnguageTo(lang: "en")
            ViewController.language = "en"
            UserDefaults.standard.synchronize()
            
        }
        
//        self.view.setNeedsDisplay()
        
                let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
                rootviewcontroller.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "rootnav")
                let mainwindow = (UIApplication.shared.delegate?.window!)!
                mainwindow.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
                UIView.transition(with: mainwindow, duration: 0.55001, options: .transitionFlipFromLeft, animations: { () -> Void in
                }) { (finished) -> Void in
                }
        
    }
    
    
    
    func presentDocCamera(_ document:Document, topText:String){
        let bundle = Bundle(for: HVFaceViewController.self)
        let vc = UIStoryboard(name: HyperSnapSDK.StoryBoardName, bundle:bundle).instantiateViewController(withIdentifier: "HVDocsViewController") as! HVDocsViewController
        
        vc.document = document
        vc.topText = topText
        vc.bottomText = NSLocalizedString("descriptionText", comment: "no comments")
        
        vc.completionHandler = {error, result in
            guard error == nil else{
                print(error!)
                return
            }
            
            if let result = result, let imageUri = result["imageUri"] as? String, let image = UIImage(contentsOfFile: imageUri){
                let resultsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ResultsViewController") as! ResultsViewController
                resultsViewController.image = image
                vc.present(resultsViewController, animated: true, completion: nil)
                
            }else{
                print("No image Uri?")
            }
        }
        self.present(vc, animated: true, completion: nil)
    }
}

extension String {
    func localized(lang:String) ->String {
        
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }}

