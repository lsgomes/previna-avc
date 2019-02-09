//
//  StartViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 3/23/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    let SEGUE_WIZARD = "segueToWizard"
    let SEGUE_CALCULATOR = "segueToCalculator"
    
    let WIZARD_CONTROLLER = "WizardController"
    let TAB_BAR_CONTROLLER = "TabBarController"
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let exists = UserManager.instance.fileExists()
        
        if (exists) {
            // perform segue to calculate risk
            UserManager.instance.loadPerson()
            self.performSegue(withIdentifier: SEGUE_CALCULATOR, sender: self)
        }
        else {
            // perform segue to wizard
            self.performSegue(withIdentifier: SEGUE_WIZARD, sender: self)
        }
    }

    
    func instantiateViewController() {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: self.WIZARD_CONTROLLER) as! WizardPageViewController
        
        self.present(viewController, animated: true, completion: nil)
    }
 
}
