//
//  Category.swift
//  Bubble Tea Finder
//
//  Created by loi on 1/27/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

import Foundation
import CoreData

class Category: NSManagedObject {

    @NSManaged var categoryID: String
    @NSManaged var name: String
    @NSManaged var venue: Venue

}
