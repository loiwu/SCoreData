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
            self.saveName(textField.text)
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // 1 - before do anything with Core Data, a managed object context is needed.
        // pull up the application delegate and grab a reference to its managed object context
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        // 2 - Setting a fetch request’s entity property, or alternatively initializing it with init(entityName:), fetches all objects of a particular entity.
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        // 3 - executeFetchRequest(_:error:) returns an optional array of managed objects that meets the criteria specified by the fetch request
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            people = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
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
    
    func saveName(name: String) {
        // 1 - get a reference to the app delegate
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        // 2 - create a new managed object and insert it into the managed object context
        let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedContext)
        
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        // 3 - set the name attribute using key-value coding
        person.setValue(name, forKey: "name")
        
        // 4 - commit changes to person and save to disk by calling save on the managed object context.
        var error: NSError?
        if !managedContext.save(&error) {
            // if there is ever an error with the save operation, inspect the error and alert the user if necessary.
            println("Could not save \(error), \(error?.userInfo)")
        }
        
        // 5 -  Insert the new managed object into the people array so that it shows up in the table view when it reloads
        people.append(person)
    }


}

