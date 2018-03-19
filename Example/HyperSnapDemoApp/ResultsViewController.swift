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
    
    var image:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let image = image {
            imageView.image = image
        }
    }


}
