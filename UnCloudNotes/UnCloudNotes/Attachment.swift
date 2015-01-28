//
//  Attachment.swift
//  UnCloudNotes
//
//  Created by Loi Wu on 1/29/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Attachment: NSManagedObject {
    @NSManaged var dateCreated: NSDate
    @NSManaged var image: UIImage?
    @NSManaged var note: Note
}
