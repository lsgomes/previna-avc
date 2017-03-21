//
//  ProfileSetupPage2ViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 3/20/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit
import DKDropMenu

class ProfileSetupPage2ViewController: UIViewController, UITextFieldDelegate, DKDropMenuDelegate {

    @IBOutlet weak var scholarshipDropMenu: DKDropMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        scholarshipDropMenu.add(names: ["Evito", "Sete ou mais vezes por semana", "Ex-álcoolatra"])
        scholarshipDropMenu.selectedColor = .lightGray
        scholarshipDropMenu.textColor = .black
        scholarshipDropMenu.itemHeight = 30
        
        scholarshipDropMenu.delegate = self
        
        
    }
    
    func itemSelected(withIndex: Int, name: String) {
        print("\(name) selected");
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
