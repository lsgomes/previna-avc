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
    
    @IBOutlet var stackTip: StackTip!

    @IBOutlet var horizontalScrollView: ASHorizontalScrollView!

    var itemSize = 150
    var size = 200
    var tipSize = 250
    
    func createTip(text: String, index: Int) -> TipView {
        let image = UIImage(named: "note2")
        let imageView = UIImageView(frame:CGRect(x: 0, y: 0, width: tipSize, height: itemSize))
        imageView.image = image
        
        let label = UILabel(frame:CGRect(x: 20, y: -15, width: 215, height: itemSize))
        label.text = NSLocalizedString("Tip", comment: "") + " \(index):\n\n" + text
        label.numberOfLines = 6
        
        let tipView = TipView(frame: CGRect.zero)
        tipView.addSubview(imageView)
        tipView.addSubview(label)
        
        return tipView
    }
    
    override func viewWillAppear(_ animated: Bool) {

        if (UserManager.instance.person.hasUserName != nil) {
            navigationController?.navigationBar.topItem?.title = NSLocalizedString("Welcome,", comment: "") + " \(UserManager.instance.person.hasUserName!)!"
        }
        else 
        {
            navigationController?.navigationBar.topItem?.title = NSLocalizedString("Welcome!", comment: "")
        }

    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setHorizontalViewProperties()
        
        listTips()
        
        if let risk = UserManager.instance.person.hasRiskLevel {
            self.riskPercentageLabel.text = String(describing: risk) + "%"
        }
        
        self.view.addSubview(horizontalScrollView)
  
    }
    
    func listTips() {
        
        var number = 0
        
        for (_, element) in UserManager.instance.person.hasRiskFactor!.enumerated() {
            if (element.hasTip != nil) {
                number = number + 1
                print("Creating tip note with text \(element.hasTip!)")
                let tip = createTip(text: element.hasTip!, index: number)
                horizontalScrollView.addItem(tip)
            }
        }
        
        horizontalScrollView.setItemsMarginOnce()
    }
    
    func addNotificationsForTips() {
        
        print("now: \(Date())")
        
        for (index, element) in UserManager.instance.person.hasRiskFactor!.enumerated() {
            if (element.hasTip != nil) {
                NotificationManager.instance.scheduleNotification(text: element.hasTip!, minutes: 120 * index, taskTypeId: element.uri!, viewController: self)
            }
        }

        
    }
    
    func removeAllNotifications() {
        
        for notification in NotificationManager.instance.listNotifications() {
            if let info = notification.userInfo?["taskObjectId"] as? String {
                NotificationManager.instance.removeNotification(taskTypeId: info)
            }
        }
    }
    
    func removeNotificationsForTips() {
        
        for (_, element) in UserManager.instance.person.hasRiskFactor!.enumerated() {
            if (element.hasTip != nil) {
                NotificationManager.instance.removeNotification(taskTypeId: element.uri!)
            }
        }
        
    }
    
    @IBAction func updateAction(_ sender: UIButton) {
        
        sender.setTitle(NSLocalizedString("Updating", comment: ""), for: .normal)
        activityIndicator.startAnimating()
        
        let person = UserManager.instance.person
        
        removeNotificationsForTips()
        
        RestManager.instance.calculateRiskForPerson(person: person) { response in
            
            print(response)
            
            if (response) {
                
                if (UserManager.instance.person.hasRiskLevel != nil) {
                    self.riskPercentageLabel.text = String(describing: UserManager.instance.person.hasRiskLevel!) + "%"
                    
                    let date = Date()
                    let calendar = Calendar.current
                    let hour = calendar.component(.hour, from: date)
                    let minutes = calendar.component(.minute, from: date)
                    
                    self.stackTip.subtitle.text = NSLocalizedString("This is your stroke risk in 10 years. Last update: Today at:", comment: "") + " \(hour):\(minutes)"

                }
                
                sender.setTitle(NSLocalizedString("Update", comment: ""), for: .normal)
                
                self.horizontalScrollView.removeAllItems()
                
                self.listTips()
                
                self.addNotificationsForTips()
                
                self.activityIndicator.stopAnimating()
                
            }
            else 
            {
                NotificationManager.instance.displayAlert(title: NSLocalizedString("Attention", comment: ""), message: NSLocalizedString("Your risk could not be updated. Try again.", comment: ""), dismiss: "OK", viewController: self)
                self.stackTip.subtitle.text = NSLocalizedString("Press UPDATE to calculate your stroke risk in 10 years", comment: "")
                sender.setTitle(NSLocalizedString("Update", comment: ""), for: .normal)
                self.activityIndicator.stopAnimating()
            }

        }
    }
    
    func setHorizontalViewProperties() {
                
        horizontalScrollView.arrangeType = .byNumber
                
        horizontalScrollView.marginSettings_320 = MarginSettings(leftMargin: 0, numberOfItemsPerScreen: 1.25)
                
        horizontalScrollView.uniformItemSize = CGSize(width: tipSize, height: itemSize)
        
        horizontalScrollView.setItemsMarginOnce()
                
    }
}

