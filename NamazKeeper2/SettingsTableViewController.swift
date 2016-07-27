//
//  SettingsTableViewController.swift
//  NamazKeeper2
//
//  Created by Apple on 09.07.16.
//  Copyright © 2016 NU. All rights reserved.
//

import UIKit
import RealmSwift
class SettingsTableViewController: UITableViewController {
    
    let cities = Cities()
    var settings = Settings()
    //var mdelegate: Animator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        let set = realm.objects(Settings)
        settings.city = set.first!.city
        settings.language = set.first!.language
        settings.sound = set.first!.sound
        settings.notification = set.first!.notification
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        //mdelegate.animateTheChange(1)
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 0 && indexPath.row == 0){
            performSegueWithIdentifier("Cities", sender: nil)
        }else if (indexPath.row == 1 && indexPath.section == 0){
            performSegueWithIdentifier("Languages", sender: nil)
        }else if (indexPath.section == 1 && indexPath.row == 1){
            performSegueWithIdentifier("Sounds", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "Languages"){
            let DVC = segue.destinationViewController as! SelectTableViewController
            DVC.option = 1
        }
        if (segue.identifier == "Cities"){
            let DVC = segue.destinationViewController as! SelectTableViewController
            DVC.option = 0
        }
        if (segue.identifier == "Sounds"){
            let DVC = segue.destinationViewController as! SelectTableViewController
            DVC.option = 2
        }

    }
}
