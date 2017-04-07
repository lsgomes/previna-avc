//
//  ModifiableRiskTableViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 4/2/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit

class ModifiableRiskTableViewController: UITableViewController, DKDropMenuDelegate {

    var angryDropMenu: DKDropMenu = DKDropMenu()
    var anxietyDropMenu: DKDropMenu = DKDropMenu()

    var schoolDropMenu: DKDropMenu = DKDropMenu()
    var physicalActivityDropMenu: DKDropMenu = DKDropMenu()
    var alcoholDropMenu: DKDropMenu = DKDropMenu()
    var smokeDropMenu: DKDropMenu = DKDropMenu()
    
    var timer = Timer()
    let delay = 2.0
    

    var map: [String : DKDropMenu] = [:]
    
    //var image: UIImage = UIImage(named: "up arrow")!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        map = ["😭 Frequência de choro?" : createDropMenu(items: ["a", "b"]),
               "😡 Frequência de irritação?" : angryDropMenu,
               "😨 Frequência de ansiosidade?" : anxietyDropMenu,
               "🏃 Atividade física" : physicalActivityDropMenu,
               "🍺 Álcool": alcoholDropMenu,
               "🚬 Cigarro" : smokeDropMenu
              ]
        
        //self.view.sendSubview(toBack: UIView)
        
//        setDropMenuAttributes(dropMenu: &cryDropMenu, items: ["asda", "basd"], delegate: self)

        
//        baseProfile = BaseProfilePage2ViewController(delegate: self, physicalActivityDropMenu: physicalActivityDropMenu, alcoholDropMenu: alcoholDropMenu, smokeDropMenu: smokeDropMenu, schoolDropMenu: schoolDropMenu, cryDropMenu: cryDropMenu, angryDropMenu: angryDropMenu, anxietyDropMenu: anxietyDropMenu)
//        
//        baseProfile.setupViewDidLoad(setSelectedItemForDropMenus: false)
//
        
//        
//        for menu in dropMenus {
//            menu.selectedColor = .gray
//            menu.textColor = UIColor.black
//            menu.itemHeight = 30
//            menu.delegate = self
//            menu.add(names: riskFactors)
//        }


    }
    
    func createDropMenu(items: [String]) -> DKDropMenu {
        let dropMenu = DKDropMenu()
        dropMenu.selectedColor = .gray
        dropMenu.textColor = .black
        dropMenu.itemHeight = 30
        dropMenu.add(names: items)
        dropMenu.delegate = self
        return dropMenu
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Se algum hábito de saúde seu mudou, atualize aqui:"
    }
    
    func collapsedChanged(dropMenu: DKDropMenu, collapsed: Bool) {
        
        //baseProfile.collapseChanged(dropMenu: dropMenu, collapsed: collapsed)
    }
    
    
    func itemSelected(_ withIndex: Int, name: String, dropMenu: DKDropMenu) {
            print("\(name) selected");
        //baseProfile.itemSelected(withIndex: withIndex, name: name, dropMenu: dropMenu)
    }
    
    func updateWithHealthKitData() {
        
        //baseProfile.gatherInformationFromHealthKit()
        // nofity up
        // not hdien
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return map.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "riskCell", for: indexPath) as! ModifiableRiskCell
        
        let key = Array(map.keys)[indexPath.row]
        //let value = map[key]
        //let value = array[indexPath.row]
        
        cell.label?.text = key
        cell.dropMenu?.add(names: ["aba", "dedo", "show"])
        cell.imView?.image = UIImage(named: "up arrow")
        //cell.arrow = UIImageView(image: image)
        //cell.arrow
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
