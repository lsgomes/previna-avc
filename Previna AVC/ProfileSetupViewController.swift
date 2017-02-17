//
//  ProfileSetupViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 2/14/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit
import HealthKit

class ProfileSetupViewController: UIViewController {
    
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var sexTextField: UITextField!
        
    override func viewDidLoad() {

        print("ProfileSetupViewController.viewDidLoad()")
        
        ageTextField.text = HealthKitManager.instance.getDateOfBirth()
        sexTextField.text = HealthKitManager.instance.getBiologicalSex()
        
    }

}
