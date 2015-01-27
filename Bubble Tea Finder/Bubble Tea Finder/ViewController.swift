//
//  ViewController.swift
//  Bubble Tea Finder
//
//  Created by loi on 1/27/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var coreDataStack: CoreDataStack!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(tableView: UITableView?,
        numberOfRowsInSection section: Int) -> Int {
            return 10
    }
    
    func tableView(tableView: UITableView!,
        cellForRowAtIndexPath
        indexPath: NSIndexPath!) -> UITableViewCell! {
            
            var cell = tableView.dequeueReusableCellWithIdentifier("VenueCell") as UITableViewCell
            cell.textLabel?.text = "Bubble Tea Venue"
            cell.detailTextLabel!.text = "Price Info"
            
            return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toFilterViewController" {
            
            let navController = segue.destinationViewController as UINavigationController
            let filterVC = navController.topViewController as FilterViewController
        }
    }
    
    @IBAction func unwindToVenuListViewController(segue: UIStoryboardSegue) {
        
    }
}

