//
//  SecondViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 2/8/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit
import SwiftyDrop

class SecondViewController: UIViewController, UITextFieldDelegate, DKDropMenuDelegate {
    
    @IBOutlet var cryDropMenu: DKDropMenu!
    @IBOutlet var angryDropMenu: DKDropMenu!
    @IBOutlet var anxietyDropMenu: DKDropMenu!
    
    @IBOutlet var schoolDropMenu: DKDropMenu!
    @IBOutlet var physicalActivityDropMenu: DKDropMenu!
    @IBOutlet var alcoholDropMenu: DKDropMenu!
    @IBOutlet var smokeDropMenu: DKDropMenu!
    
    @IBOutlet var navigationBar: UINavigationBar!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var label: UILabel!
    
    var timer = Timer()
    let delay = 2.0

    var dropMenus: [DKDropMenu] = []
    
    @IBOutlet var saveButton: UIButton!
    var baseProfile: BaseProfilePage2ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                //label.layer.borderWidth = 1.0
        //view.addSubview(navigationBar)
        
        navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 55.0)
        
        if (self.parent is WizardPageViewController) {
            label.text = "Preencha os campos a seguir para completar seu perfil."
            saveButton.setTitle("CONCLUIR", for: .normal)
        }
        else if (self.parent is MainTabBarController) {
            label.text = "Se algum hábito de saúde seu mudou, atualize aqui."
            saveButton.setTitle("SALVAR", for: .normal)
        }
        
        
        baseProfile = BaseProfilePage2ViewController(delegate: self, physicalActivityDropMenu: physicalActivityDropMenu, alcoholDropMenu: alcoholDropMenu, smokeDropMenu: smokeDropMenu, schoolDropMenu: schoolDropMenu, cryDropMenu: cryDropMenu, angryDropMenu: angryDropMenu, anxietyDropMenu: anxietyDropMenu, button: saveButton)

        baseProfile.setupViewDidLoad(setSelectedItemForDropMenus: false) // TODO
        
        self.dropMenus = [cryDropMenu, angryDropMenu, anxietyDropMenu, schoolDropMenu!, physicalActivityDropMenu, alcoholDropMenu, smokeDropMenu]
        
        view.sendSubview(toBack: saveButton)
    }
    
    func collapsedChanged(dropMenu: DKDropMenu, collapsed: Bool) {
        
        //baseProfile.collapseChanged(dropMenu: dropMenu, collapsed: collapsed)
    }
    

    
    func collapsedChangedForNewRect(_ NewRect: CGRect, _ collapsed: Bool, _ dropMenu :DKDropMenu) {
        //public func collapseChanged(dropMenu: DKDropMenu?, collapsed: Bool) {
        
        self.view.layoutIfNeeded()
        
        
        for constraint in dropMenu.constraints {
            if (constraint.identifier == "alcoholConstraint") {
                dropMenu.constraints.first?.constant = NewRect.size.height
                UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCrossDissolve, animations: {
                    self.view.layoutIfNeeded()
                    
                }, completion: nil)
                
                break

            }
            
        }
        
        guard let dropMenu: DKDropMenu = dropMenu else { return }
        
        if (!collapsed) {
            
            for selectedDropMenu in dropMenus {
                if (selectedDropMenu != dropMenu) {
                    fadein(selectedDropMenu)
                }
                if (selectedDropMenu != schoolDropMenu) {
                    fadein(saveButton)
                }
                
            }
            
        }
        else {
            
            for selectedDropMenu in dropMenus {
                fadeout(selectedDropMenu)
            }
            
            fadeout(saveButton)
        }
        
    }
    
    func fadein(_ view: UIView?) {
        
        guard let view = view else { return }
        
        UIView.animate(withDuration: 0.2, animations: {
            view.alpha = 0.0
        })
    }
    
    func fadeout(_ view: UIView?) {
        
        guard let view = view else { return }
        
        UIView.animate(withDuration: 1.0, animations: {
            view.alpha = 1.0
        })
    }
    
    
    func itemSelected(_ withIndex: Int, name: String, dropMenu: DKDropMenu) {
    
        baseProfile.itemSelected(withIndex: withIndex, name: name, dropMenu: dropMenu)
    }

    
 
    @IBAction func saveAction(_ sender: UIButton) {
        
        if (self.parent is WizardPageViewController) {
            self.performSegue(withIdentifier: "toMainTabBar", sender: nil)
            //baseProfile.validateFormSavePerson()

        }
        else if (self.parent is MainTabBarController) {
            timer.invalidate()
            sender.setTitle("SALVO!", for: .normal)
            //baseProfile.removeModifiableRiskFactors()
            //baseProfile.validateFormSavePerson()
            timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(setButtonTextToSave), userInfo: nil, repeats: false)
        }

    }
    
    func setButtonTextToSave() {
        //saveButton.setTitle("SALVAR", for: .normal)
    }
    
    func updateWithHealthKitData() {
        
        baseProfile.gatherInformationFromHealthKit()
        // nofity up
        // not hdien
    }
    
}

