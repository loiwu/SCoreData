//
//  FilterViewController.swift
//  Bubble Tea Finder
//
//  Created by loi on 1/27/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

import UIKit
import CoreData

class FilterViewController: UITableViewController {
    
    @IBOutlet weak var firstPriceCategoryLabel: UILabel!
    @IBOutlet weak var secondPriceCategoryLabel: UILabel!
    @IBOutlet weak var thirdPriceCategoryLabel: UILabel!
    @IBOutlet weak var numDealsLabel: UILabel!
    
    //Price section
    @IBOutlet weak var cheapVenueCell: UITableViewCell!
    @IBOutlet weak var moderateVenueCell: UITableViewCell!
    @IBOutlet weak var expensiveVenueCell: UITableViewCell!
    
    //Most popular section
    @IBOutlet weak var offeringDealCell: UITableViewCell!
    @IBOutlet weak var walkingDistanceCell: UITableViewCell!
    @IBOutlet weak var userTipsCell: UITableViewCell!
    
    //Sort section
    @IBOutlet weak var nameAZSortCell: UITableViewCell!
    @IBOutlet weak var nameZASortCell: UITableViewCell!
    @IBOutlet weak var distanceSortCell: UITableViewCell!
    @IBOutlet weak var priceSortCell: UITableViewCell!
    
    var coreDataStack: CoreDataStack!
    
    lazy var cheapVenuePredicate: NSPredicate = {
        var predicate = NSPredicate(format: "priceInfo.priceCategory == %@", "$")
        return predicate!
    }()
    
    lazy var moderateVenuePredicate: NSPredicate = {
        var predicate = NSPredicate(format: "priceInfo.priceCategory == %@", "$$")
        return predicate!
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateCheapVenueCountLabel()
        populateModerateVenueCountLabel()
    }
    
    //MARK - UITableViewDelegate methods
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    // MARK - UIButton target action
    
    @IBAction func saveButtonTapped(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion:nil)
    }
    
    func populateCheapVenueCountLabel() {
        // $ fetch request
        
        let fetchRequest = NSFetchRequest(entityName: "Venue")
        fetchRequest.resultType = .CountResultType
        fetchRequest.predicate = cheapVenuePredicate
        
        var error: NSError?
        
        let result = coreDataStack.context.executeFetchRequest(fetchRequest, error: &error) as [NSNumber]?
        
        if let countArray = result {
            let count = countArray[0].integerValue
            
            firstPriceCategoryLabel.text = "\(count) bubble tea places"
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    
    func populateModerateVenueCountLabel() {
        // $$ fetch request
        
        let fetchRequest = NSFetchRequest(entityName: "Venue")
        fetchRequest.resultType = .CountResultType
        fetchRequest.predicate = moderateVenuePredicate
        
        var error: NSError?
        let result =
        coreDataStack.context.executeFetchRequest(fetchRequest,
            error: &error) as [NSNumber]?
        
        if let countArray = result {
            
            let count = countArray[0].integerValue
            
            secondPriceCategoryLabel.text =
            "\(count) bubble tea places"
            
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }

}
