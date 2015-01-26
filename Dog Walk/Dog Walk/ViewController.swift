//
//  ViewController.swift
//  Dog Walk
//
//  Created by Loi Wu on 1/25/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var walks:Array<NSDate> = []
    var managedContext: NSManagedObjectContext!
    var currentDog: Dog!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        //Insert Dog entity
        
        let dogEntity = NSEntityDescription.entityForName("Dog", inManagedObjectContext: managedContext)
        
        let dog = Dog(entity: dogEntity!, insertIntoManagedObjectContext: managedContext)
        
        let dogName = "Ruby"
        let dogFetch = NSFetchRequest(entityName: "Dog")
        dogFetch.predicate = NSPredicate(format: "name == %@", dogName)
        
        var error: NSError?
        
        let result = managedContext.executeFetchRequest(dogFetch, error: &error) as [Dog]?
        
        if let dogs = result {
            if dogs.count == 0 {
                currentDog = Dog(entity: dogEntity!, insertIntoManagedObjectContext: managedContext)
                currentDog.name = dogName
                
                if !managedContext.save(&error) {
                    println("Could not save: \(error)")
                }
            } else {
                currentDog = dogs[0]
            }
        } else {
            println("Could not fetch: \(error)")
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numRows = 0
        
        if let dog = currentDog? {
            numRows = dog.walks.count
        }
        
        return numRows
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "List of Walks"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .MediumStyle
        
        let walk = currentDog.walks[indexPath.row] as Walk
//        let date = walks[indexPath.row]
        cell.textLabel?.text = dateFormatter.stringFromDate(walk.date)
//        cell.textLabel?.text = dateFormatter.stringFromDate(date)
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func add(sender: AnyObject) {
        
        //Insert new Walk entity into Core Data
        let walkEntity = NSEntityDescription.entityForName("Walk", inManagedObjectContext: managedContext)
        
        let walk = Walk(entity: walkEntity!, insertIntoManagedObjectContext: managedContext)
        
        walk.date = NSDate()
        
        //Insert the new Walk into the Dog's walks set
        var walks = currentDog.walks.mutableCopy() as NSMutableOrderedSet
        
        walks.addObject(walk)
        
        currentDog.walks = walks.copy() as NSOrderedSet
        
        //Save the managed object context
        var error: NSError?
        
        if !managedContext!.save(&error) {
            println("Could not save: \(error)")
        }
        
//        walks.append(NSDate())
        tableView.reloadData()
    }
    

}

