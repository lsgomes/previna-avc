//
//  RiskFactors.swift
//  Previna AVC
//
//  Created by Lucas Dos Santos Gomes on 3/30/17.
//  Copyright © 2017 Lucas Dos Santos Gomes. All rights reserved.
//

enum RiskFactor: String {
    
    // MARK: Non-modifiable risk factors
    case MALE = "Male"
    case HYPERTENSION = "Hypertension"
    case DIABETES = "Diabetes"
    case RENAL_DISEASE = "Renal_disease"
    case PERIPHERAL_DISEASE = "Peripheral_arterial_disease"
    case HEART_FAILURE = "Congestive_heart_failure"
    case ISCHEMIC_HEART_DISEASE = "Ischemic_heart_disease"
    
    // MARK: Physical_activity
    case INACTIVE = "Inactive"
    case ACTIVE = "Active"
    case VERY_ACTIVE = "Very_active"
    
    
    // MARK: Alcohol_consumption
    case ABSTAIN = "Abstain"
    case DRINKER = "Drinker"
    case FORMER_ALCOHOLIC = "Former_alcoholic"
    case DRINK_IN_MODERATION = "Drink_in_moderation"
    
    // MARK: Smoking_status
    case SMOKER = "Smoker"
    case FORMER_SMOKER = "Former_smoker"
    case NEVER_SMOKED = "Never_smoked"
    
    // MARK: Education
    case HIGH_SCHOOL_DIPLOMA = "High_school_diploma_and_some_college"
    case NO_HIGH_SCHOOL_DIPLOMA = "No_high_school_diploma"
    
    // MARK: Psychological_factors
    case CRY_EASILY = "Cry_easily"
    case CRITICAL_OF_OTHERS = "Critical_of_others"
    case FEARFUL = "Fearful"
    
    case NOT_CRYING_EASILY = "Not_crying_easily"
    case NOT_CRITICAL_OF_OTHERS = "Not_critical_of_others"
    case NOT_FEARFUL = "Not_fearful"

}
