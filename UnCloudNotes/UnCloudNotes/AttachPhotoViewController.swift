//
//  AttachPhotoViewController.swift
//  UnCloudNotes
//
//  Created by loi on 1/28/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

import UIKit

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
}
