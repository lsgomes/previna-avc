//
//  RiskTableViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 4/5/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit

class RiskTableViewController: UIViewController {

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

    
    var map: [String : [String]] = [:]

    var image: UIImage!
    
    let cellIdentifier = "riskCell"
    
    @IBOutlet var headerText: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var saveButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        // no lines where there aren't cells
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.parent is WizardPageViewController) {
            headerText.text = "Preencha os campos a seguir para completar seu perfil."
            saveButton.setTitle("CONCLUIR", for: .normal)
        }
        else if (self.parent is MainTabBarController) {
            headerText.text = "Se algum hábito de saúde seu mudou, atualize aqui."
            saveButton.setTitle("SALVAR", for: .normal)
        }

        TRANSLATION_FREQUENCY = [TRANSLATION_OFTEN_OR_ALWAYS, TRANSLATION_SOMETIMES, TRANSLATION_NEVER]
        
        map = ["😭 Choro: " : TRANSLATION_FREQUENCY,
               "😡 Irritação: " : TRANSLATION_FREQUENCY,
               "😨 Ansiosidade:" : TRANSLATION_FREQUENCY,
               "🏃 Atividade física:" : [TRANSLATION_VERY_ACTIVE, TRANSLATION_ACTIVE, TRANSLATION_INACTIVE],
               "🍺 Álcool:": [TRANSLATION_DRINK_IN_MODERATION, TRANSLATION_DRINKER, TRANSLATION_ABSTAIN, TRANSLATION_FORMER_ALCOHOLIC],
               "🚬 Cigarro:" : [TRANSLATION_NEVER_SMOKED, TRANSLATION_SMOKER, TRANSLATION_FORMER_SMOKER]
        ]

        image = UIImage(named: "up arrow")!
        
//        let tableView = UITableView(frame: view.bounds)
//        view.addSubview(tableView)
//        self.tableView = tableView
//        
//        tableView.register(ModifiableRiskCell.self, forCellReuseIdentifier: cellIdentifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundView = nil
        tableView.backgroundColor = .white
        //self.view.backgroundColor = UIColor.lightText
        
        //
        
        self.view.sendSubview(toBack: saveButton)
        self.view.sendSubview(toBack: tableView)


        print(self.parent!)
//        navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 55.0)
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        
        if (self.parent is WizardPageViewController) {
            
            self.performSegue(withIdentifier: "RiskTableToTabBar", sender: nil)
        }
    }
    
}

extension RiskTableViewController: UITableViewDataSource, UITableViewDelegate, DKDropMenuDelegate {
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 124
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return map.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
//        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ModifiableRiskCell
//            ?? ModifiableRiskCell(style: .`default`, reuseIdentifier: cellIdentifier)

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ModifiableRiskCell
        
        let elements = Array(map.keys).sorted()
        
        let key = elements[indexPath.row]
        //let value = map[key]
        //let value = array[indexPath.row]
        
//        cell.label = UILabel()
//        cell.dropMenu = DKDropMenu()
//        cell.imView = UIImageView()
        
        cell.label?.text = key
        cell.dropMenu?.add(map[key]!)
        cell.dropMenu?.delegate = self
        //cell.imView?.image = image
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "DEFINA SUA FREQUÊNCIA DE:"
    }
    
   // func collapsedChanged(_ dropMenu: DKDropMenu, _ collapsed: Bool)
    func collapsedChangedForNewRect(_ NewRect: CGRect, _ collapsed: Bool, _ dropMenu :DKDropMenu)
    {
        //        let visibleCells = tableView.visibleCells as! [ModifiableRiskCell]

        var taloco: NSLayoutConstraint? = nil
        
//        for cell in tableView.visibleCells {
//            let const = cell.contentView
//            for constraint in const.constraints {
//                //print("\(constraint.identifier) ** \(constraint)")
//                if (constraint.identifier == "UIView-Encapsulated-Layout-Height") {
//                    taloco = constraint
//                }
//            }
//        }

  
        
        
        self.view.layoutIfNeeded()
        for constraint in dropMenu.constraints {
            if (constraint.identifier == "dropMenuHeight") {
                constraint.constant = NewRect.size.height
            }
        }
        
        if (taloco != nil) {
            //taloco?.constant = NewRect.size.height
        }
        //self.constrantOfDropDownView.constant = NewRect.size.height;
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCrossDissolve, animations: {
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        
        
        //indexPathsForVisibleRows
//        let visibleCells = tableView.visibleCells as! [ModifiableRiskCell]
//        
//        for cell in visibleCells {
//            
//            cell.layer.masksToBounds = false
//            
//            if (cell.dropMenu != dropMenu) {
//                //cell.dropMenu?.isHidden = true
//                let vsf = CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: cell.frame.width, height: 33)
//                //cell.bounds = vsf
//                //cell.frame = vsf
//                
//            } else {
//                print("cell bounds: \(cell.bounds)")
//                print("cell bounds: \(cell.frame)")
//                
//                print(cell.frame.origin)
//                let vsf = CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: cell.frame.width, height: 124)
//                //cell.bounds = vsf
//
//                //cell.frame = vsf
//                //cell.bounds = CGRect(x: 0, y: 0, width: 320, height: 124)
//
//            }
//            
//        }
    }
    
    
    func itemSelected(_ withIndex: Int, name: String, dropMenu: DKDropMenu) {
        print("\(name) selected");
    }
}
