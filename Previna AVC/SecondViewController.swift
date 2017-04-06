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
    
    @IBOutlet var saveButton: UIButton!
    
    @IBOutlet var navigationBar: UINavigationBar!
    
    @IBOutlet var image: UIImageView!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var label: UILabel!
    
    var timer = Timer()
    let delay = 2.0
    
    var baseProfile: BaseProfilePage2ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //label.layer.borderWidth = 1.0
        //view.addSubview(navigationBar)
        
        navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 55.0)
        
        
        baseProfile = BaseProfilePage2ViewController(delegate: self, physicalActivityDropMenu: physicalActivityDropMenu, alcoholDropMenu: alcoholDropMenu, smokeDropMenu: smokeDropMenu, schoolDropMenu: schoolDropMenu, cryDropMenu: cryDropMenu, angryDropMenu: angryDropMenu, anxietyDropMenu: anxietyDropMenu, image: image)
  
        baseProfile.setupViewDidLoad(setSelectedItemForDropMenus: true)
    }
    
    func collapsedChanged(dropMenu: DKDropMenu, collapsed: Bool) {
        
        baseProfile.collapseChanged(dropMenu: dropMenu, collapsed: collapsed)
    }
    
    
    func itemSelected(withIndex: Int, name: String, dropMenu: DKDropMenu) {
    
        baseProfile.itemSelected(withIndex: withIndex, name: name, dropMenu: dropMenu)
    }

    
 
    @IBAction func saveAction(_ sender: UIButton) {
        timer.invalidate()
        sender.setTitle("SALVO!", for: .normal)
        baseProfile.removeModifiableRiskFactors()
        baseProfile.validateFormSavePerson()
        timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(setButtonTextToSave), userInfo: nil, repeats: false)

    }
    
    func setButtonTextToSave() {
        saveButton.setTitle("SALVAR", for: .normal)
    }
    
    func updateWithHealthKitData() {
        
        baseProfile.gatherInformationFromHealthKit()
        // nofity up
        // not hdien
    }
    
}

