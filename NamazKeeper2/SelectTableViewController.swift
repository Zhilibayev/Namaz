//
//  SelectTableViewController.swift
//  NamazKeeper2
//
//  Created by Apple on 11.07.16.
//  Copyright © 2016 NU. All rights reserved.
//

import UIKit
import RealmSwift
class SelectTableViewController: UITableViewController {

    var cities = Cities()
    var languages = Languages()
    var sounds = Sounds()
    var option = 0
    var settings = Settings()
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        let sets = realm.objects(Settings)
        settings.city = sets.first!.city
        settings.language = sets.first!.language
        settings.notification = sets.first!.notification
        settings.sound = sets.first!.sound
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var k = 0
        if (option == 0){
            k = cities.cities.count
        }else if (option == 1){
            k = languages.lans.count
        }else if (option == 2 ){
            k = sounds.sound.count
        }
        return k
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        if (option == 0){
            cell.textLabel?.text = cities.cities[indexPath.row].words[settings.language]
        }else if (option == 1){
            cell.textLabel?.text = languages.lans[indexPath.row]
        }else if (option == 2){
            cell.textLabel?.text = sounds.sound[indexPath.row]
        }
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if option == 0 {
            let realm = try! Realm()
            let sets = realm.objects(Settings)
            try! realm.write({
            sets.first?.setValue(indexPath.row + 1, forKey: "city")
            })
            
        }else if option == 1 {
            let realm = try! Realm()
            let sets = realm.objects(Settings)
            try! realm.write({
            sets.first?.setValue(indexPath.row, forKey: "language")
            })
        }else if option == 2 {
            let realm = try! Realm()
            let sets = realm.objects(Settings)
            try! realm.write({
            sets.first?.setValue(indexPath.row, forKey: "sound")
            })
        }
        
        let realm = try! Realm()
        let sets = realm.objects(Settings)
        settings.city = sets.first!.city
        settings.language = sets.first!.language
        settings.notification = sets.first!.notification
        settings.sound = sets.first!.sound
        navigationController?.popViewControllerAnimated(true)

        //tableView.reloadData()
    }
}
