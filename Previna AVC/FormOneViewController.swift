//
//  FormOneViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 4/10/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit
import Eureka

class FormOneViewController: FormViewController {
    
    var sbPageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //setTableViewDistance()
        
//        for constraint in view.constraints {
//            print(constraint)
//        }
        
        self.navigationItem.title = "Perfil"
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
                view.noteText.text = "📝 Preencha os campos a seguir para se cadastrar."
                //saveButton.setTitle("CONCLUIR", for: .normal)
            }
            
            section.header = header
            }

            <<< NameRow("nameRow") { row in
                row.title = "👤 Nome:" //👤
                row.placeholder = "Digite seu nome aqui"
                row.cell.textLabel?.font = UIFont(name: row.cell.textLabel!.font!.fontName, size: 15)

            }
            <<< IntRow("ageRow") { row in
                row.title = "📆 Idade:"
                row.placeholder = "Digite sua idade aqui"
                row.cell.textLabel?.font = UIFont(name: row.cell.textLabel!.font!.fontName, size: 15)

            }
            <<< PickerInputRow<String>("sexRow") { row in
                row.title = "👫 Sexo: "
                row.options = [TRANSLATION_MALE, TRANSLATION_FEMALE]
                row.value = row.options.first    // initially selected
                row.cell.textLabel?.font = UIFont(name: row.cell.textLabel!.font!.fontName, size: 15)

            }
            
            <<< createCheckRow("hypertensionRow", "Possui hipertensão?")
            <<< createCheckRow("diabetesRow", "Possui diabetes?")
            <<< createCheckRow("renalRow", "Possui insuficiência renal crônica?")

            <<< createCheckRow("arteryRow", "Possui doença arterial periférica?")
            <<< createCheckRow("heartRow", "Possui insuficiência cardíaca?")
            <<< createCheckRow("coronaryRow", "Possui doença arterial coronariana?")

            <<< ButtonRow("buttonRow") { button in
                
                button.title = "CONTINUAR"
                
                }.cellSetup { cell, _ in
                    
                    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
                    cell.backgroundColor = UIColor(red:0.98, green:0.19, blue:0.41, alpha:1.0)
                    cell.tintColor = UIColor.white
                    
                }.onCellSelection { cell, row in
                    
                    // validation
                    self.validateForm()
                    
                    
                    let navigationController = self.parent as! UINavigationController
                    let pageViewController = navigationController.parent as! WizardPageViewController
                    pageViewController.segueToPage(name: WizardPageViewController.PAGE_4)
        }

    
    }
    
    func validateForm() {
     
        let values = form.values()
  
        UserManager.instance.person.hasUserName = values["nameRow"] as! String!
        UserManager.instance.person.uri = values["nameRow"] as! String!

        UserManager.instance.person.hasAge = values["ageRow"] as! Int!
        
        switch (values["sexRow"] as! String!)
        {
        case TRANSLATION_MALE: UserManager.instance.addRiskFactor(uri: RiskFactor.MALE.rawValue)
        default: break
        }
    
        
        validateRiskFactor("hypertensionRow", RiskFactor.HYPERTENSION.rawValue, values)
  
        validateRiskFactor("diabetesRow", RiskFactor.DIABETES.rawValue, values)
        
        validateRiskFactor("renalRow", RiskFactor.RENAL_DISEASE.rawValue, values)

        validateRiskFactor("arteryRow", RiskFactor.PERIPHERAL_DISEASE.rawValue, values)

        validateRiskFactor("heartRow", RiskFactor.HEART_FAILURE.rawValue, values)

        validateRiskFactor("coronaryRow", RiskFactor.ISCHEMIC_HEART_DISEASE.rawValue, values)

    }
    
    func validateRiskFactor(_ rowName: String, _ riskFactorEnum: String, _ dict: [String: Any?]) {
        if (dict[rowName] as? Bool) != nil {
            UserManager.instance.addRiskFactor(uri: riskFactorEnum)
        }
    }
    
    
    
    let TRANSLATION_MALE = "Masculino"
    let TRANSLATION_FEMALE = "Feminino"
    
    let SEGMENT_YES = "Sim"
    let SEGMENT_NO = "Não"
    
    func createSegmentedRow(_ tag: String, _ title: String) -> SegmentedRow<String> {
        let row = SegmentedRow<String>(tag) { row in
            row.title = title
            row.options = [SEGMENT_YES, SEGMENT_NO]

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
        constraint.priority = UILayoutPriorityRequired
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
