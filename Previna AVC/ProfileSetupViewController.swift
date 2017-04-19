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
    
    @IBOutlet var navigationBar: UINavigationBar!
    
    let SEGMENT_MALE = 0;
    let SEGMENT_FEMALE = 1;
    
    let SEGMENT_YES = 0;
    let SEGMENT_NO = 1;
  
    override func viewDidLoad() {

        print("ProfileSetupViewController.viewDidLoad()")

        gatherInformationFromHealthKit()

        navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64.0)
        
        nameTextField.delegate = self
        ageTextField.delegate = self
                
        ageTextField.text = HealthKitManager.instance.getDateOfBirth()
        let sex = HealthKitManager.instance.getBiologicalSex()
        
        switch (sex) {
            case "Feminino":
                sexSegmentedControl.selectedSegmentIndex = SEGMENT_FEMALE
            case "Masculino":
                sexSegmentedControl.selectedSegmentIndex = SEGMENT_MALE
            default:
            break
        }
        
    
    }
    
    func gatherInformationFromHealthKit() {
        
//        HealthKitManager.instance.getDiabetes() { hasDiabetes, error in
//            
//            self.setSegmentControlHealthKit(riskFactor: hasDiabetes, segmentControl: self.diabetesSegmentedControl, error: error)
//        }
//        
//        HealthKitManager.instance.getHighBloodPressure() { hasHighBloodPressure, error in
//   
//            self.setSegmentControlHealthKit(riskFactor: hasHighBloodPressure, segmentControl: self.hypertensionSegmentedControl, error: error)
//
//        }
    }
    
    func setSegmentControlHealthKit(riskFactor: Bool, segmentControl: UISegmentedControl, error: Error? ) {
        
        if (error != nil) {
            return
        }
        
        if (riskFactor) {
            segmentControl.selectedSegmentIndex = SEGMENT_YES
        }
        else {
            segmentControl.selectedSegmentIndex = SEGMENT_NO
        }
        
    }
    
    func validateForm() {
        
        var riskFactors = [HasRiskFactor]()
        
        if (!ageTextField.text!.isEmpty)
        {
            UserManager.instance.person.hasAge = Int(ageTextField.text!)
        }
        
        if (!nameTextField.text!.isEmpty)
        {
            UserManager.instance.person.hasUserName = nameTextField.text
            UserManager.instance.person.uri = nameTextField.text
        }
        
        validateSegmentControl(segmentControl: sexSegmentedControl, uri: RiskFactor.MALE.rawValue, expectedSegmentResult: SEGMENT_MALE, riskFactors: &riskFactors)

        validateSegmentControl(segmentControl: hypertensionSegmentedControl, uri: RiskFactor.HYPERTENSION.rawValue, riskFactors: &riskFactors)

        validateSegmentControl(segmentControl: diabetesSegmentedControl, uri: RiskFactor.DIABETES.rawValue, riskFactors: &riskFactors)
        
        validateSegmentControl(segmentControl: renalDiseaseSegmentedControl, uri: RiskFactor.RENAL_DISEASE.rawValue, riskFactors: &riskFactors)
    
        validateSegmentControl(segmentControl: peripheralDiseaseSegmentedControl, uri: RiskFactor.PERIPHERAL_DISEASE.rawValue, riskFactors: &riskFactors)
        
        validateSegmentControl(segmentControl: heartFailureSegmentedControl, uri: RiskFactor.HEART_FAILURE.rawValue, riskFactors: &riskFactors)
        
        validateSegmentControl(segmentControl: ischemicHeartDiseaseSegmentedControl, uri: RiskFactor.ISCHEMIC_HEART_DISEASE.rawValue, riskFactors: &riskFactors)
        
        UserManager.instance.person.hasRiskFactor = riskFactors
    }
    
    func validateSegmentControl(segmentControl: UISegmentedControl, uri: String, riskFactors: inout [HasRiskFactor]) {
        
        if (segmentControl.selectedSegmentIndex == SEGMENT_YES) {
            UserManager.instance.addRiskFactor(uri: uri)
        }
    }
    
    func validateSegmentControl(segmentControl: UISegmentedControl, uri: String, expectedSegmentResult: Int, riskFactors: inout [HasRiskFactor]) {
        
        if (segmentControl.selectedSegmentIndex == expectedSegmentResult) {
            UserManager.instance.addRiskFactor(uri: uri)
        }
    }
    
    @IBAction func continueAction(_ sender: UIButton) {
    
//        if (nameTextField.text!.isEmpty) {
//            NotificationManager.instance.displayAlert(title: "Nome não preenchido", message: "Preencha seu nome para continuar", dismiss: "Ok", viewController: self)
//            return
//        }
//        
//        if (ageTextField.text!.isEmpty) {
//            NotificationManager.instance.displayAlert(title: "Idade não preenchida", message: "Preencha sua idade para continuar", dismiss: "Ok", viewController: self)
//            return
//        }
//        
        
        // TODO: rest call verify if name already exists
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

