//
//  TeamCell.swift
//  WorldCup
//
//  Created by loi on 1/28/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

import UIKit

class TeamCell: UITableViewCell {

    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!

    @IBOutlet weak var flagImageView: UIImageView!
    
    @IBAction func addWin(sender: AnyObject) {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        teamLabel.text = nil
        scoreLabel.text = nil
        flagImageView.image = nil
    }
}
