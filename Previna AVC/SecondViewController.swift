//
//  SecondViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 2/8/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate, DKDropMenuDelegate {
    
    @IBOutlet var cryDropMenu: DKDropMenu!
    @IBOutlet var angryDropMenu: DKDropMenu!
    @IBOutlet var anxietyDropMenu: DKDropMenu!
    
    @IBOutlet var schoolDropMenu: DKDropMenu!
    @IBOutlet var physicalActivityDropMenu: DKDropMenu!
    @IBOutlet var alcoholDropMenu: DKDropMenu!
    @IBOutlet var smokeDropMenu: DKDropMenu!
    
    
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
    
    
    // MARK: Translations
    let TRANSLATION_INACTIVE = "Sedentário"
    let TRANSLATION_ACTIVE = "1-2 por semana"
    let TRANSLATION_ATHLETE = "3+ por semana"
    
    let TRANSLATION_ABSTAIN = "Abstenho"
    let TRANSLATION_DRINKER = "7+ por semana"
    let TRANSLATION_FORMER_ALCOHOLIC = "Ex-álcoolatra"
    let TRANSLATION_DRINKS = "1-6 por semana"
    
    let TRANSLATION_SMOKER = "Fumante"
    let TRANSLATION_FORMER_SMOKER = "Ex-fumante"
    let TRANSLATION_NON_SMOKER = "Não-fumante"
    
    let TRANSLATION_HIGH_SCHOOL_DIPLOMA = "Ensino médio"
    let TRANSLATION_NO_HIGH_SCHOOL_DIPLOMA = "Ensino fundamental"
    let TRANSLATION_COLLEGE_DIPLOMA = "Ensino superior"
    
    let TRANSLATION_OFTEN_OR_ALWAYS = "Muitas vezes"
    let TRANSLATION_SOMETIMES_OR_NEVER = "Às vezes"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDropMenuAttributes(dropMenu: physicalActivityDropMenu, items: [TRANSLATION_ATHLETE, TRANSLATION_ACTIVE, TRANSLATION_INACTIVE])
        
        setDropMenuAttributes(dropMenu: alcoholDropMenu, items: [TRANSLATION_DRINKS, TRANSLATION_DRINKER, TRANSLATION_ABSTAIN, TRANSLATION_FORMER_ALCOHOLIC])
        
        setDropMenuAttributes(dropMenu: smokeDropMenu, items: [TRANSLATION_NON_SMOKER, TRANSLATION_SMOKER, TRANSLATION_FORMER_SMOKER])
        
        setDropMenuAttributes(dropMenu: schoolDropMenu, items: [TRANSLATION_COLLEGE_DIPLOMA, TRANSLATION_HIGH_SCHOOL_DIPLOMA, TRANSLATION_NO_HIGH_SCHOOL_DIPLOMA])
        
        setDropMenuAttributes(dropMenu: cryDropMenu, items: [TRANSLATION_SOMETIMES_OR_NEVER, TRANSLATION_OFTEN_OR_ALWAYS])
        
        setDropMenuAttributes(dropMenu: angryDropMenu, items: [TRANSLATION_SOMETIMES_OR_NEVER, TRANSLATION_OFTEN_OR_ALWAYS])
        
        setDropMenuAttributes(dropMenu: anxietyDropMenu, items: [TRANSLATION_SOMETIMES_OR_NEVER, TRANSLATION_OFTEN_OR_ALWAYS])
        
        // BS
        
        dropMenuSetSelectedItem(riskFactor: ACTIVE, selectItem: TRANSLATION_ACTIVE, dropMenu: physicalActivityDropMenu)
        dropMenuSetSelectedItem(riskFactor: INACTIVE, selectItem: TRANSLATION_INACTIVE, dropMenu: physicalActivityDropMenu)
        
        dropMenuSetSelectedItem(riskFactor: DRINKER, selectItem: TRANSLATION_DRINKER, dropMenu: alcoholDropMenu)
        dropMenuSetSelectedItem(riskFactor: ABSTAIN, selectItem: TRANSLATION_ABSTAIN, dropMenu: alcoholDropMenu)
        dropMenuSetSelectedItem(riskFactor: FORMER_ALCOHOLIC, selectItem: TRANSLATION_FORMER_ALCOHOLIC, dropMenu: alcoholDropMenu)

        dropMenuSetSelectedItem(riskFactor: SMOKER, selectItem: TRANSLATION_SMOKER, dropMenu: smokeDropMenu)
        dropMenuSetSelectedItem(riskFactor: FORMER_SMOKER, selectItem: TRANSLATION_FORMER_SMOKER, dropMenu: smokeDropMenu)

        dropMenuSetSelectedItem(riskFactor: HIGH_SCHOOL_DIPLOMA, selectItem: TRANSLATION_HIGH_SCHOOL_DIPLOMA, dropMenu: schoolDropMenu)
        dropMenuSetSelectedItem(riskFactor: NO_HIGH_SCHOOL_DIPLOMA, selectItem: TRANSLATION_NO_HIGH_SCHOOL_DIPLOMA, dropMenu: schoolDropMenu)


        dropMenuSetSelectedItem(riskFactor: CRY_EASILY, selectItem: TRANSLATION_OFTEN_OR_ALWAYS, dropMenu: cryDropMenu)
        dropMenuSetSelectedItem(riskFactor: CRITICAL_OF_OTHERS, selectItem: TRANSLATION_OFTEN_OR_ALWAYS, dropMenu: angryDropMenu)
        dropMenuSetSelectedItem(riskFactor: FEARFUL, selectItem: TRANSLATION_OFTEN_OR_ALWAYS, dropMenu: anxietyDropMenu)
    }
    
    func dropMenuSetSelectedItem(riskFactor: String, selectItem: String, dropMenu: DKDropMenu) {
        
        let riskFactors = UserManager.instance.person.hasRiskFactor!
        
        if riskFactors.contains(where: { $0.uri == riskFactor }) {
            dropMenu.selectedItem = selectItem
        }
    }
    
    
    func collapsedChanged(dropMenu: DKDropMenu, collapsed: Bool) {
        if (!collapsed) {
            
            switch (dropMenu) {
                
            case schoolDropMenu:
                fadein(dropMenu: alcoholDropMenu)
                fadein(dropMenu: smokeDropMenu)
                
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
        
        print("itemSelected: withIndex: \(withIndex) name: \(name)")
        
        alcoholDropMenu.isHidden = false
        smokeDropMenu.isHidden = false
    }
    
    func addRiskFactor(uri: String, riskFactors: inout [HasRiskFactor]) {
        let risk = HasRiskFactor()
        risk.uri = uri
        riskFactors.append(risk)
    }
    
    func removeModifiableRiskFactors() {
        
        // for, by the love of gad
        
        var riskFactors = UserManager.instance.person.hasRiskFactor!
        
        removeRiskFactor(name: DRINKER, riskFactors: &riskFactors)
        removeRiskFactor(name: ABSTAIN, riskFactors: &riskFactors)
        removeRiskFactor(name: FORMER_ALCOHOLIC, riskFactors: &riskFactors)

        removeRiskFactor(name: ACTIVE, riskFactors: &riskFactors)
        removeRiskFactor(name: INACTIVE, riskFactors: &riskFactors)
        
        removeRiskFactor(name: SMOKER, riskFactors: &riskFactors)
        removeRiskFactor(name: FORMER_SMOKER, riskFactors: &riskFactors)

        removeRiskFactor(name: HIGH_SCHOOL_DIPLOMA, riskFactors: &riskFactors)
        removeRiskFactor(name: NO_HIGH_SCHOOL_DIPLOMA, riskFactors: &riskFactors)

        removeRiskFactor(name: CRY_EASILY, riskFactors: &riskFactors)
        removeRiskFactor(name: CRITICAL_OF_OTHERS, riskFactors: &riskFactors)
        removeRiskFactor(name: FEARFUL, riskFactors: &riskFactors)
        
        UserManager.instance.person.hasRiskFactor = riskFactors

    }
    
    func removeRiskFactor(name: String, riskFactors: inout [HasRiskFactor]) {
        
        let index = riskFactors.index(where: {element in
            element.uri == name
        })
        
        if (index != nil) {
            riskFactors.remove(at: index!)
        }
        
    }
    
    func validateForm() {
        
        var riskFactors = UserManager.instance.person.hasRiskFactor
        
        
        switch alcoholDropMenu.selectedItem! {
            
        case TRANSLATION_DRINKER:
            addRiskFactor(uri: DRINKER, riskFactors: &riskFactors!)
            
        case TRANSLATION_ABSTAIN:
            addRiskFactor(uri: ABSTAIN, riskFactors: &riskFactors!)
            
        case TRANSLATION_FORMER_ALCOHOLIC:
            addRiskFactor(uri: FORMER_ALCOHOLIC, riskFactors: &riskFactors!)
            
        default:
            break
        }
        
        switch physicalActivityDropMenu.selectedItem! {
            
        case TRANSLATION_ACTIVE:
            addRiskFactor(uri: ACTIVE, riskFactors: &riskFactors!)
            
        case TRANSLATION_INACTIVE:
            addRiskFactor(uri: INACTIVE, riskFactors: &riskFactors!)
            
        default:
            break
        }
        
        switch smokeDropMenu.selectedItem! {
            
        case TRANSLATION_SMOKER:
            addRiskFactor(uri: SMOKER, riskFactors: &riskFactors!)
            
        case TRANSLATION_FORMER_SMOKER:
            addRiskFactor(uri: FORMER_SMOKER, riskFactors: &riskFactors!)
            
        default:
            break;
        }
        
        switch schoolDropMenu.selectedItem! {
        case TRANSLATION_HIGH_SCHOOL_DIPLOMA:
            addRiskFactor(uri: HIGH_SCHOOL_DIPLOMA, riskFactors: &riskFactors!)
        case TRANSLATION_NO_HIGH_SCHOOL_DIPLOMA:
            addRiskFactor(uri: NO_HIGH_SCHOOL_DIPLOMA, riskFactors: &riskFactors!)
        default:
            break;
        }
        
        validateFrequencyDropMenu(dropMenu: cryDropMenu, riskUri: CRY_EASILY, riskFactors: &riskFactors!)
        
        validateFrequencyDropMenu(dropMenu: angryDropMenu, riskUri: CRITICAL_OF_OTHERS, riskFactors: &riskFactors!)
        
        validateFrequencyDropMenu(dropMenu: anxietyDropMenu, riskUri: FEARFUL, riskFactors: &riskFactors!)
        
        
        UserManager.instance.person.hasRiskFactor = riskFactors
    }
    
    func validateFrequencyDropMenu(dropMenu: DKDropMenu, riskUri: String, riskFactors: inout [HasRiskFactor]) {
        
        if (dropMenu.selectedItem == TRANSLATION_OFTEN_OR_ALWAYS) {
            addRiskFactor(uri: riskUri, riskFactors: &riskFactors)
        }
    }
    
    func setDropMenuAttributes(dropMenu: DKDropMenu, items: [String]) {
        dropMenu.selectedColor = .gray
        dropMenu.textColor = .black
        dropMenu.itemHeight = 30
        dropMenu.add(names: items)
        dropMenu.delegate = self
    }
 
    @IBAction func saveAction(_ sender: UIButton) {
        removeModifiableRiskFactors()
        validateForm()
        UserManager.instance.savePerson()
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

