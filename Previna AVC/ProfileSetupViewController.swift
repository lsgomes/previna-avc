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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ProfileSetupViewController loaded")
        
    }
    
    func setup() {
          
        var v = self.view
        
        let formatter = DateFormatter()

        
        //let isAuthorizedForAge = healthKitStore.authorizationStatus(for: HKObjectType.characteristicType(forIdentifier: .dateOfBirth)! )
        
        //if (isAuthorizedForAge == .sharingAuthorized) {
            
            do {
                let dateOfBirth = try healthKitStore.dateOfBirth() as Date
                ageTextField.textColor = .black
                ageTextField.text = formatter.string(from: dateOfBirth)
                
            } catch {
                print("Error getting dateOfBirth from HealthKitStore")
            }
        //}
        
        //let isAuthorizedForSex = healthKitStore.authorizationStatus(for: HKObjectType.characteristicType(forIdentifier: .biologicalSex)! )
        
        //if (isAuthorizedForSex == .sharingAuthorized) {
            
            
            do {
                
                let sex = try healthKitStore.biologicalSex().biologicalSex
                
                switch (sex as HKBiologicalSex) {
                case .male:
                    sexTextField.text = "Masculino"
                case .female:
                    sexTextField.text = "Feminino"
                default:
                    break
                }
                
            } catch {
                print("Error getting biologicalSex from HealthKitStore")
            }
            
        //}
        
        //let isAuthorizedForWeight = healthKitStore.authorizationStatus(for: HKObjectType.quantityType(forIdentifier: .bodyMass)! )
        
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

}
