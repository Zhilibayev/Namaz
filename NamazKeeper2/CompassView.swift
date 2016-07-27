//
//  CompassView.swift
//  NamazKeeper2
//
//  Created by Apple on 13.07.16.
//  Copyright © 2016 NU. All rights reserved.
//

    import UIKit
    import MapKit
    @IBDesignable class  CompassView: UIView,CLLocationManagerDelegate {
        var locationManager: CLLocationManager!
        var backgroundImageView:UIImageView!
        var foregroundImageView:UIImageView!
        
        override init(frame: CGRect) {
            super.init(frame: frame);
            self.commonInit()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            self.commonInit()
        }
        
        func commonInit()
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.startUpdatingHeading()
            self.clipsToBounds = true
            backgroundImageView = UIImageView(frame: frame)
            backgroundImageView.clipsToBounds = true
            backgroundImageView.contentMode = .ScaleAspectFit
            foregroundImageView = UIImageView(frame: frame)
            foregroundImageView.clipsToBounds = true
            backgroundImageView.contentMode = .ScaleAspectFit
            //Apply autolayout
            backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
            foregroundImageView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(backgroundImageView)
            self.addSubview(foregroundImageView)
            
            //backgroundImageView
            let constRAHB = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[backgroundImageView]-0-|", options: [], metrics: nil, views: ["backgroundImageView": backgroundImageView])
            self.addConstraints(constRAHB)
            let constRAWB = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[backgroundImageView]-0-|", options: [], metrics: nil, views: ["backgroundImageView": backgroundImageView])
            self.addConstraints(constRAWB)
            //foregroundImageView
            let constRAHF = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[foregroundImageView]-0-|", options: [], metrics: nil, views: ["foregroundImageView": foregroundImageView])
            self.addConstraints(constRAHF)
            let constRAWF = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[foregroundImageView]-0-|", options: [], metrics: nil, views: ["foregroundImageView": foregroundImageView])
            self.addConstraints(constRAWF)
            
            self.setNeedsUpdateConstraints()
        }
        
        @IBInspectable var backgroundImage: UIImage = UIImage() {
            didSet {
                backgroundImageView.image = backgroundImage
            }
        }
        @IBInspectable var foregroundImage: UIImage = UIImage() {
            didSet {
                foregroundImageView.image = foregroundImage
            }
        }
        
        func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
            print("New heading \(newHeading.magneticHeading)")
            self.rotateArrowView(self.foregroundImageView, degrees:newHeading.magneticHeading)
        }
        
        func rotateArrowView (view:UIView, degrees:Double)
        {
            let transform:CGAffineTransform = CGAffineTransformMakeRotation(CGFloat(DegreesToRadians(degrees)))
            view.transform = transform;
        }
        
        func DegreesToRadians (value:Double) -> Double {
            return value * M_PI / 180.0
        }
        
        func RadiansToDegrees (value:Double) -> Double {
            return value * 180.0 / M_PI
        }
    
}
