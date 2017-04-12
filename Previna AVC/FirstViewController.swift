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
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet var riskLabel: UILabel!
    
    @IBOutlet var horizontalScrollView: ASHorizontalScrollView! // TODO

    var itemSize = 150
    var size = 200
    var tipSize = 250
    
    func createTip(text: String, index: Int) -> TipView {
        let image = UIImage(named: "note2")
        let imageView = UIImageView(frame:CGRect(x: 0, y: 0, width: tipSize, height: itemSize))
        imageView.image = image
        
        let label = UILabel(frame:CGRect(x: 20, y: -25, width: 230, height: itemSize))
        label.text = "Dica \(index):\n\n" + text
        label.numberOfLines = 0
        
        let tipView = TipView(frame: CGRect.zero)
        tipView.addSubview(imageView)
        tipView.addSubview(label)
        
        return tipView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //navigationBar.topItem?.prompt = "navigationBar.topItem?"
        if (UserManager.instance.person.hasUserName != nil) {
            navigationBar.topItem?.title = "Bem vindo, \(UserManager.instance.person.hasUserName!)!"

        }
        navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 60.0)
        
        setHorizontalViewProperties()
        
        listTips()
        
        self.view.addSubview(horizontalScrollView)
        
        horizontalScrollView.addItem(createTip(text: "Pratique mais exercícios físicos", index: 1))
        horizontalScrollView.addItem(createTip(text: "Beba com moderação", index: 2))
        horizontalScrollView.addItem(createTip(text: "Tente parar de fumar", index: 3))


    
        horizontalScrollView.setItemsMarginOnce()
    }
    
    func listTips() {
        
        
        for (index, element) in UserManager.instance.person.hasRiskFactor!.enumerated() {
            if (element.hasTip != nil) {
                let tip = createTip(text: element.hasTip!, index: index)
                horizontalScrollView.addItem(tip)
            }
        }
    }
    
    @IBAction func updateAction(_ sender: UIButton) {
        
        
        sender.setTitle("ATUALIZANDO", for: .normal)
        activityIndicator.startAnimating()
        
        let person = UserManager.instance.person
        
        RestManager.instance.calculateRiskForPerson(person: person) { response in
            print(response)
            
            if (response) {
                
                self.riskPercentageLabel.text = String(describing: UserManager.instance.person.hasRiskLevel) + "%"
                let date = Date()
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: date)
                let minutes = calendar.component(.minute, from: date)
                
                self.riskLabel.text = "Este é seu risco em 10 anos de AVC.\n Última atualização: Hoje às \(hour):\(minutes)"
                sender.setTitle("ATUALIZAR", for: .normal)
                
                if (self.horizontalScrollView.removeAllItems()) {
                    self.listTips()

                }
                self.activityIndicator.stopAnimating()

            }
            else {
                self.riskLabel.text = "Pressione em ATUALIZAR para calcular seu risco de AVC em 10 anos."
                sender.setTitle("ATUALIZAR", for: .normal)
                self.activityIndicator.stopAnimating()
            }
            

        }
    }
    
    func setHorizontalViewProperties() {
        
//        let horizontalScrollView = ASHorizontalScrollView(frame:CGRect(x: 0, y: 255, width: 320 , height: size)) // W: IPHONE SCREEN SIZE (5S = 320)
        
        horizontalScrollView.arrangeType = .byNumber
        //horizontalScrollView.arrangeType = .byFrame
        
        //horizontalScrollView.marginSettings_320 = MarginSettings(leftMargin: 1, miniMarginBetweenItems: 1, miniAppearWidthOfLastItem: 20)
        
        horizontalScrollView.marginSettings_320 = MarginSettings(leftMargin: 0, numberOfItemsPerScreen: 1.25)
        
        //horizontalScrollView.defaultMarginSettings.numberOfItemsPerScreen = 1.25
        
        horizontalScrollView.uniformItemSize = CGSize(width: tipSize, height: itemSize)
        
        horizontalScrollView.setItemsMarginOnce()
        
        //return horizontalScrollView
        
    }
}

