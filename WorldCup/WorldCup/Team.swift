//
//  Team.swift
//  WorldCup
//
//  Created by loi on 1/28/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

import Foundation
import CoreData

class Team: NSManagedObject {

    @NSManaged var wins: NSNumber
    @NSManaged var teamName: String
    @NSManaged var qualifyingZone: String
    @NSManaged var losses: NSNumber
    @NSManaged var imageName: String

}
