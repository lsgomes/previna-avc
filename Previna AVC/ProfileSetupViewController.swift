//
//  ProfileSetupViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 2/14/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit
import HealthKit

class ProfileSetupViewController: HealthKitEnabledViewController {
    
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var sexTextField: UITextField!
    
    @IBOutlet var continueButton: UIButton!
    
    override func viewDidLoad() {
        //super.viewDidLoad()
        print("ProfileSetupViewController loaded")
        
    }
    
    func setup() {
          
        //var v = self.view
        
        let formatter = DateFormatter()
        //formatter.

            do {
                let dateOfBirth = try healthKitStore.dateOfBirth() as Date
                ageTextField.textColor = .black
                let text = formatter.string(from: dateOfBirth)
                print("age: " + (text))
                ageTextField.text = text
                print("ageTextfield" + ageTextField.text!)
                
            } catch {
                print("Error getting dateOfBirth from HealthKitStore")
            }
            
            do {
                
                let sex = try healthKitStore.biologicalSex().biologicalSex
                
                var text = ""
                
                switch (sex as HKBiologicalSex) {
                case .male:
                    text = "Masculino"
                case .female:
                    text = "Feminino"
                default:
                    break
                }
                
                print(text)
                sexTextField.text = text
                print("sexTextField: " + sexTextField.text!)

                
            } catch {
                print("Error getting biologicalSex from HealthKitStore")
            }

        //let isAuthorizedForWeight = healthKitStore.authorizationStatus(for: HKObjectTye.quantityType(forIdentifier: .bodyMass)! )
        
        //if (isAuthorizedForWeight == .sharingAuthorized) {
            
        //}

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func clickContinueButton(_ sender: Any) {
        setup()
    }
}
