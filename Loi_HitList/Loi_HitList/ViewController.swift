//
//  ViewController.swift
//  Loi_HitList
//
//  Created by loi on 1/16/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var people = [NSManagedObject]()
    
    @IBAction func addName(sender: AnyObject) {
        
        var alert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) {
            (action:UIAlertAction!) -> Void in
            let textField = alert.textFields![0] as UITextField
            self.names.append(textField.text)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
            (action:UIAlertAction!) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\"Loi's List\""
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        let person = people[indexPath.row]
        cell.textLabel?.text = person.valueForKey("name") as String?
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

