//
//  ModifiableRiskTableViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 4/2/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit

class ModifiableRiskTableViewController: UITableViewController, DKDropMenuDelegate {

    var cryDropMenu: DKDropMenu = DKDropMenu()
    var angryDropMenu: DKDropMenu = DKDropMenu()
    var anxietyDropMenu: DKDropMenu = DKDropMenu()

    var schoolDropMenu: DKDropMenu = DKDropMenu()
    var physicalActivityDropMenu: DKDropMenu = DKDropMenu()
    var alcoholDropMenu: DKDropMenu = DKDropMenu()
    var smokeDropMenu: DKDropMenu = DKDropMenu()
    
    var timer = Timer()
    let delay = 2.0
    
    var baseProfile: BaseProfilePage2ViewController!
    
    var riskFactors = ["Chora?", "Se irrita?", "Sente ansioso?", "Atividade física", "Álcool?", "Cigarro?"]
    var dropMenus: [DKDropMenu] = []
    
    //var image: UIImage = UIImage(named: "up arrow")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dropMenus = [cryDropMenu, angryDropMenu, anxietyDropMenu, physicalActivityDropMenu, alcoholDropMenu, smokeDropMenu]

        
//        baseProfile = BaseProfilePage2ViewController(delegate: self, physicalActivityDropMenu: physicalActivityDropMenu, alcoholDropMenu: alcoholDropMenu, smokeDropMenu: smokeDropMenu, schoolDropMenu: schoolDropMenu, cryDropMenu: cryDropMenu, angryDropMenu: angryDropMenu, anxietyDropMenu: anxietyDropMenu)
//        
//        baseProfile.setupViewDidLoad(setSelectedItemForDropMenus: false)
//        
        
        
        for menu in dropMenus {
            menu.selectedColor = .gray
            menu.textColor = UIColor.black
            menu.itemHeight = 30
            menu.delegate = self
            menu.add(names: riskFactors)
        }


    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Se algum hábito de saúde seu mudou, atualize aqui:"
    }
    
    func collapsedChanged(dropMenu: DKDropMenu, collapsed: Bool) {
        
        baseProfile.collapseChanged(dropMenu: dropMenu, collapsed: collapsed)
    }
    
    
    func itemSelected(withIndex: Int, name: String, dropMenu: DKDropMenu) {
        
        baseProfile.itemSelected(withIndex: withIndex, name: name, dropMenu: dropMenu)
    }
    
    func updateWithHealthKitData() {
        
        baseProfile.gatherInformationFromHealthKit()
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
        return riskFactors.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "riskCell", for: indexPath) as! ModifiableRiskCell

        cell.label.text = riskFactors[indexPath.row]
        cell.dropMenu = dropMenus[indexPath.row]
        cell.dropMenu.add(name: "a")
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
