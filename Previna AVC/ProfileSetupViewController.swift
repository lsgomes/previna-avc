//
//  ProfileSetupViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 2/14/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit
import HealthKit
import Dropper

class ProfileSetupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var sexSegmentedControl: UISegmentedControl!
    @IBOutlet var alcoholPicker: UIButton!
    
    let alcoholDropper = Dropper(x: 71, y: 50, width: 195, height: 33)
    
    override func viewDidLoad() {

        print("ProfileSetupViewController.viewDidLoad()")
        
        nameTextField.delegate = self
        ageTextField.delegate = self
        
        alcoholPicker.layer.borderWidth = 0.3
        alcoholPicker.layer.borderColor = UIColor.lightGray.cgColor
        
        //alcoholDropper.cornerRadius = 3
        
        ageTextField.text = HealthKitManager.instance.getDateOfBirth()
        let sex = HealthKitManager.instance.getBiologicalSex()
        
        switch (sex) {
            case "Feminino":
                sexSegmentedControl.selectedSegmentIndex = 1
            default:
                sexSegmentedControl.selectedSegmentIndex = 0

        }
    }
    
    
    @IBAction func alcoholDropperSelect(_ sender: UIButton) {
        if alcoholDropper.status == .hidden {
            alcoholDropper.items = ["Bebo sete ou mais vezes por semana", "Ex-álcoolatra", "Evito"]
            alcoholDropper.theme = Dropper.Themes.white
            alcoholDropper.delegate = self
            alcoholDropper.refreshHeight()
            alcoholDropper.showWithAnimation(0.3, options: .center, button: sender)
            view.addSubview(alcoholDropper)
        } else {
            alcoholDropper.hideWithAnimation(0.2)
        }
    }
    
    /**
     * Called when 'return' key pressed. return NO to ignore.
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /**
     * Called when the user click on ßthe view (outside the UITextField).
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension ProfileSetupViewController: DropperDelegate {
    func DropperSelectedRow(_ path: IndexPath, contents: String) {
        alcoholPicker.setTitle(contents, for: .normal)
    }
}
