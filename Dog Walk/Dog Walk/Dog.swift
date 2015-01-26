//
//  Dog.swift
//  Dog Walk
//
//  Created by loi on 1/26/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

import Foundation
import CoreData

class Dog: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var walks: NSOrderedSet

}
