//
//  Note.swift
//  UnCloudNotes
//
//  Created by loi on 1/28/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Note : NSManagedObject
{
    @NSManaged var title : NSString
    @NSManaged var body : NSString
    @NSManaged var dateCreated: NSDate
    @NSManaged var displayIndex: NSNumber
    @NSManaged var image: UIImage?
    
    override func awakeFromInsert()
    {
        super.awakeFromInsert()
        dateCreated = NSDate()
    }
}
