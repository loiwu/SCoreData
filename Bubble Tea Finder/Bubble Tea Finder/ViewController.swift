//
//  ViewController.swift
//  Bubble Tea Finder
//
//  Created by loi on 1/27/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var coreDataStack: CoreDataStack!
    var fetchRequest: NSFetchRequest!
    var venues: [Venue]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRequest = coreDataStack.model.fetchRequestTemplateForName("FetchRequest")
        
        fetchAndReload()
    }
    
    func tableView(tableView: UITableView?,
        numberOfRowsInSection section: Int) -> Int {
            return venues.count
    }
    
    func tableView(tableView: UITableView!,
        cellForRowAtIndexPath
        indexPath: NSIndexPath!) -> UITableViewCell! {
            
            var cell = tableView.dequeueReusableCellWithIdentifier("VenueCell") as UITableViewCell
            
            let venue = venues[indexPath.row]
            cell.textLabel?.text = venue.name
            cell.detailTextLabel!.text = venue.priceInfo.priceCategory
            
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
    
    //MARK - Helper methods
    func fetchAndReload() {
        var error: NSError?
        let results = coreDataStack.context.executeFetchRequest(fetchRequest, error: &error) as [Venue]?
        
        if let fetchedResults = results {
            venues = fetchedResults
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        tableView.reloadData()
    }
}

