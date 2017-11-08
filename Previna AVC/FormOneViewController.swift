//
//  FormOneViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 4/10/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit
import Eureka
import SwiftyDrop

class FormOneViewController: FormViewController {
    
    var sbPageControl: UIPageControl!
    
    var identifiedRiskFactors: [String] = [String]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        if (!identifiedRiskFactors.isEmpty) {
            
            var phrase: String = ""
            
            for text in identifiedRiskFactors {
                let texty = text + ", "
                phrase = phrase + texty
            }
            
            let dropLast = String(phrase.characters.dropLast(2))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                Drop.down(NSLocalizedString("Obtained information", comment: "") + " \(dropLast)", state: Custom.Pink, duration: 7.0)
            }
        }

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //setTableViewDistance()
        
//        for constraint in view.constraints {
//            print(constraint)
//        }
        
        self.navigationItem.title = NSLocalizedString("Profile", comment: "")
//        
//        let navigationController = self.parent as! UINavigationController
//        let pageViewController = navigationController.parent as! WizardPageViewController
//        pageViewController.pageControl = UIPageControl.appearance(whenContainedInInstancesOf: [type(of: self)])
//        
        form +++ Section()
            { section in
            var header = HeaderFooterView<HeaderViewImage>(.class)
            header.height = {62}
            
            header.onSetupView = { view, _ in
                view.noteText.text = "📝 " + NSLocalizedString("Fill in the fields below to sign up", comment: "")
                //saveButton.setTitle("CONCLUIR", for: .normal)
            }
            
            section.header = header
            }

            <<< NameRow("nameRow") { row in
                row.title = "👤 " + NSLocalizedString("Name", comment: "")
                row.placeholder = NSLocalizedString("Type your name here", comment: "")
                row.cell.textLabel?.font = UIFont(name: row.cell.textLabel!.font!.fontName, size: 15)
                row.add(rule: RuleRequired())
                row.add(rule: RuleSpaces())
                row.validationOptions = .validatesAlways

            }
            .cellUpdate { cell, row in
                
                if (row.value != nil) {
                    let trimmed = row.value! as String
                    row.value = trimmed.trimmingCharacters(in: .whitespacesAndNewlines)

                   
                }
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                    
                }
            }
//            <<< IntRow("ageRow") { row in
//                row.title = "📆 Idade:"
//                row.placeholder = "Digite sua idade aqui"
//                row.cell.textLabel?.font = UIFont(name: row.cell.textLabel!.font!.fontName, size: 15)
//                if let age = Int(HealthKitManager.instance.getDateOfBirth())
//                {
//                row.baseValue = age
//                print("HealthKit: setting Age to \(age)")
//                }
//
//
//            }
            <<< PickerInputRow<Int>("ageRow") { row in
                row.title = "📆 " + NSLocalizedString("Age", comment: "")
                
                var ages: [Int] = []
                
                for i in 0...100 {
                    ages.append(i)
                }
                
                row.options = ages
                row.cell.textLabel?.font = UIFont(name: row.cell.textLabel!.font!.fontName, size: 15)
               
                if let age = Int(HealthKitManager.instance.getDateOfBirth())
                {
                    row.baseValue = age
                    row.value = age
                    print("HealthKit: setting Age to \(age)")
                    identifiedRiskFactors.append("\(age) " + NSLocalizedString("Years", comment: ""))
                    //DispatchQueue.main.async {
                        //Drop.down("Idade identificada: \(row.value!)", state: Custom.Pink, duration: 5.0)
                    //}
                }
                else {
                    row.baseValue = 18
                    row.value = 18
                }
                
            }

            <<< PickerInputRow<String>("sexRow") { row in
                row.title = "👫 " + NSLocalizedString("Sex", comment: "")
                row.options = [NSLocalizedString("Male", comment: ""), NSLocalizedString("Female", comment: "")]
                row.cell.textLabel?.font = UIFont(name: row.cell.textLabel!.font!.fontName, size: 15)
                
                let sex = HealthKitManager.instance.getBiologicalSex()
                if (!sex.isEmpty) {
                    row.value = sex
                    identifiedRiskFactors.append("\(sex.lowercased())")

//                    DispatchQueue.main.async {
//                    Drop.down("Sexo identificado: \(row.value!)", state: Custom.Pink, duration: 5.0)
//                    }

                } else {
                    row.value = row.options.first    // initially selected
                }
                print("HealthKit: setting Sex to \(sex)")

            }
            
            <<< createCheckRow("hypertensionRow", NSLocalizedString("Hypertension question", comment: ""))
            <<< createCheckRow("diabetesRow", NSLocalizedString("Diabetes question", comment: ""))
            <<< createCheckRow("renalRow", NSLocalizedString("Renal failure question", comment: ""))

            <<< createCheckRow("arteryRow", NSLocalizedString("Peripheral arterial disease question", comment: ""))
            <<< createCheckRow("heartRow", NSLocalizedString("Heart failure question", comment: ""))
            <<< createCheckRow("coronaryRow", NSLocalizedString("Ischemic heart disease question", comment: ""))

            <<< ButtonRow("buttonRow") { button in
                
                button.title = NSLocalizedString("Continue", comment: "")
                
                }.cellSetup { cell, _ in
                    
                    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
                    cell.backgroundColor = UIColor(red:0.98, green:0.19, blue:0.41, alpha:1.0)
                    cell.tintColor = UIColor.white
                    
                }.onCellSelection { cell, row in
                    
                    // validation
                    let isValidForm = self.validateForm()
                    
                    if (isValidForm) {
                        let navigationController = self.parent as! UINavigationController
                        let pageViewController = navigationController.parent as! WizardPageViewController
                        pageViewController.segueToPage(name: WizardPageViewController.PAGE_4)
                    }
                  
        }
       

    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateWithHealthKitData()
        
       
    }
    
    func validateForm() -> Bool {
     
        let values = form.values()
        
        if values.isEmpty {
            return false
        }
        
        guard var name = values["nameRow"] as? String else
        {
            DispatchQueue.main.async {
                NotificationManager.instance.displayAlert(title: NSLocalizedString("Attention", comment: ""), message: NSLocalizedString("Type your first name", comment: ""), dismiss: "OK", viewController: self
            )}
            return false
        }
        
        name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (name.isEmpty || name.contains(" ")) {
            
            DispatchQueue.main.async {
                NotificationManager.instance.displayAlert(title: NSLocalizedString("Attention", comment: ""), message: NSLocalizedString("Type only your first name", comment: ""), dismiss: "OK", viewController: self)
            }
            return false
        }
  
        UserManager.instance.person.hasUserName = name
        UserManager.instance.person.uri = name

        UserManager.instance.person.hasAge = values["ageRow"] as! Int!
        
        let male = NSLocalizedString("Male", comment: "")

        switch (values["sexRow"] as! String!)
        {
        case male: UserManager.instance.addRiskFactor(uri: RiskFactor.MALE.rawValue)
        default: break
        }
    
        
        validateRiskFactor("hypertensionRow", RiskFactor.HYPERTENSION.rawValue, values)
  
        validateRiskFactor("diabetesRow", RiskFactor.DIABETES.rawValue, values)
        
        validateRiskFactor("renalRow", RiskFactor.RENAL_DISEASE.rawValue, values)

        validateRiskFactor("arteryRow", RiskFactor.PERIPHERAL_DISEASE.rawValue, values)

        validateRiskFactor("heartRow", RiskFactor.HEART_FAILURE.rawValue, values)

        validateRiskFactor("coronaryRow", RiskFactor.ISCHEMIC_HEART_DISEASE.rawValue, values)
        
        return true

    }
    
    func validateRiskFactor(_ rowName: String, _ riskFactorEnum: String, _ dict: [String: Any?]) {
        if (dict[rowName] as? Bool) != nil {
            UserManager.instance.addRiskFactor(uri: riskFactorEnum)
        }
    }
    
    func updateWithHealthKitData() {
        
        
        HealthKitManager.instance.getDiabetes() { hasDiabetes, glucose, error in
            
            if (error != nil) {
                return
            }
            
            if let row = self.form.rowBy(tag: "diabetesRow") as! CheckRow! {
                
                if let glucose = glucose {
                    UserManager.instance.person.hasBloodGlucose = String(describing: glucose)
                    print("HealthKit: setting person.hasBloodGlucose to \(glucose)")

                }
                
                row.baseValue = hasDiabetes
                row.value = hasDiabetes
                
                print("HealthKit: setting Diabetes to \(hasDiabetes)")

                if (hasDiabetes) {
                    self.identifiedRiskFactors.append(NSLocalizedString("diabetes", comment: ""))
                }
                
                DispatchQueue.main.async {
                
                    row.reload()

                }
            }
            
        }
        
        HealthKitManager.instance.getHighBloodPressure() { hasHighBloodPressure, pressure, error in
            
            if (error != nil) {
                return
            }
            
            if let row = self.form.rowBy(tag: "hypertensionRow") as! CheckRow! {
                
                if let pressure = pressure {
                    UserManager.instance.person.hasBloodPressure = pressure
                    print("HealthKit: setting person.hasBloodPressure to \(pressure)")

                }
                
                
                row.baseValue = hasHighBloodPressure
                row.value = hasHighBloodPressure
                print("HealthKit: setting High Blood Pressure to \(hasHighBloodPressure)")
                
                if (hasHighBloodPressure) {
                    self.identifiedRiskFactors.append(NSLocalizedString("hypertension", comment: ""))
                }
                
                DispatchQueue.main.async {

                    row.reload()

                }
            }
        }
    }
    
    func createSegmentedRow(_ tag: String, _ title: String) -> SegmentedRow<String> {
        let row = SegmentedRow<String>(tag) { row in
            row.title = title
            row.options = [NSLocalizedString("Yes", comment: ""), NSLocalizedString("No", comment: "")]

            row.cell.setControlWidth(width:100)
            row.cell.setTitleWidth(width:180)
            row.cell.textLabel?.adjustsFontSizeToFitWidth = true
            //minimumScaleFactor
        }
        
        return row
    }
    
    func createCheckRow(_ tag: String, _ title: String) -> CheckRow {
        let row = CheckRow(tag) { row in
            row.title = title
            row.cell.textLabel?.font = UIFont(name: row.cell.textLabel!.font!.fontName, size: 15)
        }
        
        return row
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    

}

extension FormViewController {
    func setTableViewDistance() {
        let constraint = NSLayoutConstraint(
            item: self.view,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 20
        )
        constraint.priority = UILayoutPriority.required
        self.view.addConstraint(constraint)
    }
}

extension SegmentedCell {
    func setControlWidth(width: CGFloat) {
        let constraint = NSLayoutConstraint(
            item: segmentedControl,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: width
        )
        addConstraint(constraint)
    }
    
    func setTitleWidth(width: CGFloat) {
        let constraint = NSLayoutConstraint(
            item: titleLabel!,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: width
        )
        addConstraint(constraint)
    }
}
