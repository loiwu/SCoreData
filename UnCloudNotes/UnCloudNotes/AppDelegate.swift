//
//  AppDelegate.swift
//  UnCloudNotes
//
//  Created by loi on 1/28/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        // Override point for customization after application launch.
        if let splitController = window?.rootViewController as? UISplitViewController {
            splitController.delegate = self
        }
        return true
    }
    
    func splitViewController(splitViewController: UISplitViewController!, collapseSecondaryViewController secondaryViewController:UIViewController!, ontoPrimaryViewController primaryViewController:UIViewController!) -> Bool {
        if let secondaryAsNoteDetail = secondaryViewController as? NoteDetailViewController {
            if secondaryAsNoteDetail.note == nil {
                // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
                return true
            }
        }
        return false
    }
    
}

