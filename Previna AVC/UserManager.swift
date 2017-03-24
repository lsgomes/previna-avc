//
//  UserManager.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 3/21/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import Foundation

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
        person = NSKeyedUnarchiver.unarchiveObject(withFile: Person.ArchiveURL.path) as! Person
    }
    
    func fileExists() -> Bool {
        
        return (try? Person.ArchiveURL.checkResourceIsReachable()) ?? false
        
//        do {
//            let exists = try Person.ArchiveURL.checkResourceIsReachable()
//            print("File person exists? \(exists)")
//            return exists
//        } catch {
//            print("Exception when loading person file. Returning false")
//            return false
//        }
    }

}
