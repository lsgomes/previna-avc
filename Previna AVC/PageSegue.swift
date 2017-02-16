//
//  PageSegue.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 2/15/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit

class PageSegue: UIStoryboardSegue {

    override init(identifier: String?, source: UIViewController, destination: UIViewController) {
        
        super.init(identifier: identifier, source: source, destination: destination)
        if let pageViewController = source as? WizardPageViewController {
            pageViewController.nextViewController = destination as UIViewController //as? ProfileSetupViewController
        }
    }
    
    // Exception: A segue must either have a performHandler or it must override perform.
    override func perform() {
        
    }
}
