//
//  WelcomeViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 2/16/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet var welcomeText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeText.text = NSLocalizedString("This app will help you in preventing stroke.", comment: "")
        
        navigationItem.title = NSLocalizedString("Welcome to Previna AVC!", comment: "")
        
    }
    
    @IBAction func continueButton(_ sender: UIButton) {
        let navigationController = self.parent as! UINavigationController
        let pageViewController = navigationController.parent as! WizardPageViewController
        pageViewController.segueToPage(name: WizardPageViewController.PAGE_2)
    }

}
