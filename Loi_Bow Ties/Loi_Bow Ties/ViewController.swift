//
//  ViewController.swift
//  Loi_Bow Ties
//
//  Created by loi on 1/16/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var timesWornLabel: UILabel!
    @IBOutlet weak var lastWornLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    var managedContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func segmentedControl(control: UISegmentedControl) {
        
    }
    
    @IBAction func wear(sender: AnyObject) {
    }
    
    @IBAction func rate(sender: AnyObject) {
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertSampleData() {
        let fetchRequest = NSFetchRequest(entityName: "Bowtie")
        fetchRequest.predicate = NSPredicate(format: "serach != nil")
        let count = managedContext.countForFetchRequest(fetchRequest, error: nil)
        if count > 0 { return }
        let path = NSBundle.mainBundle().pathForResource("SampleData", ofType: "plist")
        let dataArray = NSArray(contentsOfFile: path!)!
        for dict : AnyObject in dataArray {
            
            let entity = NSEntityDescription.entityForName("Bowtie", inManagedObjectContext: managedContext)
            
            let bowtie = Bowtie(entity: entity!, insertIntoManagedObjectContext: managedContext)
            
            let btDict = dict as NSDictionary
            
            bowtie.name = btDict["name"] as NSString
            bowtie.searchKey = btDict["searchKey"] as NSString
            bowtie.rating = btDict["rating"] as NSNumber
            let tintColorDict = btDict["tintColor"] as NSDictionary
            bowtie.tintColor = colorFromDict(tintColorDict)
            
            let imageName = btDict["imageName"] as NSString
            let image = UIImage(named: imageName)
            let photoData = UIImagePNGRepresentation(image)
            bowtie.photoData = photoData
            
            bowtie.lastWorn = btDict["lastWorn"] as NSDate
            bowtie.timesWorn = btDict["timesWorn"] as NSNumber
            bowtie.isFavorite = btDict["isFavorite"] as NSNumber
        }
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error!.userInfo)")
        }
    }
    
    func colorFromDict(dict: NSDictionary) -> UIColor {
        let red = dict["red"] as NSNumber
        let green = dict["green"] as NSNumber
        let blue = dict["blue"] as NSNumber
        let color = UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1)
        return color
    }


}

