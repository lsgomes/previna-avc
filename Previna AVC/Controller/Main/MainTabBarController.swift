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
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if (viewController is ThirdViewController) {
            let vc = viewController as! ThirdViewController
            vc.tableView.reloadData()
            print("Switched to ThirdViewController()")

        }

}
