//
//  PageViewController.swift
//  NamazKeeper2
//
//  Created by Apple on 22.07.16.
//  Copyright © 2016 NU. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    var mdelegate : Animator!
    var currentt = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .Forward,
                               animated: true,
                               completion: nil)
        }
        currentt = 0
        print(currentt)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        
        return [
            UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ViewController"),
            UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CompassViewController"),
            UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("UINavigationController")
        ]
    }()
    
}

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        return orderedViewControllers[previousIndex]
    
    }
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        return orderedViewControllers[nextIndex]
    }
    
}
extension PageViewController: UIPageViewControllerDelegate{
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
    
    }
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        currentt = orderedViewControllers.indexOf((pageViewController.viewControllers?.first)!)!
        mdelegate.animateTheChange(currentt)
    }
    
    
}







