//
//  ViewController.swift
//  Loi_HitList
//
//  Created by loi on 1/16/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var names = [String]()
    
    @IBAction func addName(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\"Loi's List\""
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

