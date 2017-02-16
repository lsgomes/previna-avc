//
//  HealthKitViewController.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 2/9/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

import UIKit
import HealthKit

class HealthKitViewController: HealthKitEnabledViewController {

    @IBOutlet weak var allowAccessButton: UIButton!
    
    @IBAction func allowAccess(_ sender: UIButton) {
        
        print("Hit the button.")
        
        guard HKHealthStore.isHealthDataAvailable() else {
            print("HealthKit not available.")
            return
        }
        
        let readDataTypes: Set<HKObjectType> = dataTypesToRead()
        
        let completion: ((Bool, Error?) -> Void)! = {
            (success, error) -> Void in
            
            if !success {
                print("You didn't allow HealthKit to access these read/write data types. In your app, try to handle this error gracefully when a user decides not to provide access. The error was: \(error). If you're using a simulator, try it on a device.")
                return
            }

        }
 
        healthKitStore.requestAuthorization(toShare: nil, read: readDataTypes, completion: completion)
     
        
        self.performSegue(withIdentifier: "WizardSegue4", sender: nil)

    }

    // MARK: Private methods
    // MARK: HealthKit Permissions
    
    private func dataTypesToRead() -> Set<HKObjectType> {
        
        let biologicalSexType = HKQuantityType.characteristicType(forIdentifier: .biologicalSex)!
        let dateOfBirthType = HKQuantityType.characteristicType(forIdentifier: .dateOfBirth)!
        let bodyMassType = HKQuantityType.quantityType(forIdentifier: .bodyMass)!
        
        let readDataTypes: Set<HKObjectType> = [biologicalSexType, dateOfBirthType, bodyMassType]
        
        return readDataTypes
        
        //        Interesting:
        //
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
    }

    
    // MARK: - Navigation


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //if segue.identifier == "WizardSegue3" {
        //    let profileSetup = segue.destination as? ProfileSetupViewController
        //    profileSetup?.healthKitStore = self.healthKitStore
        //}
        
        if segue.identifier == "WizardSegue4" {
            let profileSetup = segue.destination as? ProfileSetupViewController
            //var v = profileSetup?.view
            profileSetup?.setup()
        }
    }

    
}
