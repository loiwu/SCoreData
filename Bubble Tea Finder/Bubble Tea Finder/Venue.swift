//
//  Venue.swift
//  Bubble Tea Finder
//
//  Created by loi on 1/27/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

import Foundation
import CoreData

class Venue: NSManagedObject {

    @NSManaged var favorite: NSNumber?
    @NSManaged var name: String?
    @NSManaged var phone: String?
    @NSManaged var specialCount: NSNumber?
    @NSManaged var category: Category
    @NSManaged var location: Location
    @NSManaged var priceInfo: PriceInfo
    @NSManaged var stats: Stats

}
