//
//  ViewController.swift
//  WorldCup
//
//  Created by loi on 1/28/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,NSFetchedResultsControllerDelegate {

    var coreDataStack: CoreDataStack!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var fetchedResultsController : NSFetchedResultsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1
        let fetchRequest = NSFetchRequest(entityName: "Team")
        
        let zoneSort = NSSortDescriptor(key: "qualifyingZone", ascending: true)
        let scoreSort = NSSortDescriptor(key: "wins", ascending: true)
        let nameSort = NSSortDescriptor(key: "teamName", ascending: true)
        
        fetchRequest.sortDescriptors = [zoneSort, scoreSort, nameSort]
        
        //2
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.context, sectionNameKeyPath: "qualifyingZone", cacheName: "worldCup")
        
        fetchedResultsController.delegate = self
        
        //3
        var error: NSError? = nil
        if (!fetchedResultsController.performFetch(&error)) {
            println("Error: \(error?.localizedDescription)")
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionInfo = fetchedResultsController.sections![section] as NSFetchedResultsSectionInfo
        return sectionInfo.name
    }
    
    func numberOfSectionsInTableView (tableView: UITableView) -> Int {
        
        return fetchedResultsController.sections!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
        let sectionInfo = fetchedResultsController.sections![section] as NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let resuseIdentifier = "teamCellReuseIdentifier"
            
        var cell = tableView.dequeueReusableCellWithIdentifier(resuseIdentifier, forIndexPath: indexPath) as TeamCell
        configureCell(cell, indexPath: indexPath)
        
        return cell
    }
    
    func configureCell(cell: TeamCell, indexPath: NSIndexPath) {
        let team = fetchedResultsController.objectAtIndexPath(indexPath) as Team
        
        cell.flagImageView.image = UIImage(named: team.imageName)
        cell.teamLabel.text = team.teamName
        cell.scoreLabel.text = "Wins: \(team.wins)"
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let team = fetchedResultsController.objectAtIndexPath(indexPath) as Team
        
        let wins = team.wins.integerValue
        
        team.wins = NSNumber(integer: wins+1)
        
        coreDataStack.saveContext()
        
        tableView.reloadData()
    }
    
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        
        tableView.reloadData()
        
    }
            
}

