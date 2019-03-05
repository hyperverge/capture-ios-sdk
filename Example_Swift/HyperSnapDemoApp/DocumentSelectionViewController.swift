//
//  DocumentSelectionViewController.swift
//  HyperSnapDemoApp
//
//  Created by Srinija on 03/03/19.
//  Copyright © 2019 hyperverge. All rights reserved.
//

import UIKit

class DocumentSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Global.Document.getNumberOfDocuments()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentTableViewCell", for: indexPath) as! DocumentTableViewCell
        
        let document = Global.Document(rawValue: indexPath.row)
        
        cell.title.text = document?.getNameString()
        
        if Global.shared.currentDocument == document{
            cell.title.font = UIFont.boldSystemFont(ofSize: 17.0)
        }else{
            cell.title.font = UIFont.systemFont(ofSize: 17.0)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Global.shared.currentDocument = Global.Document(rawValue: indexPath.row)!
        self.dismiss(animated: true, completion: nil)
    }
    
    
}


class DocumentTableViewCell: UITableViewCell {
    @IBOutlet weak var title : UILabel!
}
