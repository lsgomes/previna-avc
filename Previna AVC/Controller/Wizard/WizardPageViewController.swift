//
//  WizardPageViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 2/8/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit
import HealthKit

class WizardPageViewController: UIPageViewController
{
    static let PAGE_1 = "WizardPage1"
    static let PAGE_2 = "WizardPage2"
    static let PAGE_3 = "formOneViewController"
    static let PAGE_4 = "formTwoViewController"

    var pageControl: UIPageControl?
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newViewController(title: WizardPageViewController.PAGE_1),
                self.newViewController(title: WizardPageViewController.PAGE_2),
                self.newViewController(title: WizardPageViewController.PAGE_3),
                self.newViewController(title: WizardPageViewController.PAGE_4)
               ]
    } ()

    
    private func newViewController(title: String) -> UIViewController {
        
        print("WizardPageViewController.newViewController(): " + title)
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: title)
        let navigationController = UINavigationController(rootViewController: vc)
        return navigationController
    }
    
    var currentIndex:Int {
        get {
            return orderedViewControllers.index(of: self.viewControllers!.first!)!
        }
        
        set {
            guard newValue >= 0,
                newValue < orderedViewControllers.count else {
                    return
            }
            
            let vc = orderedViewControllers[newValue]
            let direction:UIPageViewControllerNavigationDirection = newValue > currentIndex ? .forward : .reverse
            self.setViewControllers([vc], direction: direction, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        
        self.view.backgroundColor = .white
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true, completion: nil)
        }
        
        pageControl = UIPageControl.appearance(whenContainedInInstancesOf: [type(of: self)])
        
        pageControl!.currentPageIndicatorTintColor = UIColor.darkGray
        pageControl!.pageIndicatorTintColor = UIColor.lightGray
        pageControl!.backgroundColor = .clear
    }

    public func segueToPage(name: String)
    {
        var page : UIViewController?
        
        for viewController in orderedViewControllers {

            for child in viewController.childViewControllers {
                if (child.restorationIdentifier == name) {
                    page = viewController
                    break
                }
            }
            
        }
        
        setViewControllers([page!], direction: .forward, animated: true, completion: nil)
    }
}

// MARK: WizardPageViewControllerDataSource

extension WizardPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
    
}
