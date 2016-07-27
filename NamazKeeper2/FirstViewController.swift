//
//  FirstViewController.swift
//  NamazKeeper2
//
//  Created by Apple on 22.07.16.
//  Copyright © 2016 NU. All rights reserved.
//

import UIKit
import Cartography
import ChameleonFramework
import Cheetah
protocol Animator {
    func animateTheChange(Idx: Int)

}
class FirstViewController: UIViewController, Animator, UIGestureRecognizerDelegate{
    var tabs = UIView()
    var b1 = UIButton()
    var b2 = UIButton()
    var b3 = UIButton()
    var line = UIView()
    var t1 = UIImageView()
    var t2 = UIImageView()
    var t3 = UIImageView()
    @IBOutlet weak var containerView: UIView!
    
    override func shouldAutorotate() -> Bool {
        
        return false
        
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.addSubview(line)
        line.layer.zPosition = 101
        constrain(line) { (view) in
            view.width == view.superview!.width/3
            view.height == 2
            view.bottom == view.superview!.bottom - 43
            view.left == view.superview!.left
        }
        
        line.backgroundColor = UIColor( red: CGFloat(192/255.0), green: CGFloat(223/255.0), blue: CGFloat(217/255.0), alpha: CGFloat(1.0))
        
        view.addSubview(tabs)
        
        tabs.layer.zPosition = 99
        tabs.backgroundColor = UIColor.whiteColor()
        constrain(tabs) { (view) in
            view.width == view.superview!.width
            view.height == 45
            view.bottom == view.superview!.bottom
            view.left == view.superview!.left
        }
        
        var line2 = UIView()
        
        view.addSubview(line2)
        constrain(line2) { (view) in
            view.width == view.superview!.width
            view.height == 0.5
            view.bottom == view.superview!.bottom - 45
            view.left == view.superview!.left
        }
        
        line2.backgroundColor = FlatGray()
        line2.layer.zPosition = 100
        line2.layer.opacity = 0.5
        tabs.addSubview(b1)
        tabs.addSubview(b2)
        tabs.addSubview(b3)
        
        constrain(b1) { (view) in
            view.top == view.superview!.top
            view.width == view.superview!.width / 3
            view.left == view.superview!.left
            view.height == 45
        }
        
        constrain(b2) { (view) in
            view.width == view.superview!.width / 3
            view.center == view.superview!.center
            view.height == 45
        }
        
        constrain(b3) { (view) in
            view.top == view.superview!.top
            view.width == view.superview!.width / 3
            view.right == view.superview!.right
            view.height == 45
        }
        
        
        
        b1.addSubview(t1)
        
        constrain(t1) { (view) in
            view.width == 30
            view.center == view.superview!.center
            view.height == 30
        }
        
        let comp = UIImage(named: "itemclock")
        UIGraphicsBeginImageContext(CGSizeMake(90, 90))
        comp!.drawInRect(CGRectMake(0, 0, 90, 90))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        t1.image = newImage
        
        b2.addSubview(t2)
        
        constrain(t2) { (view) in
            view.width == 30
            view.center == view.superview!.center
            view.height == 30
        }
        let comp2 = UIImage(named: "itemcompass")
        UIGraphicsBeginImageContext(CGSizeMake(90, 90))
        comp2!.drawInRect(CGRectMake(0, 0, 90, 90))
        let newImage2 = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        t2.image = newImage2

        b3.addSubview(t3)
        
        constrain(t3) { (view) in
            view.width == 30
            view.center == view.superview!.center
            view.height == 30
        }
        let comp3 = UIImage(named: "itemsettings")
        UIGraphicsBeginImageContext(CGSizeMake(90, 90))
        comp3!.drawInRect(CGRectMake(0, 0, 90, 90))
        let newImage3 = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        t3.image = newImage3
        
        b1.userInteractionEnabled = true
        b2.userInteractionEnabled = true
        b3.userInteractionEnabled = true
    }
    
    func animateTheChange(idx: Int) {
        
        line.cheetah.position(CGFloat(idx)*view.frame.width/3+line.frame.width/2, view.frame.height - 46).duration(0.3).easeInCirc.run()
    }
    
    func animateTheChange1(sender: UITapGestureRecognizer) {
        line.cheetah.position(CGFloat(0)*view.frame.width/3+line.frame.width/2, view.frame.height - 46).duration(0.3).easeInCirc.run()
    }
    
    func animateTheChange2(sender: UITapGestureRecognizer) {
        line.cheetah.position(CGFloat(1)*view.frame.width/3+line.frame.width/2, view.frame.height - 46).duration(0.3).easeInCirc.run()
    }
    
    func animateTheChange3(sender: UITapGestureRecognizer) {
        line.cheetah.position(CGFloat(2)*view.frame.width/3+line.frame.width/2, view.frame.height - 46).duration(0.3).easeInCirc.run()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if let VC1 = segue.destinationViewController as? PageViewController{
            VC1.mdelegate = self
        }
    }
}
