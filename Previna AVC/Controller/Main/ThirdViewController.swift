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

    lazy var achievements: [String] =
        [DRINKING_IN_MODERATION, EXERCISING_TWICE_A_WEEK, EXERCISING_THREE_TIMES_A_WEEK,
        LIVING_HAPPILY, LEVEL_OF_ANXIETY_UNDER_CONTROL, LEVEL_OF_ANGER_UNDER_CONTROL,
        DID_NOT_GO_BACK_TO_DRINKING, DID_NOT_GO_BACK_TO_SMOKING]
    
    let medalImage = UIImage(named: "medal")
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.topItem?.title = NSLocalizedString("Achievements", comment: "")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.noteText.text = "🏅 " + NSLocalizedString("Your achievements will appear as golden medals", comment: "")

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return achievements.count
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
        
        return cell
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

}
