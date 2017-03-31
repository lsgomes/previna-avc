//
//  ProfileSetupPage2ViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 3/20/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit

class ProfileSetupPage2ViewController: UIViewController, UITextFieldDelegate, DKDropMenuDelegate {

    @IBOutlet var physicalActivityDropMenu: DKDropMenu!
    @IBOutlet var alcoholDropMenu: DKDropMenu!
    @IBOutlet var smokeDropMenu: DKDropMenu!
    @IBOutlet var schoolDropMenu: DKDropMenu!

    @IBOutlet var cryDropMenu: DKDropMenu!
    @IBOutlet var angryDropMenu: DKDropMenu!
    @IBOutlet var anxietyDropMenu: DKDropMenu!
    
    var baseProfile: BaseProfilePage2ViewController!

    @IBOutlet var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64.0)
        
        baseProfile = BaseProfilePage2ViewController(delegate: self, physicalActivityDropMenu: physicalActivityDropMenu, alcoholDropMenu: alcoholDropMenu, smokeDropMenu: smokeDropMenu, schoolDropMenu: schoolDropMenu, cryDropMenu: cryDropMenu, angryDropMenu: angryDropMenu, anxietyDropMenu: anxietyDropMenu)
        
        baseProfile.setupViewDidLoad(setSelectedItemForDropMenus: false)
        
                
    }
    
    func collapsedChanged(dropMenu: DKDropMenu, collapsed: Bool) {
        
        baseProfile.collapseChanged(dropMenu: dropMenu, collapsed: collapsed)

    }
    
    func itemSelected(withIndex: Int, name: String, dropMenu: DKDropMenu) {
        
        baseProfile.itemSelected(withIndex: withIndex, name: name, dropMenu: dropMenu)

    }
    
    @IBAction func continueAction(_ sender: UIButton) {
        
        baseProfile.validateFormSavePerson()
        self.performSegue(withIdentifier: "TabBarSegue", sender: nil)
    }
    
}
