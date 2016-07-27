//
//  ViewController.swift
//  NamazKeeper2
//
//  Created by Apple on 04.07.16.
//  Copyright © 2016 NU. All rights reserved.
//

import UIKit
import SnapKit
import CoreLocation
import Kanna
import RealmSwift
import SwiftString
import ChameleonFramework
import Cartography

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate{
    
    //var mdelegate : Animator!
    var itemss: [String] = []
    var prayTimes: [PrayTimes] = []
    var year = 0
    var month = 0
    var day = 0
    var boo = true
    var format = NSDateFormatter()
    var format2 = NSDateFormatter()
    var dayF = NSDateFormatter()
    var monthF = NSDateFormatter()
    var currentLength = Int()
    var percent = Float()
    var drag = 0
    var cityId = 2
    var settings = Settings()
    var prayTimesInWords = PrayTimesInWords()
    var todayPrayTimes = NeededDays(tm: PrayTimes(), td: PrayTimes(), ys: PrayTimes())
    var todayPrayTimesInSeconds: [Int] = []
    var months = Months()
    var cities = Cities()
    var weekDays = Weeks()
    var leftSeconds = 0
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    var currentPrayTime: [Bool] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        let set = realm.objects(Settings)
        if (set.count == 0){
            try! realm.write({ 
                realm.add(settings)
            })
        }else{
            let set = realm.objects(Settings)
            let loadedSettings1 = set.first
            settings.isFirstTime = (loadedSettings1!.isFirstTime)
            settings.city = loadedSettings1!.city
            settings.language = loadedSettings1!.language
            settings.notification = loadedSettings1!.notification
            settings.sound = loadedSettings1!.sound
        }
        
        loadingIndicator.hidden = false
        loadingIndicator.startAnimating()
        
        tableView.rowHeight = 70
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        
        timeLabel.backgroundColor = UIColor.clearColor()
        timeLeftLabel.backgroundColor = UIColor( red: CGFloat(233/255.0), green: CGFloat(236/255.0), blue: CGFloat(229/255.0), alpha: CGFloat(1.0) )
        
        format.dateFormat = "HH:mm:ss"
        format2.dateFormat = "d-MM-yyyy"
        
        let swipeL = UISwipeGestureRecognizer(target: self, action: #selector(TabBarContoller.switchToDataTabCont(_:)))
        swipeL.direction = .Left
        
        let swipeR = UISwipeGestureRecognizer(target: self, action: #selector(TabBarContoller.switchToDataTabCont(_:)))
        swipeR.direction = .Right
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.updateClock), userInfo: nil, repeats: true)
        
        let datenow = NSDate()
        let islamic = NSCalendar(identifier: NSIslamicCivilCalendar)!
        let components = islamic.components(NSCalendarUnit(rawValue: UInt.max), fromDate: datenow)
        
        print("Date in system calendar:\(datenow), in Hijri:\(components.year)-\(components.month)-\(components.day)")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if settings.isFirstTime == true {
            print("First Time")
            downloadAll()
            getFromMemory()
        }else {
            print("Not FirstTime")
            getFromMemory()
        }
        
        let now = NSDate()
        
        dayF.dateFormat = "dd"
        monthF.dateFormat = "MM"
        
        let str = dayF.stringFromDate(now)
        let m = Int(monthF.stringFromDate(now))
        let cal: NSCalendar = NSCalendar.currentCalendar()
        let comp: NSDateComponents = cal.components(.Weekday, fromDate: now)
        let s = comp.weekday
        
        dayLabel.text = str
        monthLabel.text = months.months[m!].words[settings.language]
        cityLabel.text = cities.cities[settings.city-1].words[settings.language]
        weekDayLabel.text = weekDays.week[s - 1].words[settings.language]

    }
    
    /// Mark Work With Clock------------------------------------------------------------------------------------------------------------------
    
    func convertToSeconds(){//Convertion Times in terms of seconds to determine time intervals
        todayPrayTimesInSeconds = []
        let a = todayPrayTimes.yesterday.isha.split(":")[0].toInt()
        let b = todayPrayTimes.yesterday.isha.split(":")[1].toInt()
        drag = 24 * 60 * 60
        drag -= a! * 60 * 60 + b! * 60
        
        for i in 0...7{
            switch (i)
            {
            case 0:
                todayPrayTimesInSeconds.append(0)
            case 1:
                let st1 = todayPrayTimes.today.fajr.split(":")[0].toInt()
                let st2 = todayPrayTimes.today.fajr.split(":")[1].toInt()
                todayPrayTimesInSeconds.append(st1!*60*60+st2!*60+drag)
            case 2:
                let st1 = todayPrayTimes.today.sunrise.split(":")[0].toInt()
                let st2 = todayPrayTimes.today.sunrise.split(":")[1].toInt()
                todayPrayTimesInSeconds.append(st1!*60*60+st2!*60+drag)
            case 3:
                let st1 = todayPrayTimes.today.dhuhr.split(":")[0].toInt()
                let st2 = todayPrayTimes.today.dhuhr.split(":")[1].toInt()
                todayPrayTimesInSeconds.append(st1!*60*60+st2!*60+drag)
            case 4:
                let st1 = todayPrayTimes.today.asr.split(":")[0].toInt()
                let st2 = todayPrayTimes.today.asr.split(":")[1].toInt()
                todayPrayTimesInSeconds.append(st1!*60*60+st2!*60+drag)
            case 5:
                let st1 = todayPrayTimes.today.maghrib.split(":")[0].toInt()
                let st2 = todayPrayTimes.today.maghrib.split(":")[1].toInt()
                todayPrayTimesInSeconds.append(st1!*60*60+st2!*60+drag)
            case 6:
                let st1 = todayPrayTimes.today.isha.split(":")[0].toInt()
                let st2 = todayPrayTimes.today.isha.split(":")[1].toInt()
                todayPrayTimesInSeconds.append(st1!*60*60+st2!*60+drag)
            case 7:
                let st1 = todayPrayTimes.tomorrow.fajr.split(":")[0].toInt()
                let st2 = todayPrayTimes.tomorrow.fajr.split(":")[1].toInt()
                todayPrayTimesInSeconds.append((st1!+24)*60*60+st2!*60+drag)
            default:
                print("Out of range")
            }
            
        }
        print(todayPrayTimesInSeconds)
    }
    func updateClock() {// The function that should work at any second
        
        let now = NSDate()
        let str = format2.stringFromDate(now)

        if (str != todayPrayTimes.today.date){//Checks if the new day is Came with new time arragement
            todayPrayTimes = getCurrentPrayTimes()!
            convertToSeconds()
        }
        
        timeLabel.text = format.stringFromDate(now)
        let st1 = format.stringFromDate(now).split(":")[0].toInt()
        let st2 = format.stringFromDate(now).split(":")[1].toInt()
        let st3 = format.stringFromDate(now).substring(6, length: 2).toInt()
        let secondsNow = st1!*60*60+st2!*60 + st3! + drag
        for i in 0...6{
            let b = todayPrayTimesInSeconds[i]
            let e = todayPrayTimesInSeconds[i+1]
            let kk = i % 6
            if (b <= secondsNow && secondsNow < e){
                switch(kk){
                    case (0):
                        currentPrayTime[5] = true
                        percent = getIntervalRatio(b, end: e, now: secondsNow)

                    case (1):
                        currentPrayTime[0] = true
                        percent = getIntervalRatio(b, end: e, now: secondsNow)

                    case (2):
                        currentPrayTime[1] = true
                        percent = getIntervalRatio(b, end: e, now: secondsNow)

                    case (3):
                        currentPrayTime[2] = true
                        percent = getIntervalRatio(b, end: e, now: secondsNow)

                    case (4):
                        currentPrayTime[3] = true
                        percent = getIntervalRatio(b, end: e, now: secondsNow)

                    case (5):
                        currentPrayTime[4] = true
                        percent = getIntervalRatio(b, end: e, now: secondsNow)

                    default:
                        print("pff")
                }
            }else{
                switch(kk){
                    case (0):
                        currentPrayTime[5] = false
                    case (1):
                        currentPrayTime[0] = false
                    case (2):
                        currentPrayTime[1] = false
                    case (3):
                        currentPrayTime[2] = false
                    case (4):
                        currentPrayTime[3] = false
                    case (5):
                        currentPrayTime[4] = false
                    default:
                        print("pff")
                }
            }
        }
        
        let seconds = leftSeconds % 60
        let minutes = (leftSeconds / 60) % 60
        let hours = leftSeconds / 3600
        let strHours = hours > 9 ? String(hours) : "0" + String(hours)
        let strMinutes = minutes > 9 ? String(minutes) : "0" + String(minutes)
        let strSeconds = seconds > 9 ? String(seconds) : "0" + String(seconds)
        timeLeftLabel.text = "\(strHours):\(strMinutes):\(strSeconds)"
        tableView.reloadData()
    }
    
    func getIntervalRatio(begin: Int, end: Int, now: Int)->Float{
        let fullInterval = Float(end-begin)
        leftSeconds = end - now
        let currentInterval = Float(now-begin)
        return currentInterval/fullInterval
    }
    
    func getCurrentPrayTimes()->NeededDays?{//This function initialize the timeIndications and find todays time arrangement
        currentPrayTime = []
        let now = NSDate()
        let today = format2.stringFromDate(now)
        for _ in 0...5 {
            currentPrayTime.append(false)
        }
        let n = prayTimes.count - 1
        for i in 0...n{
            if (prayTimes[i].date == today) {
                print(prayTimes[i])
                return NeededDays(tm: prayTimes[i - 1],td: prayTimes[i], ys: prayTimes[i+1])
            }
        }
        return nil
    }

    //Mark Work With Realm------------------------------------------------------------------------------------------------------------------
    func deleteAllInMemory(){// Deletion all dates in memory
        let realm2 = try! Realm()
        try! realm2.write({
            realm2.deleteAll()
        })
    }
    
    func downloadAll(){//Download from internet all time arrangenmets in Almaty for a current year
        let update = UpdateForAllCities()
        let now = NSDate()
        update.lastModified = format2.stringFromDate(now)

        for i in 1...3{
            let myURLString = "http://old.muftyat.kz/kz/namaz/time?y=2016&city_id=\(i)"
            if let myURL = NSURL(string: myURLString) {
                var error: NSError?
                let myHTMLString = try! NSString(contentsOfURL: myURL, encoding: NSUTF8StringEncoding)
                if let error = error {print("Error : \(error)")} else {
                    update.citiesTimings.append(parseTheTimeTable(myHTMLString as String,index: i))
                }
            } else {print("Error: \(myURLString) doesn't  URL")}
        }
        
        let realm = try! Realm()
        try! realm.write({
            realm.add(update)
            realm.objects(Settings).first!.setValue(false, forKey: "isFirstTime")
        })
    }
    
    func getFromMemory(){//Get time arrangements in local memory
        
        let realm = try! Realm()
        let t = realm.objects(UpdateForAllCities)
        let k = Cities()
        
        prayTimes  = []
        
        let set = realm.objects(Settings)
        let loadedSettings = set.first
        try! realm.write({ 
            settings.isFirstTime = (loadedSettings!.isFirstTime.boolValue)
            settings.city = loadedSettings!.city
            settings.language = loadedSettings!.language
            settings.notification = loadedSettings!.notification.boolValue
            settings.sound = loadedSettings!.sound
        })
        
        for item in t{
            for jtem in item.citiesTimings{
                if (settings.city == jtem.cityId){
                    print("\(k.cities[jtem.cityId - 1])")
                    for ktem in jtem.timingsForAYear{
                        prayTimes.append(ktem)
                    }
                }
            }
        }
        
        todayPrayTimes = getCurrentPrayTimes()!
        convertToSeconds()
    }
    
    func parseTheTimeTable(html: String, index: Int)->UpdateByCity{//cunstructing all time arrangements in one object PrayTimes()
        let update = UpdateByCity()
        update.cityId = index
        if let doc = Kanna.HTML(html: html, encoding: NSUTF8StringEncoding) {
            var k = 0
            let pr = PrayTimes()
            for link in doc.css("td") {
                let data = link.content!
                if k == 1 {pr.day = data}
                if k == 2 {pr.fajr = data}
                if k == 3 {pr.sunrise = data}
                if k == 4 {pr.dhuhr = data}
                if k == 5 {pr.asr = data}
                if k == 6 {pr.maghrib = data}
                if k == 7 {pr.isha = data}
                if k == 8 {
                    let newPr = PrayTimes()
                    newPr.day = pr.day
                    newPr.date = pr.date
                    newPr.fajr = pr.fajr
                    newPr.sunrise = pr.sunrise
                    newPr.dhuhr = pr.dhuhr
                    newPr.asr = pr.asr
                    newPr.maghrib = pr.maghrib
                    newPr.isha = pr.isha
                    update.timingsForAYear.append(newPr)
                    prayTimes.append(newPr)
                }
                if (data.characters.contains("-")){
                    k = 0
                    pr.date = data
                }
                k+=1
            }
        }
        return update
    }
    ///Work With TableView------------------------------------------------------------------------------------------------------------------
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentPrayTime.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (self.view.frame.height - 176-40)/6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ProgressViewCell
        
        if currentPrayTime[indexPath.row] {
            loadingIndicator.hidden = true
            loadingIndicator.stopAnimating()
            cell.setLen(CGFloat(percent))
        }else{
            cell.makeZeroLength()
        }
        switch (indexPath.row)
        {
            case 0:
                let comp = UIImage(named: "1")
                UIGraphicsBeginImageContext(CGSizeMake(120, 120))
                comp!.drawInRect(CGRectMake(0, 0, 120, 120))
                let newImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                cell.imageOfTime.image = newImage
                cell.time.text = todayPrayTimes.today.fajr
                cell.name.text = prayTimesInWords.prayTimesInWords[0].words[settings.language]
            
            case 1:
                
                let comp = UIImage(named: "2")
                UIGraphicsBeginImageContext(CGSizeMake(120, 120))
                comp!.drawInRect(CGRectMake(0, 0, 120, 120))
                let newImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                cell.imageOfTime.image = newImage
                cell.time.text = todayPrayTimes.today.sunrise
                cell.name.text = prayTimesInWords.prayTimesInWords[1].words[settings.language]

            case 2:
                
                let comp = UIImage(named: "3")
                UIGraphicsBeginImageContext(CGSizeMake(120, 120))
                comp!.drawInRect(CGRectMake(0, 0, 120, 120))
                let newImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                cell.imageOfTime.image = newImage
                cell.time.text = todayPrayTimes.today.dhuhr
                cell.name.text = prayTimesInWords.prayTimesInWords[2].words[settings.language]

            case 3:
                
                let comp = UIImage(named: "4")
                UIGraphicsBeginImageContext(CGSizeMake(120, 120))
                comp!.drawInRect(CGRectMake(0, 0, 120, 120))
                let newImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                cell.imageOfTime.image = newImage
                cell.time.text = todayPrayTimes.today.asr
                cell.name.text = prayTimesInWords.prayTimesInWords[3].words[settings.language]

            case 4:
                let comp = UIImage(named: "5")
                UIGraphicsBeginImageContext(CGSizeMake(120, 120))
                comp!.drawInRect(CGRectMake(0, 0, 120, 120))
                let newImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                cell.imageOfTime.image = newImage
                cell.time.text = todayPrayTimes.today.maghrib
                cell.name.text = prayTimesInWords.prayTimesInWords[4].words[settings.language]

            case 5:
                let comp = UIImage(named: "6")
                UIGraphicsBeginImageContext(CGSizeMake(120, 120))
                comp!.drawInRect(CGRectMake(0, 0, 120, 120))
                let newImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                cell.imageOfTime.image = newImage
                cell.time.text = todayPrayTimes.today.isha
                cell.name.text = prayTimesInWords.prayTimesInWords[5].words[settings.language]
            
            default:
                print("Integer out of range")
        }
        return cell
    }
    
}

