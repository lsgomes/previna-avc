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

        let bloodAlcohol = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodAlcoholContent)!
        
        let readDataTypes: Set<HKObjectType> = [biologicalSexType, dateOfBirthType, bloodPressureSystolic, bloodPressureDiastolic, bloodGlocuse, steps, bloodAlcohol]
        
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
    
    func retrieveWeekSteps(completion: @escaping (Int?) -> () ) {
        
        print("retrieveWeekSteps")

        
        let calendar = Calendar.current
        
        var interval = DateComponents()
        interval.day = 7
        
        let subtractDays = calendar.date(byAdding: .day, value: -6, to:Date())
        var subtractDateComponents = calendar.dateComponents([.day, .month, .year, .weekday], from: subtractDays!)
        
        // Anchor date 0 defaults to 3:00 a.m.
        subtractDateComponents.hour = 0
        
        guard let weekAgo = calendar.date(from: subtractDateComponents) else {
            print("*** unable to create a valid date from the given components ***")
            return completion(nil)
        }
        
        guard let quantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount) else {
            print("*** Unable to create a step count type ***")
            return completion(nil)
        }
        
        // Create the query
        let query = HKStatisticsCollectionQuery(quantityType: quantityType,
                                                quantitySamplePredicate: nil,
                                                options: .cumulativeSum,
                                                anchorDate: weekAgo,
                                                intervalComponents: interval)
        
        // Set the results handler
        query.initialResultsHandler = {
            query, results, error in
            
            guard let statsCollection = results else {
                // Perform proper error handling here
                print("*** An error occurred while calculating the statistics: \(error?.localizedDescription) ***")
                return completion(nil)
            }
            
            let endDate = Date()
            
            // Plot the weekly step counts over the past 1 months
            statsCollection.enumerateStatistics(from: weekAgo, to: endDate) { statistics, stop in
                
                if let quantity = statistics.sumQuantity() {
                    let date = statistics.startDate
                    let value = quantity.doubleValue(for: HKUnit.count())
                    
                    print("Start date= \(date)")
                    print("End date= \(endDate)")

                    print("Steps total= \(value)")
                    print("Steps/7= \(value / 7)")

                    completion(Int(value / 7))
                    // Call a custom method to plot each data point.
                    //self.plotWeeklyStepCount(value, forDate: date)
                }
            }
        }
        
        self.healthKitStore.execute(query)
        
        
    }
    
    func retrieveAlcohol(completion: @escaping (_ stepRetrieved: Double) -> Void) {
        
        //   Define the Step Quantity Type
        let stepsCount = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodAlcoholContent)
        
        //   Get the start of the day
        let date = NSDate()
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let newDate = cal.startOfDay(for: date as Date)
        
        //  Set the Predicates & Interval
        let predicate = HKQuery.predicateForSamples(withStart: newDate as Date, end: NSDate() as Date, options: .strictStartDate)
        let interval: NSDateComponents = NSDateComponents()
        interval.day = 1
        
        //  Perform the Query
        let query = HKStatisticsCollectionQuery(quantityType: stepsCount!, quantitySamplePredicate: predicate, options: [.discreteAverage], anchorDate: newDate as Date, intervalComponents:interval as DateComponents)
        
        query.initialResultsHandler = { query, results, error in
            
            if error != nil {
                print(error!)
                return
            }
            
            if let myResults = results
            {
                myResults.enumerateStatistics(from: newDate as Date, to: Date() as Date) {
                    statistics, stop in
                    
                    if let quantity = statistics.averageQuantity() {
                        
                        let alcohol = quantity.doubleValue(for: HKUnit.percent())
                        
                        print("Alcohol = \(alcohol)")
                        completion(alcohol)
                    }
                }
            }
            
            
        }
        
        self.healthKitStore.execute(query)
    }
    
    func retrieveWeekAlcohol(completion: @escaping (Double?) -> () ) {
        
        print("retrieveWeekAlcohol")
        
        let calendar = Calendar.current
        
        var interval = DateComponents()
        interval.day = 7
        
        // Set the anchor date to Monday at 3:00 a.m.
        var anchorComponents = calendar.dateComponents([.day, .month, .year, .weekday], from: Date())
        
        let offset = (7 + anchorComponents.weekday! - 2) % 7
        anchorComponents.day! -= offset
        anchorComponents.hour = 3
        
        
        guard let anchorDate = calendar.date(from: anchorComponents) else {
            print("*** unable to create a valid date from the given components ***")
            return completion(nil)
        }
        
        guard let quantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodAlcoholContent) else {
            print("*** Unable to create a step count type ***")
            return completion(nil)
        }
        
        // Create the query
        let query = HKStatisticsCollectionQuery(quantityType: quantityType,
                                                quantitySamplePredicate: nil,
                                                options: .discreteAverage,
                                                anchorDate: anchorDate,
                                                intervalComponents: interval)
        
        // Set the results handler
        query.initialResultsHandler = {
            query, results, error in
            
            guard let statsCollection = results else {
                // Perform proper error handling here
                print("*** An error occurred while calculating the statistics: \(error?.localizedDescription) ***")
                return completion(nil)
            }
            
            let endDate = Date()

            
            guard let startDate = calendar.date(byAdding: .month, value: 0, to: endDate) else {
                print("*** Unable to calculate the start date ***")
                return completion(nil)
            }
            
            // Plot the weekly step counts over the past 1 months
            statsCollection.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                
                if let quantity = statistics.averageQuantity() {
                    let date = statistics.startDate
                    let date2 = statistics.endDate

                    let value = quantity.doubleValue(for: HKUnit.percent())
                    
                    print("Start date= \(date)")
                    print("End date= \(date2)")

                    print("Alcohol= \(value)")
                    
                    completion(value)
                    // Call a custom method to plot each data point.
                    //self.plotWeeklyStepCount(value, forDate: date)
                }
            }
        }
        
        self.healthKitStore.execute(query)
        
//        let a = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodAlcoholContent)
//        
//        readMostRecentSample(sampleType: a!) { s in
//            print("recent sample \(s)")
//        }
    }

    
    func getDiabetes(completion: @escaping (Bool, Double?, Error?) -> () ) {
        
        let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodGlucose)!
        
        let unit = HKUnit(from: "mg/dL")
        
        self.readMostRecentSample(sampleType: type) {
            sample, error in
            
            if error != nil { completion(false, nil, error) }
            
            guard let sample = sample else { return completion(false, nil, error) }
            
            let result = sample as! HKQuantitySample
            let glucose = result.quantity.doubleValue(for: unit)
            
            if (glucose > 110) {
                completion(true, glucose, nil)
            }
        }
    }
    
    func getHighBloodPressure(completion: @escaping (Bool, String?, Error?) -> () ) {
  
        let type = HKQuantityType.correlationType(forIdentifier: HKCorrelationTypeIdentifier.bloodPressure)!
        
        let unit = HKUnit.millimeterOfMercury()
        
        self.readMostRecentSamples(sampleType: type) {
            sample, error in
            
            if error != nil { completion(false, nil, error) }
            
            guard let sample = sample as! [HKQuantitySample]! else { return completion(false, nil, error) }
            
            let systolic = sample.first?.quantity.doubleValue(for: unit)
            let diastolic = sample.last?.quantity.doubleValue(for: unit)
            
            let pressure = "\(systolic!)/\(diastolic!)"
            
            if (!self.getDateOfBirth().isEmpty && Int(self.getDateOfBirth())! > 59) {
                
                if (Int(systolic!) > 149 && Int(diastolic!) > 89)
                {
                    completion(true, pressure, nil)
                }
                
            } else if (Int(systolic!) > 139 && Int(diastolic!) > 89) {
                
                completion(true, pressure, nil)

            } else {
                
                completion(false, pressure, nil)
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
                biologicalSex = NSLocalizedString("Male", comment: "")
            
            case .female:
                biologicalSex = NSLocalizedString("Female", comment: "")
            
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
