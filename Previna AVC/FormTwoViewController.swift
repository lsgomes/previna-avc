//
//  FormTwoViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 4/9/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit
import Eureka
import SwiftyDrop

class FormTwoViewController: FormViewController {

    var identifiedRiskFactors: [String] = [String]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {

            if (!self.identifiedRiskFactors.isEmpty) {
            
                var phrase: String = ""
            
                for text in self.identifiedRiskFactors {
                    let texty = text + ", "
                    phrase = phrase + texty
                }
            
                let dropLast = String(phrase.characters.dropLast(2))
            
                Drop.down(NSLocalizedString("Obtained information", comment: "") + " \(dropLast)", state: Custom.Pink, duration: 7.0)
            
            }
        }
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        identifiedRiskFactors.removeAll()
        
        if self.parent?.restorationIdentifier == "navForPerfil" {
            let buttonRow: ButtonRow = form.rowBy(tag: "buttonRow")!
            buttonRow.title = NSLocalizedString("Save", comment: "")
            let section: Section = form.sectionBy(tag: "section1")!
            let headerView = section.header?.viewForSection(section, type: .header) as! HeaderView
            headerView.noteText.text = "📝 " + NSLocalizedString("If any risk factor has changed, update here", comment: "")
            setMenusWithDataFromPerson()
        }
        
        updateWithHealthKitDataSteps()
        updateWithHealthKitAlcohol()
        updateWithHealthKitData()
        
//        navigationController?.navigationBar.topItem?.title = "Perfil"
//        navigationController?.navigationItem.title =  "Perfil"
        self.navigationItem.title = NSLocalizedString("Profile", comment: "")
        self.parent?.navigationItem.title = NSLocalizedString("Profile", comment: "")
        self.parent?.navigationController?.navigationBar.topItem?.title = NSLocalizedString("Profile", comment: "")
        self.parent?.navigationController?.navigationItem.title = NSLocalizedString("Profile", comment: "")

       


    }
    
    func setMenusWithDataFromPerson() {
        
        
        setMenuSelectedItem(riskFactor: RiskFactor.ACTIVE.rawValue, selectItem: TRANSLATION_ACTIVE, rowName: "activityRow")
        setMenuSelectedItem(riskFactor: RiskFactor.INACTIVE.rawValue, selectItem: TRANSLATION_INACTIVE, rowName: "activityRow")
        setMenuSelectedItem(riskFactor: RiskFactor.VERY_ACTIVE.rawValue, selectItem: TRANSLATION_VERY_ACTIVE, rowName: "activityRow")

        
        setMenuSelectedItem(riskFactor: RiskFactor.DRINK_IN_MODERATION.rawValue, selectItem: TRANSLATION_DRINK_IN_MODERATION, rowName: "alcoholRow")
        setMenuSelectedItem(riskFactor: RiskFactor.DRINKER.rawValue, selectItem: TRANSLATION_DRINKER, rowName: "alcoholRow")
        setMenuSelectedItem(riskFactor: RiskFactor.ABSTAIN.rawValue, selectItem: TRANSLATION_ABSTAIN, rowName: "alcoholRow")
        setMenuSelectedItem(riskFactor: RiskFactor.FORMER_ALCOHOLIC.rawValue, selectItem: TRANSLATION_FORMER_ALCOHOLIC, rowName: "alcoholRow")
        
        setMenuSelectedItem(riskFactor: RiskFactor.SMOKER.rawValue, selectItem: TRANSLATION_SMOKER, rowName: "smokeRow")
        setMenuSelectedItem(riskFactor: RiskFactor.FORMER_SMOKER.rawValue, selectItem: TRANSLATION_FORMER_SMOKER, rowName: "smokeRow")
        setMenuSelectedItem(riskFactor: RiskFactor.NEVER_SMOKED.rawValue, selectItem: TRANSLATION_NEVER_SMOKED, rowName: "smokeRow")

        
        setMenuSelectedItem(riskFactor: RiskFactor.CRY_EASILY.rawValue, selectItem: TRANSLATION_OFTEN_OR_ALWAYS, rowName: "cryRow")
        setMenuSelectedItem(riskFactor: RiskFactor.NOT_CRYING_EASILY.rawValue, selectItem: TRANSLATION_SOMETIMES, rowName: "cryRow")

        
        setMenuSelectedItem(riskFactor: RiskFactor.CRITICAL_OF_OTHERS.rawValue, selectItem: TRANSLATION_OFTEN_OR_ALWAYS, rowName: "angryRow")
        setMenuSelectedItem(riskFactor: RiskFactor.NOT_CRITICAL_OF_OTHERS.rawValue, selectItem: TRANSLATION_SOMETIMES, rowName: "angryRow")

        
        setMenuSelectedItem(riskFactor: RiskFactor.FEARFUL.rawValue, selectItem: TRANSLATION_OFTEN_OR_ALWAYS, rowName: "anxietyRow")
        setMenuSelectedItem(riskFactor: RiskFactor.NOT_FEARFUL.rawValue, selectItem: TRANSLATION_SOMETIMES, rowName: "anxietyRow")

    }
    
    
    func setMenuSelectedItem(riskFactor: String, selectItem: String, rowName: String) {
        
        if let riskFactors = UserManager.instance.person.hasRiskFactor {
            
            if riskFactors.contains(where: { $0.uri == riskFactor }) {
                let row = form.rowBy(tag: rowName)
                row?.baseValue = selectItem
            }

        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map = [TRANSLATION_DRINKER: RiskFactor.DRINKER.rawValue,
               TRANSLATION_DRINK_IN_MODERATION: RiskFactor.DRINK_IN_MODERATION.rawValue,
               TRANSLATION_ABSTAIN: RiskFactor.ABSTAIN.rawValue,
               TRANSLATION_FORMER_ALCOHOLIC: RiskFactor.FORMER_ALCOHOLIC.rawValue,
        
               TRANSLATION_VERY_ACTIVE: RiskFactor.VERY_ACTIVE.rawValue,
               TRANSLATION_ACTIVE: RiskFactor.ACTIVE.rawValue,
               TRANSLATION_INACTIVE: RiskFactor.INACTIVE.rawValue,
        
               TRANSLATION_NEVER_SMOKED: RiskFactor.NEVER_SMOKED.rawValue,
               TRANSLATION_SMOKER: RiskFactor.SMOKER.rawValue,
               TRANSLATION_FORMER_SMOKER: RiskFactor.FORMER_SMOKER.rawValue,
               
               TRANSLATION_HIGH_SCHOOL_DIPLOMA: RiskFactor.HIGH_SCHOOL_DIPLOMA.rawValue,
               TRANSLATION_NO_HIGH_SCHOOL_DIPLOMA: RiskFactor.NO_HIGH_SCHOOL_DIPLOMA.rawValue
        ]
        
        //tableView?.isScrollEnabled = false
        //tableView?.bounces = false
        view.backgroundColor = .white
//        self.navigationItem.title = "Perfil"
//        navigationController?.navigationBar.topItem?.title = "Perfil"
//        navigationController?.navigationItem.title =  "Perfil"
        
        TRANSLATION_FREQUENCY =
            [TRANSLATION_OFTEN_OR_ALWAYS,
             TRANSLATION_SOMETIMES,
             TRANSLATION_NEVER]

        form +++ Section()
            { section in
                section.tag = "section1"
                var header = HeaderFooterView<HeaderView>(.class)
                header.height = {107}
                
                header.onSetupView = { view, _ in
                    
                    if self.parent?.restorationIdentifier == "navForPerfil" {
                        view.noteText.text = "📝 " + NSLocalizedString("If any risk factor has changed, update here", comment: "")
                    }
                    else {
                        view.noteText.text = "📝 " + NSLocalizedString("Fill in the following fields to complete your profile", comment: "")
                    }
                        //saveButton.setTitle("CONCLUIR", for: .normal)
                }
                
                section.header = header
            }

            <<< createRow("alcoholRow", "🍺 " + NSLocalizedString("Alcohol", comment: ""),
                               [TRANSLATION_DRINKER,
                               TRANSLATION_DRINK_IN_MODERATION,
                               TRANSLATION_ABSTAIN,
                               TRANSLATION_FORMER_ALCOHOLIC])
        
//            <<< createRow("activityRow", "🚶 Atividade física:",
//                               [TRANSLATION_VERY_ACTIVE,
//                                TRANSLATION_ACTIVE,
//                                TRANSLATION_INACTIVE])
            <<< PickerInputRow<String>("activityRow") {
                $0.title = "🚶 " + NSLocalizedString("Physical activity", comment: "")
                //$0.selectorTitle = "Selecione uma opção:"
                $0.options = [TRANSLATION_VERY_ACTIVE,
                              TRANSLATION_ACTIVE,
                              TRANSLATION_INACTIVE]
                $0.value = $0.options.first    // initially selected
            }
            <<< createRow("angryRow", "😡 " + NSLocalizedString("Angry", comment: ""), TRANSLATION_FREQUENCY)
        
            <<< createRow("anxietyRow", "😨 " + NSLocalizedString("Anxiety", comment: ""), TRANSLATION_FREQUENCY)
        
            <<< createRow("cryRow", "😭 " + NSLocalizedString("Cry", comment: ""), TRANSLATION_FREQUENCY)
        
            <<< createRow("smokeRow", "🚬 " + NSLocalizedString("Smoke", comment: ""),
                               [TRANSLATION_NEVER_SMOKED,
                                TRANSLATION_SMOKER,
                                TRANSLATION_FORMER_SMOKER])
//            <<< createRow("educationRow","📖 Educação:",
//                          [TRANSLATION_COLLEGE_DIPLOMA,
//                           TRANSLATION_HIGH_SCHOOL_DIPLOMA,
//                           TRANSLATION_NO_HIGH_SCHOOL_DIPLOMA])
            
            <<< PickerInputRow<String>("educationRow") {
                if self.parent?.restorationIdentifier == "navForPerfil" {
                    $0.hidden = true
                }
                $0.title = "📖 " + NSLocalizedString("Education", comment: "")
                //$0.selectorTitle = "Selecione uma opção:"
                $0.options = [TRANSLATION_COLLEGE_DIPLOMA,
                              TRANSLATION_HIGH_SCHOOL_DIPLOMA,
                              TRANSLATION_NO_HIGH_SCHOOL_DIPLOMA]
                $0.value = $0.options.first    // initially selected
            }

        
            <<< ButtonRow("buttonRow") { button in
                button.title = NSLocalizedString("CONTINUE", comment: "")
                }.cellSetup { cell, _ in
                    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
                    cell.backgroundColor = UIColor(red:0.98, green:0.19, blue:0.41, alpha:1.0)
                    cell.tintColor = UIColor.white
                }.onCellSelection { cell, row in
                    
                    let canUpdateProfile = self.parent?.restorationIdentifier == "navForPerfil"
                    
                    self.validateForm(deleteModifiableRisks: canUpdateProfile)
                    
                    UserManager.instance.savePerson()

                    if (!canUpdateProfile) {
                        //self.performSegue(withIdentifier: "formTwoSegue", sender: nil)
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        //TabBarController
                        // vc is the Storyboard ID that you added
                        // as! ... Add your ViewController class name that you want to navigate to
                        let controller = storyboard.instantiateViewController(withIdentifier: "navControl") as! UINavigationController
                        self.present(controller, animated: true, completion: { () -> Void in
                        })
                        
                    }
//                    let navigationController = self.parent as! UINavigationController
//                    let pageViewController = navigationController.parent as! WizardPageViewController
//                    pageViewController.segueToPage(name: WizardPageViewController.PAGE_4)
                }
        
        if (self.parent?.restorationIdentifier == "navForPerfil") {
            
            let education = form.rowBy(tag: "educationRow") as PickerInputRow<String>!
            education!.hidden = true
        }

    }
    
    func updateWithHealthKitDataSteps() {
        
        HealthKitManager.instance.retrieveWeekSteps() { steps in
            
            guard let steps = steps else { return }
            
            let row = self.form.rowBy(tag: "activityRow") as! PickerInputRow<String>
            
            if (steps < 5000) {
                
                row.value = self.TRANSLATION_INACTIVE
                row.baseValue = self.TRANSLATION_INACTIVE

                
            }
            else if (steps >= 12500) {
                
                row.value = self.TRANSLATION_VERY_ACTIVE
                row.baseValue = self.TRANSLATION_VERY_ACTIVE

                
            }
            else if (steps >= 5000) {
                
                row.value = self.TRANSLATION_ACTIVE
                row.baseValue = self.TRANSLATION_ACTIVE

            }
            
            self.identifiedRiskFactors.append(NSLocalizedString("physical activity", comment: "") + " \(row.value!.lowercased())")

            UserManager.instance.person.hasStepsCount = String(describing: steps)
            print("HealthKit: setting person.hasStepsCount to \(steps)")

            print("HealthKit: setting activityRow to \(row.value!)")
            //row.updateCell()
            
            
            
            DispatchQueue.main.async {
                
                row.reload()
                //Drop.down("Atividade física identificada: \(row.value!)", state: Custom.Pink)
            }
            
            
            // notify user UP DOWN
        }

    }
    
    func updateWithHealthKitAlcohol() {
        
        
        HealthKitManager.instance.retrieveWeekAlcohol() { alcohol in
            
            guard let alcohol = alcohol else { return }
            
            let row = self.form.rowBy(tag: "alcoholRow") as! PickerInputRow<String>

            if (alcohol > 0.0006) {
                row.value = self.TRANSLATION_DRINKER

                row.baseValue = self.TRANSLATION_DRINKER
            }
            else if (alcohol >= 0.00012 && alcohol < 0.00025) {
                row.baseValue = self.TRANSLATION_DRINK_IN_MODERATION
                row.value = self.TRANSLATION_DRINK_IN_MODERATION

                
            }
            else if (alcohol < 0.00012) {
                row.baseValue = self.TRANSLATION_ABSTAIN
                row.value = self.TRANSLATION_ABSTAIN

                
            }

            self.identifiedRiskFactors.append(NSLocalizedString("alcohol consumption", comment: "") + " \(row.value!.lowercased())")
	
            UserManager.instance.person.hasBloodAlcoholContent = String(describing: alcohol * 100)
            print("HealthKit: setting person.hasBloodAlcoholContent to \(alcohol * 100)")

            
            print("Setting alcoholRow to \(row.value!)")
            
            DispatchQueue.main.async {
                
                row.reload()
                //Drop.down("Consumo de álcool identificado: \(row.value!)", state: Custom.Pink)

            }
            // notify USER up down
        }
    }
    
    func updateWithHealthKitData() {
        
        
        HealthKitManager.instance.getDiabetes() { hasDiabetes, glucose, error in
            
            if (error != nil) {
                return
            }
            
            if let glucose = glucose {
                UserManager.instance.person.hasBloodGlucose = String(describing: glucose)
                
                print("HealthKit: setting person.hasBloodGlucose to \(glucose)")
            }
            
  

        }
        
        HealthKitManager.instance.getHighBloodPressure() { hasHighBloodPressure, pressure, error in
            
            if (error != nil) {
                return
            }
 
            if let pressure = pressure {
                
                UserManager.instance.person.hasBloodPressure = pressure
                
                print("HealthKit: setting person.hasBloodPressure to \(pressure)")

            }
            
       
        }
        
    }

    
    func validateForm(deleteModifiableRisks: Bool) {
        
        if (deleteModifiableRisks)
        {
            for risk in UserManager.instance.person.hasRiskFactor! {
                if (risk.uri != RiskFactor.HIGH_SCHOOL_DIPLOMA.rawValue &&
                    risk.uri != RiskFactor.NO_HIGH_SCHOOL_DIPLOMA.rawValue &&
                    map.values.contains(risk.uri!))
                {
                    UserManager.instance.removeRiskFactor(name: risk.uri!)
                }
                
            }
            
            UserManager.instance.removeRiskFactor(name: RiskFactor.CRY_EASILY.rawValue)
            UserManager.instance.removeRiskFactor(name: RiskFactor.CRITICAL_OF_OTHERS.rawValue)
            UserManager.instance.removeRiskFactor(name: RiskFactor.FEARFUL.rawValue)
            
            UserManager.instance.removeRiskFactor(name: RiskFactor.NOT_CRYING_EASILY.rawValue)
            UserManager.instance.removeRiskFactor(name: RiskFactor.NOT_CRITICAL_OF_OTHERS.rawValue)
            UserManager.instance.removeRiskFactor(name: RiskFactor.NOT_FEARFUL.rawValue)


        }
        
        let values = form.values()
                
        for value in values.keys {
            validateRiskFactor(value, values)
        }
        
        validateFrequency("angryRow", RiskFactor.CRITICAL_OF_OTHERS.rawValue, elseRisk: RiskFactor.NOT_CRITICAL_OF_OTHERS.rawValue, values)
        
        validateFrequency("anxietyRow", RiskFactor.FEARFUL.rawValue, elseRisk: RiskFactor.NOT_FEARFUL.rawValue, values)
        
        validateFrequency("cryRow", RiskFactor.CRY_EASILY.rawValue, elseRisk: RiskFactor.NOT_CRYING_EASILY.rawValue, values)
       
        
    }
    
    func validateRiskFactor(_ rowName: String, _ dict: [String: Any?]) {
        
        if let selectedRow = dict[rowName] as! String! {
            if let riskFactor = map[selectedRow] {
                print("rowName: \(rowName) selectedRow: \(selectedRow)")
                UserManager.instance.addRiskFactor(uri: riskFactor)
            }
        }
    }
    
    func validateFrequency(_ rowName: String, _ riskFactor: String, elseRisk: String, _ dict: [String: Any?]) {
        if let selectedRow = dict[rowName] as! String!
        {
            print("rowName: \(rowName) selectedRow: \(selectedRow)")
            if (selectedRow == TRANSLATION_OFTEN_OR_ALWAYS) {
                UserManager.instance.addRiskFactor(uri: riskFactor)
            } else {
                UserManager.instance.addRiskFactor(uri: elseRisk)
            }
        }
    }
    
    func createRow(_ tag: String, _ title: String, _ options: [String]) -> PickerInputRow<String> {
    
        let alertRow = PickerInputRow<String>(tag) {
            $0.title = title
            //$0.selectorTitle = "Selecione uma opção:"
            $0.options = options
            $0.value = options.first    // initially selected
        }
        
        return alertRow;
    
    }

    // MARK: Translations
    let TRANSLATION_INACTIVE = NSLocalizedString("Sedentary", comment: "")
    let TRANSLATION_ACTIVE = NSLocalizedString("1-2 per week", comment: "")
    let TRANSLATION_VERY_ACTIVE = NSLocalizedString("3+ per week", comment: "")
    
    let TRANSLATION_ABSTAIN = NSLocalizedString("Abstain", comment: "")
    let TRANSLATION_DRINKER = NSLocalizedString("7+ per week", comment: "")
    let TRANSLATION_FORMER_ALCOHOLIC = NSLocalizedString("Former alcoholic", comment: "")
    let TRANSLATION_DRINK_IN_MODERATION = NSLocalizedString("1-6 per week", comment: "")
    
    let TRANSLATION_SMOKER = NSLocalizedString("Smoker", comment: "")
    let TRANSLATION_FORMER_SMOKER = NSLocalizedString("Former smoker", comment: "")
    let TRANSLATION_NEVER_SMOKED = NSLocalizedString("Non-smoker", comment: "")
    
    let TRANSLATION_HIGH_SCHOOL_DIPLOMA = NSLocalizedString("High school diploma", comment: "")
    let TRANSLATION_NO_HIGH_SCHOOL_DIPLOMA = NSLocalizedString("No high school diploma", comment: "")
    let TRANSLATION_COLLEGE_DIPLOMA = NSLocalizedString("College diploma", comment: "")
    
    let TRANSLATION_OFTEN_OR_ALWAYS = NSLocalizedString("Many times", comment: "")
    let TRANSLATION_SOMETIMES = NSLocalizedString("Sometimes", comment: "")
    let TRANSLATION_NEVER = NSLocalizedString("Never", comment: "")
    
    var TRANSLATION_FREQUENCY : [String] = []
    
    var map : [String : String] = [:]
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


enum Custom: DropStatable {
    case Pink
    var backgroundColor: UIColor? {
        switch self {
        case .Pink: return UIColor(red:0.98, green:0.19, blue:0.41, alpha:1.0)
        }
    }
    var font: UIFont? {
        switch self {
        case .Pink: return UIFont.systemFont(ofSize: 15)
        }
    }
    var textColor: UIColor? {
        switch self {
        case .Pink: return UIColor.white
        }
    }
    var blurEffect: UIBlurEffect? {
        switch self {
        case .Pink: return nil
        }
    }
}
