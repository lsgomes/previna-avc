//
//  WizardPageViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 2/8/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit

class WizardPageViewController: UIPageViewController {

    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newViewController(title: "WizardPage1"),
                self.newViewController(title: "WizardPage2"),
                self.newViewController(title: "WizardPage3")]
    } ()

    
    private func newViewController(title: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: title)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        
        //view.backgroundColor = .clear
        //view.isOpaque = false
        //view.alpha = 1
        
        let doc = UIImage.init(named: "document")!
        let imageView = UIImageView.init(image: doc)
        imageView.widthAnchor.constraint(equalToConstant: 375.0)
        imageView.heightAnchor.constraint(equalToConstant: 667.0)
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill

        view.addSubview(imageView)
        
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
        
        //pageControl.isOpaque = false
        //pageControl.alpha = 1
        
        pageControl.currentPageIndicatorTintColor = UIColor.darkGray
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.backgroundColor = .clear
        
        //let doc = UIImage.init(named: "document")!
        //pageControl.backgroundColor = UIColor.init(patternImage: doc)
        //pageControl.contentMode = .scaleAspectFill
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
    
}
