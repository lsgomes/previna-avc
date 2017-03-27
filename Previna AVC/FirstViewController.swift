//
//  FirstViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 2/8/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit
import Alamofire
import ASHorizontalScrollView

class FirstViewController: UIViewController {
    
    @IBOutlet weak var riskPercentageLabel: UILabel!
    @IBOutlet var riskLabel: UITextView!
    
    var itemSize = 170
    var size = 170
    
    func createTip() -> TipView {
        let image = UIImage(named: "note2")
        let imageView = UIImageView(frame:CGRect(x: 0, y: 0, width: size, height: size))
        imageView.image = image
        
        let label = UILabel(frame:CGRect(x: 17, y: -5, width: 140, height: size))
        label.text = "Recomendação: \n\nPratique mais exercícios físicos. \n\nÚltima vez: terça-feira"
        label.numberOfLines = 0
        
        let tipView = TipView(frame: CGRect.zero)
        tipView.addSubview(imageView)
        tipView.addSubview(label)
        
        return tipView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let horizontalScrollView = setHorizontalViewProperties()
        


        horizontalScrollView.addItem(createTip())
        horizontalScrollView.addItem(createTip())

        //horizontalScrollView.addItem(tipView)
    
        
        for _ in 1...3 {
            
        let button = UIButton(frame: CGRect.zero)
            button.backgroundColor = UIColor.blue
            horizontalScrollView.addItem(button)
        }
        
        self.view.addSubview(horizontalScrollView)
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
    
    func setHorizontalViewProperties() -> ASHorizontalScrollView {
        
        let horizontalScrollView = ASHorizontalScrollView(frame:CGRect(x: 75, y: 265, width: size * 2 , height: size + 10)) //xywh
        
        horizontalScrollView.arrangeType = .byNumber
        
        horizontalScrollView.marginSettings_320 = MarginSettings(leftMargin: 10, numberOfItemsPerScreen: 1.5)
        
        horizontalScrollView.defaultMarginSettings.numberOfItemsPerScreen = 1.5
        
        horizontalScrollView.uniformItemSize = CGSize(width: itemSize, height: itemSize)
        
        horizontalScrollView.setItemsMarginOnce()
        
        return horizontalScrollView
        
    }
}

