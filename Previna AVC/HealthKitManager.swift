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
    
    
    let SYSTOLIC_TYPE = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureSystolic)!
    let DIASTOLIC_TYPE = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureDiastolic)!
    
    var GlobalMainQueue: DispatchQueue {
        return DispatchQueue.main
    }
    
    let queryGroup = DispatchGroup()
    
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

        let bloodPressureSystolic = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureSystolic)!
        let bloodPressureDiastolic = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureDiastolic)!

        
        let readDataTypes: Set<HKObjectType> = [biologicalSexType, dateOfBirthType, bloodPressureSystolic, bloodPressureDiastolic]
        
        return readDataTypes
    }
    
    func getHighBloodPressure(completion: @escaping (Bool) -> ()) {
        
        let type = HKQuantityType.correlationType(forIdentifier: HKCorrelationTypeIdentifier.bloodPressure)!

        let startDate = Date.distantPast
        let endDate   = Date()
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [])
        
        let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: true)
        
        let sampleQuery = HKSampleQuery(sampleType: type, predicate: predicate, limit: 0, sortDescriptors: [sortDescriptor], resultsHandler: determineHighBloodPressure)

        queryGroup.enter()
        self.healthKitStore.execute(sampleQuery)
        
        queryGroup.notify(queue: GlobalMainQueue) {
            //completion(GlobalMainQueue.)
        }
        
    }
    
    private func determineHighBloodPressure(query: HKSampleQuery, results: [HKSample]?, error: Error?) {
    
        if let data = results as? [HKCorrelation] {
            
            if let systolicSample = data.first?.objects(for: self.SYSTOLIC_TYPE).first as? HKQuantitySample,
               let diastolicSample = data.first?.objects(for: self.DIASTOLIC_TYPE).first as? HKQuantitySample {
                
                let systolic = systolicSample.quantity.doubleValue(for: HKUnit.millimeterOfMercury())
                let diastolic = diastolicSample.quantity.doubleValue(for: HKUnit.millimeterOfMercury())

                print("\(systolic) / \(diastolic)")
                
                if (!getDateOfBirth().isEmpty && Int(getDateOfBirth())! > 59) {
                    
                    if (systolic > 149 && diastolic > 89)
                    {
                        UserManager.instance.addRiskFactor(uri: RiskFactor.HYPERTENSION.rawValue)
                    }
                    
                } else if (systolic > 139 && diastolic > 89) {
                    // has hypertension risk Factor
                    UserManager.instance.addRiskFactor(uri: RiskFactor.HYPERTENSION.rawValue)

                }
                
                queryGroup.leave()
            }
        }
        
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
