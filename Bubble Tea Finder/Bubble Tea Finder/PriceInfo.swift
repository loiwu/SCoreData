//
//  PriceInfo.swift
//  Bubble Tea Finder
//
//  Created by loi on 1/27/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

import Foundation
import CoreData

class PriceInfo: NSManagedObject {

    @NSManaged var priceCategory: String?
    @NSManaged var venue: Venue

}
