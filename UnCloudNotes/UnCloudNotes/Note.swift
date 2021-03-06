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
    @NSManaged var attachments: NSSet
    
    override func awakeFromInsert()
    {
        super.awakeFromInsert()
        dateCreated = NSDate()
    }
    
    var image : UIImage? {
        if let image = self.latestAttachment()?.image {
        return image }
        return nil
    }
    
    func latestAttachment() -> ImageAttachment? {
        var attachmentsToSort = attachments.allObjects as [ImageAttachment]
        if attachmentsToSort.count == 0 {
            return nil
        }
        attachmentsToSort.sort {
            let date1 = $0.dateCreated.timeIntervalSinceReferenceDate
            let date2 = $1.dateCreated.timeIntervalSinceReferenceDate
            return date1 > date2
        }
        return attachmentsToSort[0]
    }
}
