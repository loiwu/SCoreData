//
//  NoteDetailViewController.swift
//  UnCloudNotes
//
//  Created by loi on 1/28/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController
{
    var note : Note? {
        didSet {
            updateNoteInfo()
        }
    }
    
    @IBOutlet var titleField : UILabel!
    @IBOutlet var bodyField : UITextView!
    
    func updateNoteInfo() {
        if note != nil && isViewLoaded()
        {
            titleField.text = note!.title
            bodyField.text = note!.body
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        updateNoteInfo()
    }
    
}

