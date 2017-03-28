//
//  HealthKitViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 2/9/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit
import HealthKit

class AuthorizeHealthKitViewController: UIViewController {
    
    @IBOutlet weak var allowAccessButton: UIButton!
    
    @IBAction func allowAccess(_ sender: UIButton) {
        
        print("HealthKitViewController.allowAccess()")
        
        let completion: ((Bool, Error?) -> Void)! = {
            (success, error) -> Void in
            
            if success {
            
               DispatchQueue.main.async {
                    let pageViewController = self.parent as? WizardPageViewController
                    pageViewController?.segueToPage(name: WizardPageViewController.PAGE_3)
                }
                
            } else {
                
                print("You didn't allow HealthKit to access these read/write data types. In your app, try to handle this error gracefully when a user decides not to provide access. The error was: \(error). If you're using a simulator, try it on a device.")
           
                DispatchQueue.main.async {
                    let pageViewController = self.parent as? WizardPageViewController
                    pageViewController?.segueToPage(name: WizardPageViewController.PAGE_3)
                }
                
            }
            
           
        }
        
        HealthKitManager.instance.authorizeHealthKit(completion: completion)
        
      
    }
}
