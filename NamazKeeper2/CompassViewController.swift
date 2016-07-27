//
//  CompassViewController.swift
//  NamazKeeper2
//
//  Created by Apple on 12.07.16.
//  Copyright © 2016 NU. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Cartography
import ChameleonFramework
func DegreesToRadians (value:Double) -> Double {
    return value * M_PI / 180.0
}

func RadiansToDegrees (value:Double) -> Double {
    return value * 180.0 / M_PI
}

extension UIView {
    func rotateToDegrees(duration: CFTimeInterval = 1.0, degree: Double, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(M_PI * 2.0)
        rotateAnimation.duration = duration
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate
        }
        self.layer.addAnimation(rotateAnimation, forKey: nil)
    }
}

class CompassViewController: UIViewController, CLLocationManagerDelegate {
    //var mdelegate : Animator!
    var circleView = UIView()
    var arrow = UIImageView()
    var container = UIView()
    var container2 = UIView()
    var mec = UIImageView()
    var comp = CompassView()
    var locationManager = CLLocationManager()
    var boo = true
    var clat  = 0.0
    var clon = 0.0
    var mlat = 21.422774
    var mlon = 39.826100
    let dToR = M_PI/180
    let rToD = 180/M_PI
    var d = 0.0
    var kaaba = UIImageView()
    var qibla = UIView()
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingHeading()
        locationManager.startMonitoringSignificantLocationChanges()
        
        container.frame = CGRect(x: view.frame.width/2 - 165, y: view.frame.height/2 - 165, width: 330, height: 330)
        
        
        arrow.frame = CGRect(x: 0, y: 0, width:330, height: 330)
        let comp = UIImage(named: "compass")
        UIGraphicsBeginImageContext(CGSizeMake(1360, 1360))
        comp!.drawInRect(CGRectMake(0, 0, 1360, 1360))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        arrow.image = newImage
        
        view.addSubview(container)
        container.addSubview(arrow)
        view.addSubview(kaaba)
        kaaba.layer.zPosition = 100
        constrain(kaaba) { (view) in
            view.height == 60
            view.width == 60
            view.center == view.superview!.center
        }
        let comp2 = UIImage(named: "kaaaba")
        UIGraphicsBeginImageContext(CGSizeMake(260, 260))
        comp2!.drawInRect(CGRectMake(0, 0, 260, 260))
        let newImage2 = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        kaaba.image = newImage2
    }
    
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.container.transform = CGAffineTransformMakeRotation(CGFloat(fabs((newHeading.trueHeading - 360) * M_PI/180)));
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        clat = locValue.latitude * dToR
        clon = locValue.longitude * dToR
        mlon = mlon * dToR
        mlat = mlat * dToR
        
        let dlon = mlon - clon
        let y = sin(dlon) * cos(mlat)
        let x = cos(clat) * sin(mlat) - sin(clat) * cos(mlat)*cos(dlon)
        var direction = atan2(y, x)
        
        direction = direction * rToD
        print("The direction is ")
        
        let fraction = modf(direction + 360.0, ipart: direction)
        direction = direction + fraction
        if (direction > 360)
        {
            direction -= 360;
        }
        
        if (direction > 0){
            d = direction
        }else{
            d = 360 + direction
            
        }
        arrow.addSubview(container2)
        constrain(container2) { (view) in
            view.height == 330
            view.width == 330
            view.top == view.superview!.top
            view.left == view.superview!.left
        }
        
        container2.addSubview(mec)
        constrain(mec) { (view) in
            view.height == 40
            view.width == 40
            view.centerX == view.superview!.centerX
            view.top == view.superview!.top
        }
        let comp = UIImage(named: "Ar")
        UIGraphicsBeginImageContext(CGSizeMake(260, 260))
        comp!.drawInRect(CGRectMake(0, 0, 260, 260))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        mec.image = newImage
        if (boo){
        container2.transform = CGAffineTransformMakeRotation(CGFloat(fabs(d)*M_PI/180))
        }
        boo = false
    }
    func modf(orig: Double, ipart: Double) -> Double{
        return orig - (floor(orig))
    }
}
