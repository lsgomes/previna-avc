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
    
    func savePerson() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(person, toFile: Person.ArchiveURL.path)
        
        if isSuccessfulSave {
            print("Person successfuly saved.")
        } else {
            print("Failed to save person.")
        }
    }
    
    func loadPerson() {
        person = NSKeyedUnarchiver.unarchiveObject(withFile: Person.ArchiveURL.path) as Person
    }
    
    func fileExists() {
        
        if (Person.ArchiveURL.checkResourceIsReachable()) {
            return true
        }
        
        return false
    }

}
