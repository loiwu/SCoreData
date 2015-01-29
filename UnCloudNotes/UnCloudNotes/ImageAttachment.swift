//
//  ImageAttachment.swift
//  UnCloudNotes
//
//  Created by loi on 1/29/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

import UIKit
import CoreData

class ImageAttachment: Attachment {
    @NSManaged var image: UIImage?
    @NSManaged var width: CGFloat
    @NSManaged var height :CGFloat
    @NSManaged var caption: NSString
}
