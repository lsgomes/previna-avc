//
//  MainTabBarController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 3/28/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        // Do any additional setup after loading the view.
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if (viewController is SecondViewController) {
            let vc = viewController as! SecondViewController
            vc.updateWithHealthKitData()
            print("SecondViewController()")
        }
        
        if (viewController is ThirdViewController) {
            let vc = viewController as! ThirdViewController
            vc.tableView.reloadData()
            print("ThirdViewController()")

        }
//        let tabBarIndex = tabBarController.selectedIndex
//        
//        if tabBarIndex == 2 {
//
//            if tabBarController.selectedViewController as! ThirdViewController {
//                
//            }
//            
//        }
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
