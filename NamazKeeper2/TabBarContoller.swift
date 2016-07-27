//
//  TabBarContoller.swift
//  NamazKeeper2
//
//  Created by Apple on 14.07.16.
//  Copyright © 2016 NU. All rights reserved.
//

import UIKit

class TabBarContoller: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = 0
        delegate = self
    }
    
    func switchToDataTabCont(sender: UISwipeGestureRecognizer){
        print("Hey")
    }

}
