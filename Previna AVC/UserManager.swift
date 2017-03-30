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
    
    func removeRiskFactor(name: String) {
        
        guard (person.hasRiskFactor != nil) else { return }
        
        let index = person.hasRiskFactor!.index(where: {element in
            element.uri == name
        })
        
        if (index != nil) {
            person.hasRiskFactor!.remove(at: index!)
        }
        
    }
    
    func addRiskFactor(uri: String) {
                
        if hasRiskFactor(uri: uri) {
            print("Risk factor \(uri) already exists. Skipping add")
        }
        else {
            if (person.hasRiskFactor == nil) {
                person.hasRiskFactor = [HasRiskFactor]()
            }
            let risk = HasRiskFactor()
            risk.uri = uri
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
