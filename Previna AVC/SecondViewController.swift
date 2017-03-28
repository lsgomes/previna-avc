//
//  SecondViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 2/8/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate, DKDropMenuDelegate {
    
    
    // ???!?!?!?!?
    
    @IBOutlet var cryDropMenu: DKDropMenu!
    @IBOutlet var angryDropMenu: DKDropMenu!
    @IBOutlet var anxietyDropMenu: DKDropMenu!
    
    @IBOutlet var schoolDropMenu: DKDropMenu!
    @IBOutlet var physicalActivityDropMenu: DKDropMenu!
    @IBOutlet var alcoholDropMenu: DKDropMenu!
    @IBOutlet var smokeDropMenu: DKDropMenu!
    
    var baseProfile: BaseProfilePage2ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        baseProfile = BaseProfilePage2ViewController(delegate: self, physicalActivityDropMenu: physicalActivityDropMenu, alcoholDropMenu: alcoholDropMenu, smokeDropMenu: smokeDropMenu, schoolDropMenu: schoolDropMenu, cryDropMenu: cryDropMenu, angryDropMenu: angryDropMenu, anxietyDropMenu: anxietyDropMenu)
  
        baseProfile.setupViewDidLoad(setSelectedItemForDropMenus: true)
        
  
    }
    
    func collapsedChanged(dropMenu: DKDropMenu, collapsed: Bool) {
        
        baseProfile.collapseChanged(dropMenu: dropMenu, collapsed: collapsed)
    }
    
    
    func itemSelected(withIndex: Int, name: String, dropMenu: DKDropMenu) {
    
        baseProfile.itemSelected(withIndex: withIndex, name: name, dropMenu: dropMenu)
    }


 
    @IBAction func saveAction(_ sender: UIButton) {
        baseProfile.removeModifiableRiskFactors()
        baseProfile.validateFormSavePerson()
    }
    
    
}

