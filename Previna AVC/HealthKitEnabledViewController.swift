//
//  HealthKitProtocol.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 2/15/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//
import UIKit
import HealthKit

class HealthKitEnabledViewController: UIViewController {
    
    var healthKitStore: HKHealthStore = HKHealthStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
