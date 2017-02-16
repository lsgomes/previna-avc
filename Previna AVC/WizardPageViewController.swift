//
//  WizardPageViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 2/8/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit
import HealthKit

class WizardPageViewController: UIPageViewController {
    
    var nextViewController: UIViewController?
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newViewController(title: "WizardSegue1"),
                self.newViewController(title: "WizardSegue2"),
                self.newViewController(title: "WizardSegue3")
    ]
    } ()

    
    private func newViewController(title: String) -> UIViewController {
        performSegue(withIdentifier: title, sender: self)
        
        //if let profileSetupPage = nextViewController as? ProfileSetupViewController {
            //profileSetupPage.healthKitStore
        //}
        
        return nextViewController!
       // return UIStoryboard(name: "Main", bundle: nil)
        //    .instantiateViewController(withIdentifier: title)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        
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
        
        stylePageControl()
        
        // Do any additional setup after loading the view.
    }
    
    private func stylePageControl() {
        let pageControl = UIPageControl.appearance(whenContainedInInstancesOf: [type(of: self)])
        
        pageControl.currentPageIndicatorTintColor = UIColor.darkGray
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.backgroundColor = .clear

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //if segue.identifier == "WizardSegue2" || segue.identifier == "WizardSegue3" {
        //    var viewController = segue.destination as? HealthKitProtocol
        //viewController?.healthKitStore = self.healthKitStore
        //}
        
        //if segue.identifier == "WizardSegue3" {
        //    let profileSetup = segue.destination as? ProfileSetupViewController
        //    profileSetup?.setup()
        //}
    //}


}

// MARK: WizardPageViewControllerDataSource

extension WizardPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
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
