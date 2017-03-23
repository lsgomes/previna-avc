//
//  FirstViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 2/8/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit
import Alamofire

class FirstViewController: UIViewController {
    
    @IBOutlet weak var riskPercentageLabel: UILabel!
    @IBOutlet var riskLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateAction(_ sender: UIButton) {
        
        
        sender.setTitle("ATUALIZANDO....", for: .normal)
        
        let person = UserManager.instance.person
        
        RestManager.instance.calculateRiskForPerson(person: person) { response in
            print(response)
            
            switch (response) {
                
            case "?":
                
                self.riskPercentageLabel.text = response
                self.riskLabel.text = "Pressione em ATUALIZAR para calcular seu risco."
                sender.setTitle("ATUALIZAR", for: .normal)
                
            default:

                self.riskPercentageLabel.text = response + "%"
                let date = Date()
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: date)
                let minutes = calendar.component(.minute, from: date)
                
                self.riskLabel.text = "Este é seu risco atual de AVC.\n Última atualização: Hoje às \(hour):\(minutes)"
            
            sender.setTitle("ATUALIZAR", for: .normal)
            }
        }
    }
        
}

