//
//  StaticRiskViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 4/8/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit

class StaticRiskViewController: UIViewController {

    let cellIdentifierSegment = "SegmentCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension StaticRiskViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierSegment, for: indexPath) as! ModifiableRiskCell
        
        
        return cell
    }
    
    func collapsedChanged(dropMenu: DKDropMenu, collapsed: Bool) {
        
    }
    
    
    func itemSelected(_ withIndex: Int, name: String, dropMenu: DKDropMenu) {
        print("\(name) selected");
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}

