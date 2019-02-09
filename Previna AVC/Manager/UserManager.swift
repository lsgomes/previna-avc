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
    }
    
    func removeRiskFactor(name: String) {
        
        if let risks = person.hasRiskFactor {
            
            for (i, risk) in risks.enumerated().reversed()
            {
                if risk.uri == name
                {
                    print("Removing risk from user: \(risk.uri!)")
                    person.hasRiskFactor!.remove(at: i)
                }
            }
            
        }
        
    }
    
    func addRiskFactor(uri: String) {
                
        if hasRiskFactor(uri: uri) {
            print("Risk factor \(uri) already exists. Skipping add")
        }
        else 
        {
            if (person.hasRiskFactor == nil) {
                person.hasRiskFactor = [HasRiskFactor]()
            }

            let risk = HasRiskFactor()
            risk.uri = uri
            print("Adding risk \(uri) to user")

            person.hasRiskFactor!.append(risk)
        }
    }

    func hasRiskFactor(uri: String) -> Bool {
        
        guard (person.hasRiskFactor != nil) else { return false }
        
        if person.hasRiskFactor!.contains(where: { $0.uri == uri }) {
            return true
        }

        return false
    }
}
