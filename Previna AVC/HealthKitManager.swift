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

    
    func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Void) {
        
        guard HKHealthStore.isHealthDataAvailable() else {
            print("HealthKit not available.")
            return
        }
        
        let readDataTypes: Set<HKObjectType> = dataTypesToRead()
        
        print("HealthKitManager.authorizeHealthKit()")
        healthKitStore.requestAuthorization(toShare: nil, read: readDataTypes, completion: completion)
    }
    
    fileprivate func dataTypesToRead() -> Set<HKObjectType> {
        
        let biologicalSexType = HKQuantityType.characteristicType(forIdentifier: .biologicalSex)!
        let dateOfBirthType = HKQuantityType.characteristicType(forIdentifier: .dateOfBirth)!

        let bloodPressureSystolic = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureSystolic)!
        let bloodPressureDiastolic = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureDiastolic)!

        let bloodGlocuse = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodGlucose)!
        
        let steps = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!


        let readDataTypes: Set<HKObjectType> = [biologicalSexType, dateOfBirthType, bloodPressureSystolic, bloodPressureDiastolic, bloodGlocuse, steps]
        
        return readDataTypes
    }
    
    func retrieveStepCount(completion: @escaping (_ stepRetrieved: Double) -> Void) {
        
        //   Define the Step Quantity Type
        let stepsCount = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        
        //   Get the start of the day
        let date = NSDate()
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let newDate = cal.startOfDay(for: date as Date)
        
        //  Set the Predicates & Interval
        let predicate = HKQuery.predicateForSamples(withStart: newDate as Date, end: NSDate() as Date, options: .strictStartDate)
        let interval: NSDateComponents = NSDateComponents()
        interval.day = 1
        
        //  Perform the Query
        let query = HKStatisticsCollectionQuery(quantityType: stepsCount!, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: newDate as Date, intervalComponents:interval as DateComponents)
        
        query.initialResultsHandler = { query, results, error in
            
            if error != nil {
                print(error!)
                return
            }
            
            if let myResults = results
            {
                myResults.enumerateStatistics(from: newDate as Date, to: Date() as Date) {
                    statistics, stop in
                    
                    if let quantity = statistics.sumQuantity() {
                        
                        let steps = quantity.doubleValue(for: HKUnit.count())
                        
                        print("Steps = \(steps)")
                        completion(steps)
                    }
                }
            }
            
            
        }
        
        self.healthKitStore.execute(query)
    }
    
    func getDiabetes(completion: @escaping (Bool) -> () ) {
        
        let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodGlucose)!
        
        let unit = HKUnit(from: "mg/dL")
        
        self.readMostRecentSample(sampleType: type) {
            sample, error in
            
            if error != nil { completion(false) }
            
            guard let sample = sample else { return completion(false) }
            
            let result = sample as! HKQuantitySample
            let glucose = result.quantity.doubleValue(for: unit)
            
            if (glucose > 110) {
                completion(true)
            }
        }
    }
    
    func getHighBloodPressure(completion: @escaping (Bool) -> () ) {
  
        let type = HKQuantityType.correlationType(forIdentifier: HKCorrelationTypeIdentifier.bloodPressure)!
        
        let unit = HKUnit.millimeterOfMercury()
        
        self.readMostRecentSamples(sampleType: type) {
            sample, error in
            
            if error != nil { completion(false) }
            
            guard let sample = sample as! [HKQuantitySample]! else { return completion(false) }
            
            let systolic = sample.first?.quantity.doubleValue(for: unit)
            let diastolic = sample.last?.quantity.doubleValue(for: unit)
            
            if (!self.getDateOfBirth().isEmpty && Int(self.getDateOfBirth())! > 59) {
                
                if (Int(systolic!) > 149 && Int(diastolic!) > 89)
                {
                    completion(true)
                }
                
            } else if (Int(systolic!) > 139 && Int(diastolic!) > 89) {
                
                completion(true)

            } else {
                
                completion(false)
            }
        }
    }
    
    func readMostRecentSample(sampleType:HKSampleType, completion: @escaping (HKSample?, Error?) -> () )    {
        
        // 1. Build the Predicate
        let past = Date.distantPast
        let now   = Date()
        let mostRecentPredicate = HKQuery.predicateForSamples(withStart: past, end:now, options: [])
        
        // 2. Build the sort descriptor to return the samples in descending order
        let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: false)
        // 3. we want to limit the number of samples returned by the query to just 1 (the most recent)
        let limit = 1
        
        // 4. Build samples query
        let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate: mostRecentPredicate, limit: limit, sortDescriptors: [sortDescriptor])
        { (sampleQuery, results, error ) -> Void in
            
            if let error = error {
                completion(nil, error)
                return;
            }
            
            // Get the first sample
            let mostRecentSample = results!.first as? HKQuantitySample
            
            // Execute the completion closure
            completion(mostRecentSample, nil)
        }
        // 5. Execute the Query
        self.healthKitStore.execute(sampleQuery)
    }
    
    func readMostRecentSamples(sampleType:HKSampleType, completion: @escaping ([HKSample]?, Error?) -> ()) {
        
        // 1. Build the Predicate
        let past = Date.distantPast
        let now   = Date()
        let mostRecentPredicate = HKQuery.predicateForSamples(withStart: past, end:now, options: [])
        
        // 2. Build the sort descriptor to return the samples in descending order
        let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: false)
        // 3. we want to limit the number of samples returned by the query to just 1 (the most recent)
        let limit = 1

        let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate : mostRecentPredicate, limit: limit, sortDescriptors: [sortDescriptor]) {
            query, results, error in
            
            if let error = error {
                completion(nil, error)
                return;
            }
            
            guard let results = results as? [HKCorrelation] else { return }
            
            // Get the first sample
            guard
                let mostRecentSystolicSample = results.first?.objects(for: self.SYSTOLIC_TYPE).first as? HKQuantitySample,
                let mostRecentDiastolicSample = results.first?.objects(for: self.DIASTOLIC_TYPE).first as? HKQuantitySample
                else { return }

            let mostRecentSamples = [mostRecentSystolicSample, mostRecentDiastolicSample]
            
            // Execute the completion closure
            completion(mostRecentSamples, nil)
        }

        self.healthKitStore.execute(sampleQuery)
    }
    
    
//    func updateHighBloodPressureComponent(segmentControl: UISegmentedControl) {
//        
//        let type = HKQuantityType.correlationType(forIdentifier: HKCorrelationTypeIdentifier.bloodPressure)!
//
//        let startDate = Date.distantPast
//        let endDate   = Date()
//        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [])
//        
//        let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: false)
//        
//        let sampleQuery = HKSampleQuery(sampleType: type, predicate : predicate, limit: 0, sortDescriptors: [sortDescriptor]) {
//            query, results, error in
//            
//            guard let results = results as? [HKCorrelation] else { return }
//            
//            if let systolicSample = results.first?.objects(for: self.SYSTOLIC_TYPE).first as? HKQuantitySample,
//               let diastolicSample = results.first?.objects(for: self.DIASTOLIC_TYPE).first as? HKQuantitySample {
//                
//                let systolic = systolicSample.quantity.doubleValue(for: HKUnit.millimeterOfMercury())
//                let diastolic = diastolicSample.quantity.doubleValue(for: HKUnit.millimeterOfMercury())
//                
//                if (!self.getDateOfBirth().isEmpty && Int(self.getDateOfBirth())! > 59) {
//                    
//                    if (systolic > 149 && diastolic > 89)
//                    {
//                        segmentControl.selectedSegmentIndex = 0
//                    }
//                    
//                } else if (systolic > 139 && diastolic > 89) {
//                    
//                    segmentControl.selectedSegmentIndex = 0
//
//                } else {
//                    
//                    segmentControl.selectedSegmentIndex = 1
//
//                }
//            }
//            
//        }
//        
//        self.healthKitStore.execute(sampleQuery)
//    }
    
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
    
    fileprivate init() {} //This prevents others from using the default '()' initializer for this class.

}
