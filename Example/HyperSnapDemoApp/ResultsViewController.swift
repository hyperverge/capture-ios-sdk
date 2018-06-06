//
//  ResultsViewController.swift
//  HyperSecureDocsParentApp
//
//  Created by Srinija on 01/03/18.
//  Copyright © 2018 hyperverge. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var livenessStatusLabel: UILabel!
    
    @IBOutlet weak var errorTextLabel: UILabel!
    var image:UIImage?
    var isLivenessSuccessful: Bool?
    var error:NSError?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let image = image {
            imageView.image = image
        }
        if let isLivenessSuccessful = isLivenessSuccessful {
            if isLivenessSuccessful {
                livenessStatusLabel.text = "Liveness Successful!"
            }else{
                livenessStatusLabel.text = "Liveness Failed"
            }
        }else{
            livenessStatusLabel.isHidden = true
        }
        
        if let error = error {
            errorTextLabel.text = error.userInfo[NSLocalizedDescriptionKey] as? String
            if error.code == 103 {
                errorTextLabel.text = "\(error.userInfo[NSLocalizedDescriptionKey] ?? "") - Make sure appId and appKey are set in AppDelegate"
            }
        }else{
            errorTextLabel.isHidden = true
        }
        
        
    }
    
    
}
