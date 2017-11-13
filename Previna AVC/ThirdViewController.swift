//
//  ThirdViewControllerTableViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 3/27/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit

class ThirdViewController: UITableViewController, UITabBarControllerDelegate {

    @IBOutlet var headerView: HeaderViewImage!

    let DRINKING_IN_MODERATION = NSLocalizedString("Drinking in moderation", comment: "")
    let EXERCISING_TWICE_A_WEEK = NSLocalizedString("Exercising twice a week", comment: "")
    let EXERCISING_THREE_TIMES_A_WEEK = NSLocalizedString("Exercising 3 times a week", comment: "")
    let LIVING_HAPPILY = NSLocalizedString("Living happily", comment: "")
    let LEVEL_OF_ANXIETY_UNDER_CONTROL = NSLocalizedString("Level of anxiety under control", comment: "")
    let LEVEL_OF_ANGER_UNDER_CONTROL = NSLocalizedString("Level of anger under control", comment: "")
    let DID_NOT_GO_BACK_TO_DRINKING = NSLocalizedString("Did not go back to drinking", comment: "")
    let DID_NOT_GO_BACK_TO_SMOKING = NSLocalizedString("Did not go back to smoking", comment: "")

    let achievements: [String] =
        [DRINKING_IN_MODERATION, EXERCISING_TWICE_A_WEEK, EXERCISING_THREE_TIMES_A_WEEK,
        LIVING_HAPPILY, LEVEL_OF_ANXIETY_UNDER_CONTROL, LEVEL_OF_ANGER_UNDER_CONTROL,
        DID_NOT_GO_BACK_TO_DRINKING, DID_NOT_GO_BACK_TO_SMOKING]
    
    let medalImage = UIImage(named: "medal")
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Suas Conquistas"
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.topItem?.title = NSLocalizedString("Achievements", comment: "")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.noteText.text = "🏅 " + NSLocalizedString("Your achievements will appear as golden medals", comment: "")
       //self.tableView.reloadData()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return achievements.count
        
//        guard let riskFactors = UserManager.instance.person.hasRiskFactor else {
//            
//            return 0
//        }
//        
//        return riskFactors.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let row = indexPath.row

        cell.textLabel?.text = achievements[row]
        
        
        if let riskFactors = UserManager.instance.person.hasRiskFactor {
            
            for riskFactor in riskFactors {
            
                if let achievement = riskFactor.hasAchievement {
                    
                    if achievement == achievements[row] {
                        cell.imageView?.image = medalImage
                    }
                }
                
            }
    
        }
        
//        if let riskFactors = UserManager.instance.person.hasRiskFactor {
//            
//            cell.textLabel?.text = riskFactors[row].hasAchievement
//
//        }
        
        return cell
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
    /*
    // Override to support conditional editing of th  e table view.
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
