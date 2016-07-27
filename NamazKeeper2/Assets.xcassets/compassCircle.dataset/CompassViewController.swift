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

func DegreesToRadians (value:Double) -> Double {
    return value * M_PI / 180.0
}

func RadiansToDegrees (value:Double) -> Double {
    return value * 180.0 / M_PI
}

class CompassViewController: UIViewController, CLLocationManagerDelegate {
    var circleView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        circleView.layer.zPosition = -1
        circleView.frame = CGRectMake(0, 0, 216, 216)
        circleView.backgroundColor = UIImage(named: "")
        view.addSubview(circleView)
    }
    
    
    
}
