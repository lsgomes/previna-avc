//
//  FormTwoViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 4/9/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit
import Eureka

class FormTwoViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView?.isScrollEnabled = false
        //tableView?.bounces = false
        view.backgroundColor = .white
        self.navigationItem.title = "Perfil"
      
        TRANSLATION_FREQUENCY =
            [TRANSLATION_OFTEN_OR_ALWAYS,
             TRANSLATION_SOMETIMES,
             TRANSLATION_NEVER]

        form +++ Section("SectionOne")
            { section in
                var header = HeaderFooterView<HeaderView>(.class)
                header.height = {107}
                
                header.onSetupView = { view, _ in
                    
                        view.noteText.text = "📝 Preencha os campos a seguir para completar seu perfil."
                        //saveButton.setTitle("CONCLUIR", for: .normal)
                }
                
                section.header = header
            }

            <<< createRow("alcoholRow", "🍺 Álcool:",
                               [TRANSLATION_DRINKER,
                               TRANSLATION_DRINK_IN_MODERATION,
                               TRANSLATION_ABSTAIN,
                               TRANSLATION_FORMER_ALCOHOLIC])
        
            <<< createRow("activityRow", "🚶 Atividade física:",
                               [TRANSLATION_VERY_ACTIVE,
                                TRANSLATION_ACTIVE,
                                TRANSLATION_INACTIVE])
        
            <<< createRow("angryRow", "😡 Irritação: ", TRANSLATION_FREQUENCY)
        
            <<< createRow("anxietyRow", "😨 Ansiosidade:", TRANSLATION_FREQUENCY)
        
            <<< createRow("cryRow", "😭 Choro: ", TRANSLATION_FREQUENCY)
        
            <<< createRow("smokeRow", "🚬 Cigarro:",
                               [TRANSLATION_NEVER_SMOKED,
                                TRANSLATION_SMOKER,
                                TRANSLATION_FORMER_SMOKER])
        
            <<< createRow("educationRow","📖 Educação:",
                          [TRANSLATION_COLLEGE_DIPLOMA,
                           TRANSLATION_HIGH_SCHOOL_DIPLOMA,
                           TRANSLATION_NO_HIGH_SCHOOL_DIPLOMA])
        
            <<< ButtonRow("buttonRow") { button in
                button.title = "CONTINUAR"
                }.cellSetup { cell, _ in
                    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
                    cell.backgroundColor = UIColor(red:0.98, green:0.19, blue:0.41, alpha:1.0)
                    cell.tintColor = UIColor.white
                }.onCellSelection { cell, row in
                    
                    if (self.parent is UINavigationController) {
                        
                        self.performSegue(withIdentifier: "formTwoSegue", sender: nil)
                    }
//                    let navigationController = self.parent as! UINavigationController
//                    let pageViewController = navigationController.parent as! WizardPageViewController
//                    pageViewController.segueToPage(name: WizardPageViewController.PAGE_4)
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
    let TRANSLATION_SOMETIMES = "Às vezes"
    let TRANSLATION_NEVER = "Nunca"
    
    var TRANSLATION_FREQUENCY : [String] = []
    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
