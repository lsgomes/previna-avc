//
//  WelcomeViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 2/16/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    //@IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var welcomeText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeText.text = NSLocalizedString("This app will help you in preventing stroke.", comment: "")
        
        navigationItem.title = NSLocalizedString("Welcome to Previna AVC!", comment: "")
        
        //navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64.0)
    }
    
    @IBAction func continueButton(_ sender: UIButton) {
        let navigationController = self.parent as! UINavigationController
        let pageViewController = navigationController.parent as! WizardPageViewController
        pageViewController.segueToPage(name: WizardPageViewController.PAGE_2)
    }

}
