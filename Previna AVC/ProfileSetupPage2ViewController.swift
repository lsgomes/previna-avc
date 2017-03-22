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

    @IBOutlet var physicalActivityDropMenu: DKDropMenu!
    @IBOutlet var alcoholDropMenu: DKDropMenu!
    @IBOutlet var smokeDropMenu: DKDropMenu!
    @IBOutlet var schoolDropMenu: DKDropMenu!
    
    @IBOutlet var crySegmentControl: UISegmentedControl!
    @IBOutlet var angrySegmentControl: UISegmentedControl!
    @IBOutlet var anxietySegmentControl: UISegmentedControl!
    
    let SEGMENT_YES = 0;
    
    // MARK: Physical_activity
    let INACTIVE = "Inactive"
    let ACTIVE = "Active"
    
    // MARK: Alcohol_consumption
    let ABSTAIN = "Abstain"
    let DRINKER = "Drinker"
    let FORMER_ALCOHOLIC = "Former_alcoholic"
    
    // MARK: Smoking_status
    let SMOKER = "Smoker"
    let FORMER_SMOKER = "Former_smoker"
    
    // MARK: Education
    let HIGH_SCHOOL_DIPLOMA = "High_school_diploma_and_some_college"
    let NO_HIGH_SCHOOL_DIPLOMA = "No_high_school_diploma"
    
    // MARK: Psychological_factors
    let CRY_EASILY = "Cry_easily"
    let CRITICAL_OF_OTHERS = "Critical_of_others"
    let FEARFUL = "Fearful"
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setDropMenuAttributes(dropMenu: physicalActivityDropMenu, items: ["Sedentário", "1-2 por semana", "3+ por semana"])
        
        setDropMenuAttributes(dropMenu: alcoholDropMenu, items: ["Abstenho", "7+ por semana", "1-6 por semana", "Ex-álcoolatra"])

        
        setDropMenuAttributes(dropMenu: smokeDropMenu, items: ["Fumante", "Ex-fumante", "Não-fumante"])
        
        setDropMenuAttributes(dropMenu: schoolDropMenu, items: ["Ensino médio", "Ensino superior", "Ensino fundamental"])
        
    }
    
    func collapsedChanged(dropMenu: DKDropMenu, collapsed: Bool) {
        if (!collapsed) {
            
            switch (dropMenu) {
                
            case schoolDropMenu:
                fadein(dropMenu: alcoholDropMenu)
                
            case physicalActivityDropMenu:
                fadein(dropMenu: alcoholDropMenu)
                fadein(dropMenu: smokeDropMenu)
                
            case alcoholDropMenu:
                fadein(dropMenu: smokeDropMenu)

            default:
                break
            }
        
        }
        else {
            fadeout(dropMenu: alcoholDropMenu)
            fadeout(dropMenu: smokeDropMenu)
        }
    }
    
    func fadein(dropMenu: DKDropMenu) {
        
        UIView.animate(withDuration: 0.2, animations: {
            dropMenu.alpha = 0.0
        })
    }
    
    func fadeout(dropMenu: DKDropMenu) {

        UIView.animate(withDuration: 1.0, animations: {
            dropMenu.alpha = 1.0
        })
    }
    
    
    func itemSelected(withIndex: Int, name: String, dropMenu: DKDropMenu) {
        
        alcoholDropMenu.isHidden = false
        smokeDropMenu.isHidden = false
        
        var riskFactors = UserManager.instance.person?.hasRiskFactor
        
        if (dropMenu == physicalActivityDropMenu) {
            switch withIndex {
            case 0:
                addRiskFactor(uri: INACTIVE, riskFactors: &riskFactors!)
            case 1:
                addRiskFactor(uri: ACTIVE, riskFactors: &riskFactors!)
            default:
                break;
            }
        }
        
        if (dropMenu == alcoholDropMenu) {
            switch withIndex {
            case 0:
                addRiskFactor(uri: ABSTAIN, riskFactors: &riskFactors!)
            case 1:
                addRiskFactor(uri: DRINKER, riskFactors: &riskFactors!)
            case 3:
                addRiskFactor(uri: FORMER_ALCOHOLIC, riskFactors: &riskFactors!)
            default:
                break;
            }
        }
        
        if (dropMenu == smokeDropMenu) {
            switch withIndex {
            case 0:
                addRiskFactor(uri: SMOKER, riskFactors: &riskFactors!)
            case 1:
                addRiskFactor(uri: FORMER_SMOKER, riskFactors: &riskFactors!)
            default:
                break;
            }
        }
        
        if (dropMenu == schoolDropMenu) {
            switch withIndex {
            case 0:
                addRiskFactor(uri: HIGH_SCHOOL_DIPLOMA, riskFactors: &riskFactors!)
            case 2:
                addRiskFactor(uri: NO_HIGH_SCHOOL_DIPLOMA, riskFactors: &riskFactors!)
            default:
                break;
            }
        }
        
        UserManager.instance.person?.hasRiskFactor = riskFactors
        
    }
    
    func addRiskFactor(uri: String, riskFactors: inout [HasRiskFactor]) {
        let risk = HasRiskFactor()
        risk.uri = uri
        riskFactors.append(risk)
    }
    
    func validateForm() {
        
        var riskFactors = UserManager.instance.person?.hasRiskFactor
        
        validateSegmentControl(segmentControl: crySegmentControl, uri: CRY_EASILY, riskFactors: &riskFactors!)

        validateSegmentControl(segmentControl: angrySegmentControl, uri: CRITICAL_OF_OTHERS, riskFactors: &riskFactors!)
        
        validateSegmentControl(segmentControl: anxietySegmentControl, uri: FEARFUL, riskFactors: &riskFactors!)

        UserManager.instance.person?.hasRiskFactor = riskFactors
    }
    
    func validateSegmentControl(segmentControl: UISegmentedControl, uri: String, riskFactors: inout [HasRiskFactor]) {
        
        if (segmentControl.selectedSegmentIndex == SEGMENT_YES) {
            addRiskFactor(uri: uri, riskFactors: &riskFactors)
        }
    }
    
    func setDropMenuAttributes(dropMenu: DKDropMenu, items: [String]) {
        dropMenu.selectedColor = .gray
        dropMenu.textColor = .black
        dropMenu.itemHeight = 30
        dropMenu.add(names: items)
        dropMenu.delegate = self
    }
    
    @IBAction func continueAction(_ sender: UIButton) {
        validateForm()
        self.performSegue(withIdentifier: "TabBarSegue", sender: nil)
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
