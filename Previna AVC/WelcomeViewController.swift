//
//  WelcomeViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 2/16/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBAction func continueButton(_ sender: UIButton) {
        let pageViewController = self.parent as? WizardPageViewController
        pageViewController?.segueToPage(name: WizardPageViewController.PAGE_2)
    }

}
