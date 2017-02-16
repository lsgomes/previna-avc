//
//  HealthKitManager.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 2/16/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitManager {
    
    static let instance = HealthKitManager()
    
    let healthKitStore: HKHealthStore = HKHealthStore()
    
    func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Void) {
        
        guard HKHealthStore.isHealthDataAvailable() else {
            print("HealthKit not available.")
            return
        }
        
        let readDataTypes: Set<HKObjectType> = dataTypesToRead()
        
        print("HealthKitManager.authorizeHealthKit()")
        healthKitStore.requestAuthorization(toShare: nil, read: readDataTypes, completion: completion)
    }
    
    private func dataTypesToRead() -> Set<HKObjectType> {
        
        let biologicalSexType = HKQuantityType.characteristicType(forIdentifier: .biologicalSex)!
        let dateOfBirthType = HKQuantityType.characteristicType(forIdentifier: .dateOfBirth)!
        let bodyMassType = HKQuantityType.quantityType(forIdentifier: .bodyMass)!
        
        let readDataTypes: Set<HKObjectType> = [biologicalSexType, dateOfBirthType, bodyMassType]
        
        return readDataTypes
    }
    
    func getDateOfBirth() -> String {
        
        var userAge = ""
        
        do {
            let dateOfBirth = try healthKitStore.dateOfBirth()
            let now = Date()
            let ageComponents: DateComponents = Calendar.current.dateComponents([.year], from: dateOfBirth, to: now)
            let calculatedAge: Int = ageComponents.year!
            
            userAge = "\(calculatedAge)"
            
            print("HealthKitManager.getDateOfBirth(): " + userAge)
            
        } catch {
            print("Error getting dateOfBirth from HealthKitStore")
        }
        
        return userAge
    }
    
    func getBiologicalSex() -> String {
        
        var biologicalSex = ""
        
        do {
            let userSex = try healthKitStore.biologicalSex().biologicalSex
            
            switch (userSex as HKBiologicalSex) {
            
            case .male:
                biologicalSex = "Masculino"
            
            case .female:
                biologicalSex = "Feminino"
            
            default:
                break
            }
            
            print("HealthKitManager.getBiologicalSex(): " + biologicalSex)

        } catch {
            print("Error getting biologicalSex from HealthKitStore")
        }

        
        return biologicalSex
    }
    
    //        HKQuantityTypeIdentifier.activeEnergyBurned
    //        HKQuantityTypeIdentifier.appleExerciseTime
    //        HKQuantityTypeIdentifier.bloodAlcoholContent
    //        HKQuantityTypeIdentifier.bloodGlucose
    //        HKQuantityTypeIdentifier.bloodPressureSystolic
    //        HKQuantityTypeIdentifier.bloodPressureDiastolic
    //        HKQuantityTypeIdentifier.bodyFatPercentage
    //        HKQuantityTypeIdentifier.bodyMassIndex
    //        HKQuantityTypeIdentifier.dietaryCholesterol
    //        HKQuantityTypeIdentifier.dietaryEnergyConsumed
    //        HKQuantityTypeIdentifier.dietaryFatTotal
    //        HKQuantityTypeIdentifier.dietaryFatSaturated
    //        HKQuantityTypeIdentifier.dietaryWater
    //        HKQuantityTypeIdentifier.distanceSwimming
    //        HKQuantityTypeIdentifier.distanceCycling
    //        HKQuantityTypeIdentifier.distanceWalkingRunning
    //        HKQuantityTypeIdentifier.heartRate
    //        HKQuantityTypeIdentifier.height
    //        HKQuantityTypeIdentifier.stepCount
    //        HKQuantityTypeIdentifier.heartRate
    //        HKQuantityTypeIdentifier.flightsClimbed

    private init() {} //This prevents others from using the default '()' initializer for this class.

}
