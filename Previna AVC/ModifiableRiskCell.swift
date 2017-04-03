//
//  ModifiableRiskCell.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 4/2/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit

class ModifiableRiskCell: UITableViewCell {

    @IBOutlet var label: UILabel!
    var dropMenu: DKDropMenu!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
             super.init(style: style, reuseIdentifier: reuseIdentifier)
            //dropMenu.frame
             addSubview(dropMenu)

    }
    
    required init?(coder aDecoder: NSCoder) {
    
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
