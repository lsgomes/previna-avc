//
//  RiskTableViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 4/5/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit

class RiskTableViewController: UIViewController, DKDropMenuDelegate {

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
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var saveButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        // no lines where there aren't cells
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        tableView.layer.masksToBounds = false
//        navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 55.0)
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        
        if (self.parent is WizardPageViewController) {
            
            self.performSegue(withIdentifier: "RiskTableToTabBar", sender: nil)
        }
    }
    
}

extension RiskTableViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        //cell.imView?.image = image
        
        return cell
    }
    
    func collapsedChanged(dropMenu: DKDropMenu, collapsed: Bool) {
        
    }
    
    
    func itemSelected(_ withIndex: Int, name: String, dropMenu: DKDropMenu) {
        print("\(name) selected");
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "DEFINA SUA FREQUÊNCIA DE:"
    }
}
