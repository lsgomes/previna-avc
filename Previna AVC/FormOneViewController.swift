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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Perfil"

        
        form +++ Section()
            { section in
            var header = HeaderFooterView<HeaderViewImage>(.class)
            header.height = {72}
            
            header.onSetupView = { view, _ in
                
                view.noteText.text = "📝 Preencha os campos a seguir para se cadastrar."
                //saveButton.setTitle("CONCLUIR", for: .normal)
            }
            
            section.header = header
            }

            <<< NameRow("nameRow") { row in
                row.title = "👤 Nome:" //👤
                row.placeholder = "Digite seu nome aqui"
                row.cell.textLabel?.font = UIFont(name: row.cell.textLabel!.font!.fontName, size: 16)

            }
            <<< IntRow("ageRow") { row in
                row.title = "📆 Idade:"
                row.placeholder = "Digite sua idade aqui"
                row.cell.textLabel?.font = UIFont(name: row.cell.textLabel!.font!.fontName, size: 16)

            }
            <<< PickerInputRow<String>("sexRow") { row in
                row.title = "👫 Sexo: "
                row.options = [TRANSLATION_MALE, TRANSLATION_FEMALE]
                row.value = row.options.first    // initially selected
                row.cell.textLabel?.font = UIFont(name: row.cell.textLabel!.font!.fontName, size: 16)

            }
            
//            <<< SegmentedRow<String>("sexRow") { row in
//                row.title = "Sexo:"
//                row.options = [TRANSLATION_MALE, TRANSLATION_FEMALE]
//                row.cell.setControlWidth(width: 160)
//
//            }

//            <<< createSegmentedRow("hypertensionRow", "Hipertensão:")
//            <<< createSegmentedRow("diabetesRow", "Diabetes:")
//            <<< createSegmentedRow("arteryRow", "Doença arterial periférica:")
//            <<< createSegmentedRow("heartRow", "Insuficiência cardíaca:")
//            <<< createSegmentedRow("coronaryRow", "Doença arterial coronariana:")
        
        
            
            <<< createCheckRow("hypertensionRow2", "Possui hipertensão?")
            <<< createCheckRow("diabetesRow2", "Possui diabetes?")
            <<< createCheckRow("arteryRow2", "Possui doença arterial periférica?")
            <<< createCheckRow("heartRow2", "Possui insuficiência cardíaca?")
            <<< createCheckRow("coronaryRow2", "Possui doença arterial coronariana?")

            <<< ButtonRow("buttonRow") { button in
                button.title = "CONTINUAR"
                }.cellSetup { cell, _ in
                    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
                    cell.backgroundColor = UIColor(red:0.98, green:0.19, blue:0.41, alpha:1.0)
                    cell.tintColor = UIColor.white
                }.onCellSelection { cell, row in
                    let navigationController = self.parent as! UINavigationController
                    let pageViewController = navigationController.parent as! WizardPageViewController
                    pageViewController.segueToPage(name: WizardPageViewController.PAGE_4)
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
            row.cell.textLabel?.font = UIFont(name: row.cell.textLabel!.font!.fontName, size: 16)
        }
        
        return row
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
