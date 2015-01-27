//
//  FilterViewController.swift
//  Bubble Tea Finder
//
//  Created by loi on 1/27/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

import UIKit
import CoreData

protocol FilterViewControllerDelegate: class {
    func filterViewController(filter: FilterViewController,
        didSelectPredicate predicate:NSPredicate?,
        sortDescriptor:NSSortDescriptor?)
}

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
    
    lazy var expensiveVenuePredicate: NSPredicate = {
        var predicate = NSPredicate(format: "priceInfo.priceCategory == %@", "$$$")
        return predicate!
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateCheapVenueCountLabel()
        populateModerateVenueCountLabel()
        populateExpensiveVenueCountLabel()
        populateDealsCountLabel()
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
    
    func populateExpensiveVenueCountLabel() {
        // $$$ fetch request
        
        let fetchRequest = NSFetchRequest(entityName: "Venue")
        fetchRequest.predicate = expensiveVenuePredicate
        
        var error: NSError?
        let count = coreDataStack.context.countForFetchRequest(fetchRequest, error: &error)
        if count == NSNotFound {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        thirdPriceCategoryLabel.text =
        "\(count) bubble tea places"
    }
    
    func populateDealsCountLabel() {
            //1
            let fetchRequest = NSFetchRequest(entityName: "Venue")
            fetchRequest.resultType = .DictionaryResultType
            
            //2
            let sumExpressionDesc = NSExpressionDescription()
            sumExpressionDesc.name = "sumDeals"
            
            //3
            sumExpressionDesc.expression =
                NSExpression(forFunction: "sum:",
                arguments:[NSExpression(forKeyPath: "specialCount")])
            
            sumExpressionDesc.expressionResultType =
                .Integer32AttributeType
            
            //4
            fetchRequest.propertiesToFetch = [sumExpressionDesc]
            
            //5
            var error: NSError?
            let result =
            coreDataStack.context.executeFetchRequest(fetchRequest,
                error: &error) as [NSDictionary]?
            
            if let resultArray = result {
                
                let resultDict = resultArray[0]
                let numDeals: AnyObject? = resultDict["sumDeals"]
                numDealsLabel.text = "\(numDeals!) total deals"
                
            } else {
                println("Could not fetch \(error), \(error!.userInfo)")
            }
    }

}
