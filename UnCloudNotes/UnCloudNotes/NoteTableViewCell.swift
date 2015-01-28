//
//  NoteTableViewCell.swift
//  UnCloudNotes
//
//  Created by loi on 1/28/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

import UIKit


class NoteTableViewCell: UITableViewCell
{
    var note : Note?
        {
        didSet
        {
            updateNoteInfo()
        }
    }
    @IBOutlet var noteTitle : UILabel!
    @IBOutlet var noteCreateDate : UILabel!
    @IBOutlet var noteImage: UIImageView!
    
    func updateNoteInfo()
    {
        if note != nil
        {
            noteTitle.text = note!.title
            noteCreateDate.text = note!.dateCreated.description
        }
    }
    
}
