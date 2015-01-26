//
//  CoreDataStack.swift
//  Dog Walk
//
//  Created by loi on 1/26/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

import CoreData

class CoreDataStack {
    let context:NSManagedObjectContext
    let psc:NSPersistentStoreCoordinator
    let model:NSManagedObjectModel
    let store:NSPersistentStore?
    
    init() {
        // 1 - load the managed object model from disk into a NSManagedObjectModel object. 
        // getting a URL to the momd directory that contains the compiled version of the .xcdatamodeld file.
        let bundle = NSBundle.mainBundle()
        let modelURL = bundle.URLForResource("Dog Walk", withExtension: "momd")
        model = NSManagedObjectModel(contentsOfURL: modelURL!)!
        
        // 2 - the persistent store coordinator mediates between the persistent store and NSManagedObjectModel
        psc = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        // 3 - The NSManagedObjectContext takes no arguments to initialize.
        context = NSManagedObjectContext()
        context.persistentStoreCoordinator = psc
        
        // 4 -  the persistent store coordinator hands you an NSPersistentStore object as a side effect of attaching a persistent store type. 
        // simply have to specify the store type (NSSQLiteStoreType in this case), the URL location of the store file and some configuration options.
        let documentURL = applicationDocumentsDirectory()
        let storeURL = documentURL.URLByAppendingPathComponent("Dog Walk")
        
        let options = [NSMigratePersistentStoresAutomaticallyOption: true]
        
        var error: NSError? = nil
        store = psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: options, error: &error)
        
        if store == nil {
            println("Error adding persistent store: \(error)")
            abort()
        }
    }
    
    func applicationDocumentsDirectory() -> NSURL {
        let fileManager = NSFileManager.defaultManager()
        
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) as [NSURL]
        
        return urls[0]
    }
}
