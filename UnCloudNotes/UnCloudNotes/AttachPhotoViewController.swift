//
//  AttachPhotoViewController.swift
//  UnCloudNotes
//
//  Created by loi on 1/28/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

import UIKit
import CoreData

class AttachPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var note : Note?
    
    lazy var imagePicker : UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.sourceType = .PhotoLibrary
        picker.delegate = self
        self.addChildViewController(picker)
        return picker
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imagePicker.view)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imagePicker.view.frame = view.bounds
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: NSDictionary) {
        if let note = note {
            let attachment = NSEntityDescription.insertNewObjectForEntityForName("Attachment", inManagedObjectContext: note.managedObjectContext!) as Attachment
            attachment.dateCreated = NSDate()
            attachment.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            attachment.note = note
        }
        navigationController?.popViewControllerAnimated(true)
    }
}
