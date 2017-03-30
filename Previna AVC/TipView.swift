//
//  TipView.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 3/26/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit

class TipView: UIView {

    public var imageView = UIImageView()
    public var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    convenience init() {
        self.init(frame: CGRect.zero)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
 
    
    
    public func setProperties(imageName: String, text: String) {
//        let image = UIImage(named: imageName)
//        imageView = UIImageView(image: image)
//        label = UILabel()
//        label.text = text
//        addSubview(imageView)
//        addSubview(label)
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
