//
//  MapViewController.swift
//  NamazKeeper2
//
//  Created by Apple on 05.07.16.
//  Copyright © 2016 NU. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation



class MapViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let location  = CLLocationCoordinate2DMake(43.2551, 76.9126)
        let span = MKCoordinateSpan(latitudeDelta: 0.01,longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location//setCoordinate(location)
        annotation.title = "Almaty"
        annotation.subtitle = "Namazhanalar Kaida?"
        map.addAnnotation(annotation)
    }
    
}
