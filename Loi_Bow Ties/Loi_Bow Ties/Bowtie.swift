//
//  Bowtie.swift
//  Loi_Bow Ties
//
//  Created by loi on 1/19/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

import Foundation
import CoreData

class Bowtie: NSManagedObject {

    @NSManaged var isFavorite: NSNumber
    @NSManaged var lastWorn: NSDate
    @NSManaged var name: String
    @NSManaged var photoData: NSData
    @NSManaged var rating: NSNumber
    @NSManaged var searchKey: String
    @NSManaged var timesWorn: NSNumber
    @NSManaged var tintColor: AnyObject

}
