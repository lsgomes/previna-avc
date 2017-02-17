//
//  WizardPageViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 2/8/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit
import HealthKit

class WizardPageViewController: UIPageViewController //, UIPageViewControllerDelegate
{
    static let PAGE_1 = "WizardPage1"
    static let PAGE_2 = "WizardPage2"
    static let PAGE_3 = "WizardPage3"
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newViewController(title: PAGE_1),
                self.newViewController(title: PAGE_2),
                self.newViewController(title: PAGE_3)
    ]
    } ()

    
    private func newViewController(title: String) -> UIViewController {
        
        print("WizardPageViewController.newViewController(): " + title)
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: title)
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
        
        // delegate = self
        //self.view.backgroundColor = .white
        
        let doc = UIImage.init(named: "document")!
        let imageView = UIImageView.init(image: doc)

        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.frame = CGRect(x: 0, y: 0, width: 375.0, height: 667.0)

        view.addSubview(imageView)
        view.sendSubview(toBack: imageView)
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true, completion: nil)
        }
        
        let pageControl = UIPageControl.appearance(whenContainedInInstancesOf: [type(of: self)])
        
        pageControl.currentPageIndicatorTintColor = UIColor.darkGray
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.backgroundColor = .clear
    }

    public func segueToPage(name: String)
    {
        var page : UIViewController?
        
        for viewController in orderedViewControllers {
            if viewController.restorationIdentifier == name {
                page = viewController
                break;
            }
        }
        
        print("WizardPageViewController.segueToPage(): " + page!.restorationIdentifier!)
        
        setViewControllers([page!], direction: .forward, animated: true, completion: nil)
    }

    //  public func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController])

}

// MARK: WizardPageViewControllerDataSource

extension WizardPageViewController: UIPageViewControllerDataSource {
    
//    func pageViewController(_ pageViewController: UIPageViewController,
//                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        
//        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
//            return nil
//        }
//        
//        print("viewControllerBefore.currentViewController: \(viewControllerIndex)")
//        
//        let previousIndex = viewControllerIndex - 1
//        
//        guard previousIndex >= 0 else {
//            return nil
//        }
//        
//        guard orderedViewControllers.count > previousIndex else {
//            return nil
//        }
//        
//        return orderedViewControllers[previousIndex]
//    }
//    
//    func pageViewController(_ pageViewController: UIPageViewController,
//                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        
//        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
//            return nil
//        }
//        
//        print("viewControllerAfter.currentViewController: \(viewControllerIndex)")
//
//        if (viewController.restorationIdentifier == WizardPageViewController.PAGE_3)
//        {
//            let profileSetup = viewController as? ProfileSetupViewController
//            profileSetup?.setup()
//        }
//        
//        let nextIndex = viewControllerIndex + 1
//        let orderedViewControllersCount = orderedViewControllers.count
//        
//        guard orderedViewControllersCount != nextIndex else {
//            return nil
//        }
//        
//        guard orderedViewControllersCount > nextIndex else {
//            return nil
//        }
//        
//        return orderedViewControllers[nextIndex]
//
//    }
    
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
    
    
    // Snippets
    
    //let doc = UIImage.init(named: "document")!
    //pageControl.backgroundColor = UIColor.init(patternImage: doc)
    //pageControl.contentMode = .scaleAspectFill
    
    //pageControl.isOpaque = false
    //pageControl.alpha = 1
    
    //view.backgroundColor = .clear
    //view.isOpaque = false
    //view.alpha = 1
    //imageView.frame = CGRect(x: 0, y: 0, width: doc.size.width, height: doc.size.height)
    //imageView.bounds = CGRect(x: 0, y: 0, width: 375.0, height: 667.0)
    //imageView.widthAnchor.constraint(equalToConstant: 375.0)
    //imageView.heightAnchor.constraint(equalToConstant: 667.0)
    //imageView.bounds = CGRect(0,0,doc.size.width,doc.size.height);
    //imageView.frame.width = 375.0
    //imageView.sizeToFit()
    
}
