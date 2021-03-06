//
//  NotesListViewController.swift
//  UnCloudNotes
//
//  Created by loi on 1/28/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

import UIKit
import CoreData

//@objc (NotesListViewController)
class NotesListViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    lazy var stack : CoreDataStack = CoreDataStack(modelName:"UnCloudNotesDataModel", storeName:"UnCloudNotes", options:[NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: false])
    
    var _notes : NSFetchedResultsController? = nil
    var notes : NSFetchedResultsController {
        if _notes == nil {
            let request = NSFetchRequest(entityName: "Note")
            request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
            
            let notes = NSFetchedResultsController(fetchRequest: request, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
            notes.delegate = self
            _notes = notes
        }
        return _notes!
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        notes.performFetch(nil)
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var objects = notes.fetchedObjects
        if let objects = objects
        {
            return objects.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let note = notes.fetchedObjects![indexPath.row] as Note
        var identifier = "NoteCell"
        if note.image != nil {
            identifier = "NoteCellImage"
        }
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as NoteTableViewCell;
        cell.note = notes.fetchedObjects![indexPath.row] as? Note

        return cell
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        
    }
    
    func controller(controller: NSFetchedResultsController!, didChangeObject anObject: AnyObject!, atIndexPath indexPath: NSIndexPath!, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath!) {
        switch type
        {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController!) {
        
    }
    
    @IBAction
    func unwindToNotesList(segue:UIStoryboardSegue) {
        NSLog("Unwinding to Notes List")
        var error : NSErrorPointer = nil
        if stack.context.hasChanges
        {
            if stack.context.save(error) == false
            {
                print("Error saving \(error)")
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "createNote"
        {
            let context = NSManagedObjectContext(concurrencyType: .ConfinementConcurrencyType)
            context.parentContext = stack.context
            let navController = segue.destinationViewController as UINavigationController
            let nextViewController = navController.topViewController as CreateNoteViewController
            nextViewController.managedObjectContext = context
        }
        if segue.identifier == "showNoteDetail" {
            let detailView = segue.destinationViewController as NoteDetailViewController
            if let selectedIndex = tableView.indexPathForSelectedRow() {
                if let objects = notes.fetchedObjects {
                    detailView.note = objects[selectedIndex.row] as? Note
                }
            }
        }
    }
}

