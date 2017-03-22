//
//  ProfileSetupViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 2/14/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit
import HealthKit

class ProfileSetupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var sexSegmentedControl: UISegmentedControl!
    @IBOutlet var hypertensionSegmentedControl: UISegmentedControl!
    @IBOutlet var diabetesSegmentedControl: UISegmentedControl!
    @IBOutlet var renalDiseaseSegmentedControl: UISegmentedControl!
    @IBOutlet var peripheralDiseaseSegmentedControl: UISegmentedControl!
    @IBOutlet var heartFailureSegmentedControl: UISegmentedControl!
    @IBOutlet var ischemicHeartDiseaseSegmentedControl: UISegmentedControl!
    
    let MALE = "Male";
    let HYPERTENSION = "Hypertension";
    let DIABETES = "Diabetes";
    let RENAL_DISEASE = "Renal_disease"
    let PERIPHERAL_DISEASE = "Peripheral_arterial_disease"
    let HEART_FAILURE = "Congestive_heart_failure"
    let ISCHEMIC_HEART_DISEASE = "Ischemic_heart_disease"

    let SEGMENT_MALE = 0;
    let SEGMENT_FEMALE = 1;
    
    let SEGMENT_YES = 0;
    let SEGMENT_NO = 1;
    
    override func viewDidLoad() {

        print("ProfileSetupViewController.viewDidLoad()")
        
        nameTextField.delegate = self
        ageTextField.delegate = self
                
        ageTextField.text = HealthKitManager.instance.getDateOfBirth()
        let sex = HealthKitManager.instance.getBiologicalSex()
        
        switch (sex) {
            case "Feminino":
                sexSegmentedControl.selectedSegmentIndex = SEGMENT_FEMALE
            default:
                sexSegmentedControl.selectedSegmentIndex = SEGMENT_MALE

        }
    }
    
    func validateForm() {
        
        var riskFactors = [HasRiskFactor]()
        
        if (!ageTextField.text!.isEmpty)
        {
            UserManager.instance.person?.hasAge = Int(ageTextField.text!)
        }
        
        if (!nameTextField.text!.isEmpty)
        {
            UserManager.instance.person?.hasUserName = nameTextField.text
        }
        
        validateSegmentControl(segmentControl: sexSegmentedControl, uri: MALE, expectedSegmentResult: SEGMENT_MALE, riskFactors: &riskFactors)

        validateSegmentControl(segmentControl: hypertensionSegmentedControl, uri: HYPERTENSION, riskFactors: &riskFactors)

        validateSegmentControl(segmentControl: diabetesSegmentedControl, uri: DIABETES, riskFactors: &riskFactors)
        
        validateSegmentControl(segmentControl: renalDiseaseSegmentedControl, uri: RENAL_DISEASE, riskFactors: &riskFactors)
    
        validateSegmentControl(segmentControl: peripheralDiseaseSegmentedControl, uri: PERIPHERAL_DISEASE, riskFactors: &riskFactors)
        
        validateSegmentControl(segmentControl: heartFailureSegmentedControl, uri: HEART_FAILURE, riskFactors: &riskFactors)
        
        validateSegmentControl(segmentControl: ischemicHeartDiseaseSegmentedControl, uri: ISCHEMIC_HEART_DISEASE, riskFactors: &riskFactors)
        
        UserManager.instance.person?.hasRiskFactor = riskFactors
    }
    
    func validateSegmentControl(segmentControl: UISegmentedControl, uri: String, riskFactors: inout [HasRiskFactor]) {
        
        if (segmentControl.selectedSegmentIndex == SEGMENT_YES) {
            let risk = HasRiskFactor()
            risk.uri = uri
            riskFactors.append(risk)
        }
    }
    
    func validateSegmentControl(segmentControl: UISegmentedControl, uri: String, expectedSegmentResult: Int, riskFactors: inout [HasRiskFactor]) {
        
        if (segmentControl.selectedSegmentIndex == expectedSegmentResult) {
            let risk = HasRiskFactor()
            risk.uri = uri
            riskFactors.append(risk)
        }
    }
    
    @IBAction func continueAction(_ sender: UIButton) {
    
        validateForm()
        let pageViewController = self.parent as? WizardPageViewController
        pageViewController?.segueToPage(name: WizardPageViewController.PAGE_4)

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

