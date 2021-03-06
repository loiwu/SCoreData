//
//  CreateNoteViewController.swift
//  UnCloudNotes
//
//  Created by loi on 1/28/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

import UIKit
import CoreData

class CreateNoteViewController : UIViewController, UITextFieldDelegate, UITextViewDelegate
{
    var managedObjectContext : NSManagedObjectContext?
    var _note : Note?
    var note : Note
        {
            if _note == nil
            {
                _note = NSEntityDescription.insertNewObjectForEntityForName("Note", inManagedObjectContext: self.managedObjectContext!) as? Note
            }
            return _note!
    }
    
    @IBOutlet var titleField : UITextField!
    @IBOutlet var bodyField : UITextView!
    @IBOutlet var attachPhotoButton : UIButton!
    @IBOutlet var attachedPhoto : UIImageView!
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        if let image = _note?.image {
            attachedPhoto.image = image
            view.endEditing(true)
        } else {
            titleField.becomeFirstResponder()
        }
    }
    
    @IBAction func saveNote()
    {
        note.title = titleField.text
        note.body = bodyField.text
        var error : NSErrorPointer = nil
        if managedObjectContext!.save(error) == false
        {
            print("Error saving \(error)")
        }
        performSegueWithIdentifier("unwindToNotesList", sender: self)
    }
    
    func textFieldShouldReturn(textField:UITextField) -> Bool
    {
        saveNote()
        textField.resignFirstResponder()
        return false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "AttachPhoto" {
            let nextViewController : AttachPhotoViewController = segue.destinationViewController as AttachPhotoViewController
            nextViewController.note = note
        }
    }
}
