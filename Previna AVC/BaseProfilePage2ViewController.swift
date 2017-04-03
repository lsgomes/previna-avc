//
//  BaseProfilePage2ViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 3/27/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit

class BaseProfilePage2ViewController {

    var cryDropMenu: DKDropMenu!
    var angryDropMenu: DKDropMenu!
    var anxietyDropMenu: DKDropMenu!
    
    var schoolDropMenu: DKDropMenu!
    var physicalActivityDropMenu: DKDropMenu!
    var alcoholDropMenu: DKDropMenu!
    var smokeDropMenu: DKDropMenu!
    
    var delegate: DKDropMenuDelegate!
    
    // MARK: Translations
    let TRANSLATION_INACTIVE = "Sedentário"
    let TRANSLATION_ACTIVE = "1-2 por semana"
    let TRANSLATION_VERY_ACTIVE = "3+ por semana"
    
    let TRANSLATION_ABSTAIN = "Abstenho"
    let TRANSLATION_DRINKER = "7+ por semana"
    let TRANSLATION_FORMER_ALCOHOLIC = "Ex-álcoolatra"
    let TRANSLATION_DRINK_IN_MODERATION = "1-6 por semana"
    
    let TRANSLATION_SMOKER = "Fumante"
    let TRANSLATION_FORMER_SMOKER = "Ex-fumante"
    let TRANSLATION_NEVER_SMOKED = "Não-fumante"
    
    let TRANSLATION_HIGH_SCHOOL_DIPLOMA = "Ensino médio"
    let TRANSLATION_NO_HIGH_SCHOOL_DIPLOMA = "Ensino fundamental"
    let TRANSLATION_COLLEGE_DIPLOMA = "Ensino superior"
    
    let TRANSLATION_OFTEN_OR_ALWAYS = "Muitas vezes"
    let TRANSLATION_SOMETIMES_OR_NEVER = "Às vezes"
    
    let riskFactors = [RiskFactor.ACTIVE.rawValue]
    
    public init( delegate: DKDropMenuDelegate, physicalActivityDropMenu: DKDropMenu, alcoholDropMenu:  DKDropMenu, smokeDropMenu:  DKDropMenu, schoolDropMenu: DKDropMenu, cryDropMenu: DKDropMenu, angryDropMenu: DKDropMenu, anxietyDropMenu: DKDropMenu ) {
        
        self.delegate = delegate
        
        self.cryDropMenu = cryDropMenu
        self.angryDropMenu = angryDropMenu
        self.anxietyDropMenu = anxietyDropMenu
        
        self.schoolDropMenu = schoolDropMenu
        self.physicalActivityDropMenu = physicalActivityDropMenu
        self.alcoholDropMenu = alcoholDropMenu
        self.smokeDropMenu = smokeDropMenu
        
    }
  
    public func setupViewDidLoad(setSelectedItemForDropMenus: Bool) {
        
        
        setDropMenuAttributes(dropMenu: physicalActivityDropMenu, items: [TRANSLATION_VERY_ACTIVE, TRANSLATION_ACTIVE, TRANSLATION_INACTIVE], delegate: delegate)

        
        setDropMenuAttributes(dropMenu: alcoholDropMenu, items: [TRANSLATION_DRINK_IN_MODERATION, TRANSLATION_DRINKER, TRANSLATION_ABSTAIN, TRANSLATION_FORMER_ALCOHOLIC], delegate: delegate)
        
        setDropMenuAttributes(dropMenu: smokeDropMenu, items: [TRANSLATION_NEVER_SMOKED, TRANSLATION_SMOKER, TRANSLATION_FORMER_SMOKER], delegate: delegate)

        
        setDropMenuAttributes(dropMenu: schoolDropMenu, items: [TRANSLATION_COLLEGE_DIPLOMA, TRANSLATION_HIGH_SCHOOL_DIPLOMA, TRANSLATION_NO_HIGH_SCHOOL_DIPLOMA], delegate: delegate)

        
        setDropMenuAttributes(dropMenu: cryDropMenu, items: [TRANSLATION_OFTEN_OR_ALWAYS, TRANSLATION_SOMETIMES_OR_NEVER], delegate: delegate)

        
        setDropMenuAttributes(dropMenu: angryDropMenu, items: [TRANSLATION_OFTEN_OR_ALWAYS, TRANSLATION_SOMETIMES_OR_NEVER], delegate: delegate)

        
        setDropMenuAttributes(dropMenu: anxietyDropMenu, items: [TRANSLATION_OFTEN_OR_ALWAYS, TRANSLATION_SOMETIMES_OR_NEVER], delegate: delegate)
        
        // BS
        
        if (setSelectedItemForDropMenus) {
            
            dropMenuSetSelectedItem(riskFactor: RiskFactor.ACTIVE.rawValue, selectItem: TRANSLATION_ACTIVE, dropMenu: physicalActivityDropMenu)
            dropMenuSetSelectedItem(riskFactor: RiskFactor.INACTIVE.rawValue, selectItem: TRANSLATION_INACTIVE, dropMenu: physicalActivityDropMenu)
            
            dropMenuSetSelectedItem(riskFactor: RiskFactor.DRINKER.rawValue, selectItem: TRANSLATION_DRINKER, dropMenu: alcoholDropMenu)
            dropMenuSetSelectedItem(riskFactor: RiskFactor.ABSTAIN.rawValue, selectItem: TRANSLATION_ABSTAIN, dropMenu: alcoholDropMenu)
            dropMenuSetSelectedItem(riskFactor: RiskFactor.FORMER_ALCOHOLIC.rawValue, selectItem: TRANSLATION_FORMER_ALCOHOLIC, dropMenu: alcoholDropMenu)
            
            dropMenuSetSelectedItem(riskFactor: RiskFactor.SMOKER.rawValue, selectItem: TRANSLATION_SMOKER, dropMenu: smokeDropMenu)
            dropMenuSetSelectedItem(riskFactor: RiskFactor.FORMER_SMOKER.rawValue, selectItem: TRANSLATION_FORMER_SMOKER, dropMenu: smokeDropMenu)
            
            dropMenuSetSelectedItem(riskFactor: RiskFactor.HIGH_SCHOOL_DIPLOMA.rawValue, selectItem: TRANSLATION_HIGH_SCHOOL_DIPLOMA, dropMenu: schoolDropMenu)
            dropMenuSetSelectedItem(riskFactor: RiskFactor.NO_HIGH_SCHOOL_DIPLOMA.rawValue, selectItem: TRANSLATION_NO_HIGH_SCHOOL_DIPLOMA, dropMenu: schoolDropMenu)
            
            
            dropMenuSetSelectedItem(riskFactor: RiskFactor.CRY_EASILY.rawValue, selectItem: TRANSLATION_OFTEN_OR_ALWAYS, dropMenu: cryDropMenu)
            dropMenuSetSelectedItem(riskFactor: RiskFactor.CRITICAL_OF_OTHERS.rawValue, selectItem: TRANSLATION_OFTEN_OR_ALWAYS, dropMenu: angryDropMenu)
            dropMenuSetSelectedItem(riskFactor: RiskFactor.FEARFUL.rawValue, selectItem: TRANSLATION_OFTEN_OR_ALWAYS, dropMenu: anxietyDropMenu)

        }
        
        gatherInformationFromHealthKit()
    }
    
    func setDropMenuAttributes(dropMenu: DKDropMenu, items: [String], delegate: DKDropMenuDelegate) {
        dropMenu.selectedColor = .gray
        //dropMenu.textColor =
        dropMenu.itemHeight = 30
        dropMenu.add(names: items)
        dropMenu.delegate = delegate
    }
    
    func dropMenuSetSelectedItem(riskFactor: String, selectItem: String, dropMenu: DKDropMenu) {
        
        let riskFactors = UserManager.instance.person.hasRiskFactor!
        
        if riskFactors.contains(where: { $0.uri == riskFactor }) {
            dropMenu.selectedItem = selectItem
        }
    }
    
    func gatherInformationFromHealthKit() {
        
        HealthKitManager.instance.retrieveWeekSteps() { steps in
            
            guard let steps = steps else { return }

            if (steps < 5000) {
                
                self.physicalActivityDropMenu.selectedItem = self.TRANSLATION_INACTIVE
            }
            else if (steps >= 12500) {
                
                self.physicalActivityDropMenu.selectedItem = self.TRANSLATION_VERY_ACTIVE

            }
            else if (steps >= 5000) {
                self.physicalActivityDropMenu.selectedItem = self.TRANSLATION_ACTIVE

            }
            
            self.physicalActivityDropMenu.setNeedsDisplay()
            
            print("Setting physicalActivityDropMenu to \(self.physicalActivityDropMenu.selectedItem)")
            
            // notify user UP DOWN
        }
        
        HealthKitManager.instance.retrieveWeekAlcohol() { alcohol in
            
            guard let alcohol = alcohol else { return }
            
            if (alcohol > 0.0006) {
                self.alcoholDropMenu.selectedItem = self.TRANSLATION_DRINKER
            }
            else if (alcohol >= 0.00012 && alcohol < 0.00025) {
                self.alcoholDropMenu.selectedItem = self.TRANSLATION_DRINK_IN_MODERATION

            }
            else if (alcohol < 0.00012) {
                self.alcoholDropMenu.selectedItem = self.TRANSLATION_ABSTAIN

            }
            
            self.alcoholDropMenu.setNeedsDisplay()
            
            print("Setting alcoholDropMenu to \(self.alcoholDropMenu.selectedItem)")

            // notify USER up down
        }
    }
    
    public func collapseChanged(dropMenu: DKDropMenu, collapsed: Bool) {
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
        
        removeRiskFactor(name: RiskFactor.DRINKER.rawValue, riskFactors: &riskFactors)
        removeRiskFactor(name: RiskFactor.ABSTAIN.rawValue, riskFactors: &riskFactors)
        removeRiskFactor(name: RiskFactor.FORMER_ALCOHOLIC.rawValue, riskFactors: &riskFactors)
        removeRiskFactor(name: RiskFactor.DRINK_IN_MODERATION.rawValue, riskFactors: &riskFactors)
        
        removeRiskFactor(name: RiskFactor.ACTIVE.rawValue, riskFactors: &riskFactors)
        removeRiskFactor(name: RiskFactor.INACTIVE.rawValue, riskFactors: &riskFactors)
        removeRiskFactor(name: RiskFactor.VERY_ACTIVE.rawValue, riskFactors: &riskFactors)

        removeRiskFactor(name: RiskFactor.SMOKER.rawValue, riskFactors: &riskFactors)
        removeRiskFactor(name: RiskFactor.FORMER_SMOKER.rawValue, riskFactors: &riskFactors)
        removeRiskFactor(name: RiskFactor.NEVER_SMOKED.rawValue, riskFactors: &riskFactors)
        
        removeRiskFactor(name: RiskFactor.HIGH_SCHOOL_DIPLOMA.rawValue, riskFactors: &riskFactors)
        removeRiskFactor(name: RiskFactor.NO_HIGH_SCHOOL_DIPLOMA.rawValue, riskFactors: &riskFactors)
        
        
        removeRiskFactor(name: RiskFactor.CRY_EASILY.rawValue, riskFactors: &riskFactors)
        removeRiskFactor(name: RiskFactor.CRITICAL_OF_OTHERS.rawValue, riskFactors: &riskFactors)
        removeRiskFactor(name: RiskFactor.FEARFUL.rawValue, riskFactors: &riskFactors)
        
        removeRiskFactor(name: RiskFactor.NOT_CRYING_EASILY.rawValue, riskFactors: &riskFactors)
        removeRiskFactor(name: RiskFactor.NOT_CRITICAL_OF_OTHERS.rawValue, riskFactors: &riskFactors)
        removeRiskFactor(name: RiskFactor.NOT_FEARFUL.rawValue, riskFactors: &riskFactors)
        
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
            addRiskFactor(uri: RiskFactor.DRINKER.rawValue, riskFactors: &riskFactors!)
            
        case TRANSLATION_ABSTAIN:
            addRiskFactor(uri: RiskFactor.ABSTAIN.rawValue, riskFactors: &riskFactors!)
            
        case TRANSLATION_FORMER_ALCOHOLIC:
            addRiskFactor(uri: RiskFactor.FORMER_ALCOHOLIC.rawValue, riskFactors: &riskFactors!)
        
        case TRANSLATION_DRINK_IN_MODERATION:
            addRiskFactor(uri: RiskFactor.DRINK_IN_MODERATION.rawValue, riskFactors: &riskFactors!)
        default:
            break
        }
        
        switch physicalActivityDropMenu.selectedItem! {
            
        case TRANSLATION_ACTIVE:
            addRiskFactor(uri: RiskFactor.ACTIVE.rawValue, riskFactors: &riskFactors!)
            
        case TRANSLATION_INACTIVE:
            addRiskFactor(uri: RiskFactor.INACTIVE.rawValue, riskFactors: &riskFactors!)
            
        case TRANSLATION_VERY_ACTIVE:
            addRiskFactor(uri: RiskFactor.VERY_ACTIVE.rawValue, riskFactors: &riskFactors!)
            
        default:
            break
        }
        
        switch smokeDropMenu.selectedItem! {
            
        case TRANSLATION_SMOKER:
            addRiskFactor(uri: RiskFactor.SMOKER.rawValue, riskFactors: &riskFactors!)
            
        case TRANSLATION_FORMER_SMOKER:
            addRiskFactor(uri: RiskFactor.FORMER_SMOKER.rawValue, riskFactors: &riskFactors!)

        case TRANSLATION_NEVER_SMOKED:
            addRiskFactor(uri: RiskFactor.NEVER_SMOKED.rawValue, riskFactors: &riskFactors!)
            
        default:
            break;
        }
        
        switch schoolDropMenu.selectedItem! {
        case TRANSLATION_HIGH_SCHOOL_DIPLOMA:
            addRiskFactor(uri: RiskFactor.HIGH_SCHOOL_DIPLOMA.rawValue, riskFactors: &riskFactors!)
        case TRANSLATION_NO_HIGH_SCHOOL_DIPLOMA:
            addRiskFactor(uri: RiskFactor.NO_HIGH_SCHOOL_DIPLOMA.rawValue, riskFactors: &riskFactors!)
        default:
            break;
        }
        
        switch cryDropMenu.selectedItem! {
            
        case TRANSLATION_OFTEN_OR_ALWAYS:
            addRiskFactor(uri: RiskFactor.CRY_EASILY.rawValue, riskFactors: &riskFactors!)
        case TRANSLATION_SOMETIMES_OR_NEVER:
            addRiskFactor(uri: RiskFactor.NOT_CRYING_EASILY.rawValue, riskFactors: &riskFactors!)
        default:
            break;
        }
        
        
        switch angryDropMenu.selectedItem! {
            
        case TRANSLATION_OFTEN_OR_ALWAYS:
            addRiskFactor(uri: RiskFactor.CRITICAL_OF_OTHERS.rawValue, riskFactors: &riskFactors!)
        case TRANSLATION_SOMETIMES_OR_NEVER:
            addRiskFactor(uri: RiskFactor.NOT_CRITICAL_OF_OTHERS.rawValue, riskFactors: &riskFactors!)
        default:
            break;
        }
        
        switch anxietyDropMenu.selectedItem! {
            
        case TRANSLATION_OFTEN_OR_ALWAYS:
            addRiskFactor(uri: RiskFactor.FEARFUL.rawValue, riskFactors: &riskFactors!)
        case TRANSLATION_SOMETIMES_OR_NEVER:
            addRiskFactor(uri: RiskFactor.NOT_FEARFUL.rawValue, riskFactors: &riskFactors!)
        default:
            break;
        }
        
        UserManager.instance.person.hasRiskFactor = riskFactors
    }
    
    
    func validateFormSavePerson() {
        
        validateForm()
        UserManager.instance.savePerson()
    }


}
