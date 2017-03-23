//
//  StartViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 3/23/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let exists = UserManager.instance.fileExists()
        
        if (exists) {
            // perform segue to calculate risk
        }
        else {
            // perform segue to wizard
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
