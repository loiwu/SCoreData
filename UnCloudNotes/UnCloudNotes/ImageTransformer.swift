//
//  ImageTransformer.swift
//  UnCloudNotes
//
//  Created by loi on 1/28/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

import Foundation
import UIKit

class ImageTransformer : NSValueTransformer {
    
    override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return  true
    }
    
    override func reverseTransformedValue(value: AnyObject?) -> AnyObject? {
        if (value == nil) {
            return nil
        }
        
        return UIImage(data: value as NSData)
    }
    
    override func transformedValue(value: AnyObject?) -> AnyObject? {
        return UIImagePNGRepresentation(value as? UIImage)
    }
    
}
