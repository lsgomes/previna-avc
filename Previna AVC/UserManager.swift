//
//  UserManager.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 3/21/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

class UserManager {
    
    static let instance = UserManager()
    
    var person = Person()
    
    private init() {} // This prevents others from using the default '()' initializer for this class.

}
