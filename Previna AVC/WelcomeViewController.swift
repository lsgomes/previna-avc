//
//  WelcomeViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 2/16/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Bem-vindo ao Previna AVC!"

        
        navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64.0)
    }
    
    @IBAction func continueButton(_ sender: UIButton) {
        let navigationController = self.parent as! UINavigationController
        let pageViewController = navigationController.parent as! WizardPageViewController
        pageViewController.segueToPage(name: WizardPageViewController.PAGE_2)
    }

}
